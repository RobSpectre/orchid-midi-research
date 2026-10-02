#!/usr/bin/env python3
"""Reproduce the offline USB MIDI/CDC reachability audit for stock Orchid 3.92.

Reads only the saved public firmware and writes research artifacts. It never
opens USB, MIDI, or serial endpoints and never changes the attached instrument.
"""
import hashlib
import json
import re
import struct
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parent
sys.path.insert(0, str(ROOT / "vendor"))
from capstone import Cs, CS_ARCH_ARM, CS_MODE_THUMB

BASE = 0x08020000
SHA256 = "bc5e8597244a3b7ddbcc2fa0379b48d33d37e668c94d7dd1244e77c560e3936f"


def main():
    data = (ROOT / "orchid-3.92.bin").read_bytes()
    assert hashlib.sha256(data).hexdigest() == SHA256

    def flash32(address):
        return struct.unpack_from("<I", data, address - BASE)[0]

    ram_start, ram_end, ram_load = [flash32(a) for a in (0x0803F64C, 0x0803F650, 0x0803F654)]
    assert (ram_start, ram_end, ram_load) == (0x24000000, 0x24003E04, 0x0808F3CC)

    def read(address, size):
        if 0 <= address < 0x6B78:
            address += BASE + 0x2CC
        elif ram_start <= address < ram_end:
            address = ram_load + address - ram_start
        offset = address - BASE
        assert 0 <= offset and offset + size <= len(data)
        return data[offset:offset + size]

    def word(address):
        return struct.unpack("<I", read(address, 4))[0]

    def configuration(address):
        header = read(address, 9)
        assert header[:2] == b"\x09\x02"
        size = int.from_bytes(header[2:4], "little")
        raw = read(address, size)
        interfaces = []
        offset = 0
        while offset < size:
            length, kind = raw[offset:offset + 2]
            assert length >= 2 and offset + length <= size
            chunk = raw[offset:offset + length]
            if kind == 4:
                interfaces.append({"number": chunk[2], "alternate": chunk[3],
                                   "endpoint_count": chunk[4], "class": chunk[5],
                                   "subclass": chunk[6], "protocol": chunk[7], "endpoints": []})
            elif kind == 5:
                interfaces[-1]["endpoints"].append({"address": hex(chunk[2]),
                    "transfer_type": chunk[3] & 3, "max_packet_bytes": int.from_bytes(chunk[4:6], "little")})
            offset += length
        return {"runtime_address": hex(address), "total_bytes": size,
                "configuration_value": header[5], "interfaces": interfaces}

    md = Cs(CS_ARCH_ARM, CS_MODE_THUMB)
    md.skipdata = True
    instructions = []
    for start, length in ((0, 0x6B78), (0x08026E44, 0x080493A4 - 0x08026E44)):
        instructions.extend(md.disasm(read(start, length), start))
    init_calls = []
    buffer_refs = []
    for index, ins in enumerate(instructions):
        if ins.mnemonic in ("bl", "b.w") and ins.op_str == "#0x802ee14":
            context = instructions[max(0, index - 5):index + 1]
            init_calls.append({"address": hex(ins.address),
                               "preceding_instructions": [f"{i.address:#x}: {i.mnemonic} {i.op_str}" for i in context]})
        if not ins.mnemonic.startswith("ldr"):
            continue
        match = re.search(r"\[pc, #(-?0x[0-9a-f]+|\d+)\]", ins.op_str)
        if match:
            literal = ((ins.address + 4) & ~3) + int(match[1], 0)
            try:
                target = word(literal)
            except (AssertionError, struct.error):
                continue
            if target in (0x380035AC, 0x380035B0):
                buffer_refs.append({"instruction": hex(ins.address), "target": hex(target)})
    assert [r["address"] for r in init_calls] == ["0x802f158", "0x803f9c2"]
    assert word(0x0804B11C) == 0  # Active MIDI class's Setup callback.
    assert word(0x24000054) == 0x080301D5  # Inactive CDC class's Setup.
    assert word(0x240000F8) == 0x08030611  # CDC application's receive callback.
    # The two callers explicitly choose MIDI (r0=0). No exact stored pointer
    # to the mode initializer was found, but this is not formal reachability.
    pointer_refs = [hex(BASE + m.start()) for m in re.finditer(re.escape(struct.pack("<I", 0x0802EE15)), data)]
    report = {
        "firmware_sha256": SHA256, "hardware_access": False,
        "initialized_data_copy": {"flash_source": hex(ram_load), "ram_start": hex(ram_start), "ram_end": hex(ram_end)},
        "midi_configuration": configuration(0x0804B0AC),
        "cdc_configuration": configuration(0x24000008),
        "mode_initializer": {"address": "0x0802ee14", "mode_byte": "0x38001051",
                             "mode_0": "MIDI", "mode_1": "CDC serial", "direct_callers": init_calls,
                             "stored_function_pointer_occurrences": pointer_refs},
        "cdc_receive": {"callback": "0x08030610", "write_index": "0x380035ac", "buffer": "0x380035b0",
                        "direct_literal_references": buffer_refs,
                        "behavior": "Copies bytes to a wrapping receive buffer and rearms USB reception; no command parsing in the callback.",
                        "consumer_found": False},
        "usb_control_requests": {"active_midi_setup_callback": None, "inactive_cdc_setup_callback": "0x080301d4",
            "device_request_class_or_vendor_path": "0x0802f964 forwards to class Setup callback without a null check.",
            "interface_request_path": "0x0802fcce checks the null Setup callback and returns status 3.",
            "conclusion": "No separate vendor-control command handler is installed by the active MIDI class. Blind device-recipient vendor requests could fault at the null callback and were not sent."},
        "maintenance_route": {"transport": "Vendor SysEx over USB MIDI", "command": "0x73 in the 0x7f envelope",
            "input_unpack_buffer": "0x2404fc04", "unpacked_bytes": 133,
            "behavior": "Checks a marker, calls the function address in the unpacked payload, and returns a byte.",
            "offline_probe": "maintenance-probe-offline.json", "live_probe_sent": False,
            "conclusion": "A distinct stock maintenance execution mechanism exists; it is not a discovered normal encoder command."},
        "conclusion": "CDC support exists but normal initialization chooses MIDI. No reachable CDC command consumer or active non-MIDI USB control API was established. A bounded stock-function diagnostic through the MIDI maintenance path succeeds in offline emulation.",
        "limitations": ["Firmware is a public image matching the reported version, not a dump of device flash.",
                        "Direct calls, literal references and callback tables were traced; computed pointers or aliases are not exhaustively proven absent.",
                        "No device re-enumeration, vendor request, or maintenance command was transmitted."]
    }
    target = ROOT.parent / "captures/usb-route-audit.json"
    target.write_text(json.dumps(report, indent=2) + "\n")
    ranges = [(0x0802EE14, 0x0802EEA0), (0x0802F150, 0x0802F160),
              (0x0803F9BC, 0x0803F9CE), (0x08030574, 0x080306D0),
              (0x0802F900, 0x0802F980), (0x0802FC7C, 0x0802FCFC)]
    lines = ["; Offline stock 3.92 trace. Literal pools and tables can decode as instructions."]
    for start, end in ranges:
        lines.append(f"; range {start:#x}–{end:#x}")
        for ins in md.disasm(read(start, end - start), start):
            lines.append(f"{ins.address:08x}: {ins.mnemonic:10} {ins.op_str}")
    (ROOT / "usb-route-audit.asm").write_text("\n".join(lines) + "\n")
    print(json.dumps({"report": str(target), "conclusion": report["conclusion"]}, indent=2))


if __name__ == "__main__":
    main()
