#!/usr/bin/env python3
"""Reproduce the offline Orchid 3.92 USB-MIDI receiver audit.

Never imports CoreMIDI, opens a device, or transmits the firmware blob.
Requires Capstone in research/vendor (python -m pip install --target ... capstone).
The decoder uses the format of this particular official image, not a universal
Orchid firmware format. All frames' 7-bit checksums and page sequencing are checked.
"""
import hashlib
import json
import struct
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parent
sys.path.insert(0, str(ROOT / "vendor"))
from capstone import Cs, CS_ARCH_ARM, CS_MODE_THUMB

BASE = 0x08020000
ITCM_LOAD = 0x080202CC


def decode_image(blob):
    frames, pauses, pages = [], [], []
    offset = 0
    while offset < len(blob):
        if blob[offset] != 0xF0:
            pauses.append(blob[offset])
            offset += 1
            continue
        end = blob.index(0xF7, offset)
        frame = blob[offset:end + 1]
        offset = end + 1
        if not frame.startswith(bytes.fromhex("f0 54 6c 70 01 7f")):
            raise ValueError("Unexpected update frame header")
        if any(x > 127 for x in frame[1:-1]) or sum(frame[1:-1]) % 128:
            raise ValueError("Invalid update frame checksum/data")
        frames.append(frame)
        if frame[6] not in (0x70, 0x75):
            continue
        if len(frame) != 165 or frame[7] != 0 or frame[10] != frame[8]:
            raise ValueError("Unrecognized page framing")
        page = frame[8] + 128 * frame[9]
        if page != 1024 + len(pages):
            raise ValueError("Non-contiguous firmware page")
        unpacked = bytes((v << 1) | ((frame[j + 7] >> k) & 1)
                         for j in range(11, 163, 8)
                         for k, v in enumerate(frame[j:j + 7]))
        # 128 image bytes; retain the original blob for its five decoded trailer
        # bytes, whose full semantics are not needed by this code-only audit.
        pages.append(unpacked[:128])
    image = b"".join(pages)
    if struct.unpack_from("<2I", image) != (0x20020000, 0x0803F5C1):
        raise ValueError("Unexpected Cortex-M vector table/version")
    return image, {"frames": len(frames), "image_pages": len(pages),
                   "pause_bytes": pauses, "frame_checksums_valid": True,
                   "contiguous_pages": True}


def main():
    blob_path = ROOT / "orchid-3.92.blob"
    blob = blob_path.read_bytes()
    image, checks = decode_image(blob)
    (ROOT / "orchid-3.92.bin").write_bytes(image)

    def read(address, size):
        flash = ITCM_LOAD + address if address < 0x6B78 else address
        offset = flash - BASE
        if offset < 0 or offset + size > len(image):
            raise ValueError(f"Unmapped address {address:#x}")
        return image[offset:offset + size]

    def u32(address):
        return struct.unpack("<I", read(address, 4))[0]

    # Verify the reset-handler literal mapping before using ITCM addresses.
    if (u32(0x0803F658), u32(0x0803F65C), u32(0x0803F660)) != (ITCM_LOAD, 0, 0x6B78):
        raise ValueError("ITCM startup copy mapping changed")
    if u32(0x080490BC) != 0x51CD or u32(0x080490CC) != 0x4AE9:
        raise ValueError("Known MIDI receiver/setter veneers changed")

    def byte_table(address, first, count):
        return {str(first + i): f"0x{address + 2 * v:08x}"
                for i, v in enumerate(read(address, count))}

    cc = byte_table(0x4C52, 98, 26)
    cin = byte_table(0x08045C1C, 4, 12)
    table_address = 0x08045DE6
    sysex = {f"0x{0x34 + i:02x}": f"0x{table_address + 2 * v:08x}"
             for i, v in enumerate(struct.unpack("<76H", read(table_address, 152)))}
    if any(cc[str(c)] != "0x00004c86" for c in range(100, 120)):
        raise ValueError("Unexpected panel-CC receive branch")
    if sysex["0x47"] != "0x080460d6" or sysex["0x35"] != "0x080461e8":
        raise ValueError("Known vendor command mapping changed")

    md = Cs(CS_ARCH_ARM, CS_MODE_THUMB)
    md.skipdata = True
    tables = [(0x4C52, 0x4C6C), (0x08045C1C, 0x08045C28),
              (table_address, table_address + 152)]
    ranges = {
        "midi-usb-receiver": [(0x08045C00, 0x08045CD8)],
        "midi-channel-receiver": [(0x51CC, 0x5248)],
        "midi-cc-receiver": [(0x4C30, 0x4D78)],
        "midi-sysex-receiver": [(0x08045D58, 0x08046334)],
        "parameter-setter": [(0x08032148, 0x0803218C), (0x4AE8, 0x4C30)],
        "voicing-setter": [(0x080347D4, 0x08034898)],
        "display-maintenance": [(0x0803FEB0, 0x08040008)],
    }
    for name, sections in ranges.items():
        lines = ["; Offline disassembly. Literal pools may decode as instructions.",
                 "; Recognized jump-table data is explicitly identified below."]
        for start, end in sections:
            for ins in md.disasm(read(start, end - start), start):
                is_table = any(lo <= ins.address < hi for lo, hi in tables)
                body = f".table {ins.bytes.hex(' ')}" if is_table else f"{ins.mnemonic:10} {ins.op_str}"
                lines.append(f"{ins.address:08x}: {body}")
        (ROOT / f"{name}.asm").write_text("\n".join(lines) + "\n")

    command_labels = {
        "0x34": "Bulk Sound synth parameters", "0x35": "Sound preset selection",
        "0x36": "Save user Sound including performance metadata (persistent write)",
        "0x3e": "Bulk Bass synth parameters", "0x3f": "Bass preset selection",
        "0x43": "Toggle Bass enable", "0x45": "Absolute chord voicing",
        "0x46": "Absolute Bass voicing", "0x47": "Synth parameter setter",
        "0x48": "Toggle FX lock", "0x50": "Sound slot inquiry",
        "0x51": "Current Sound inquiry", "0x52": "Chord voicing inquiry",
        "0x53": "Bass-related inquiry sequence", "0x54": "Current Bass inquiry",
        "0x55": "Bass voicing inquiry", "0x56": "Fixed five-byte response",
        "0x71": "Maintenance RAM block write (not transmitted)",
        "0x72": "Maintenance storage erase/program path (not transmitted)",
        "0x73": "Maintenance indirect function call guarded by a magic value (not transmitted)",
        "0x76": "Draw text on display (not transmitted)",
        "0x77": "Call boot entry pointer (not transmitted)",
        "0x7a": "Write display framebuffer page (not transmitted)",
        "0x7b": "Read display framebuffer page or change display reporting (not transmitted)",
    }
    report = {
        "date": "2026-10-01", "firmware": "3.92", "device_version_user_report": "v3.9.2",
        "source_page": "https://firmware.telepathicinstruments.com/",
        "image_url": "https://cdn.sanity.io/files/ij4eboar/production/c6585b740c8c70f1af4b6efd3166d8d44f0b59e9.blob",
        "blob_sha256": hashlib.sha256(blob).hexdigest(),
        "decoded_image_sha256": hashlib.sha256(image).hexdigest(),
        "decoded_image_bytes": len(image), "flash_base": hex(BASE),
        "itcm_load_address": hex(ITCM_LOAD), "itcm_length": "0x6b78",
        "validation": checks,
        "live_commands_sent_this_audit": [], "firmware_modified": False,
        "conclusion": "No normal USB-MIDI command for independent Perform, Key, Loop, BPM, Options, or panel master Volume was found in this matching stock receiver. This is not a claim that arbitrary maintenance memory manipulation could never reach those states.",
        "targets": {
            "Perform": "No independent receiver branch. Sound selection can load stored performance metadata; saving/editing such metadata is not an independent transient Perform setter.",
            "Key": "No harmonic-key or Key-enable setter in the inspected channel/SysEx dispatch.",
            "Loop": "USB realtime path only appends to an in-progress SysEx buffer; channel receiver has no Start/Continue/Stop or loop operation.",
            "BPM": "No MIDI Clock or tempo setter in this USB receiver. Firmware tempo setter exists at 0x08034c18, but this is not a MIDI command.",
            "Options": "No encoder navigation/press dispatcher among normal MIDI commands. Maintenance display writes change framebuffer content, not the underlying menu setting.",
            "master Volume": "CC 7 exits the CC handler without a write. Universal realtime master-volume SysEx header 0x7f is not accepted as a manufacturer. Sound gain/global DSP parameters are not proven panel master-volume controls."
        },
        "cc_below_98_handled": {"1": "Modulation", "6": "NRPN Data Entry (indices <=134, engines <=2)", "64": "Sustain"},
        "cc_98_to_123_table": cc, "cc_above_123": "return without action",
        "cc_note": "CC 100–119 all return without action, including CC 115/116 voicing reports and CC 118 FX-lock report. Outbound reports are not symmetric input controls.",
        "usb_cin_table": cin, "sysex_command_table": sysex,
        "sysex_command_annotations": command_labels,
        "sysex_dispatch_notes": [
            "Commands below 0x34 or above 0x7f reach the unknown-command path; table includes every command in between.",
            "A 0x7f envelope selects the command from the next byte and returns to the same table; it is not a second panel API.",
            "Unknown/default commands do not invoke an encoder dispatcher.",
            "Maintenance commands are deliberately excluded from the sender and were not tested live."
        ],
        "additional_rotary_controls": {
            "chord_voicing": {"command": "0x45", "payload": "one absolute value", "bounds": [1,60], "setter": "0x080347d4", "hardware_tested_this_audit": False},
            "bass_voicing": {"command": "0x46", "payload": "one absolute value", "bounds": [0,48], "setter": "0x080347d4", "hardware_tested_this_audit": False}
        },
        "limitations": [
            "Static audit of one public firmware image matching the reported version; device flash was not dumped.",
            "Jump tables and direct paths were inspected, not formal whole-program verification of all possible memory states or indirect calls.",
            "The page decoder preserves the original blob; five decoded trailer bytes per page are not semantically interpreted.",
            "No new hardware control is claimed solely from disassembly."
        ]
    }
    destination = ROOT.parent / "captures/stock-midi-receiver-audit.json"
    destination.write_text(json.dumps(report, indent=2) + "\n")
    print(json.dumps({"report": str(destination), "validation": checks,
                      "image_sha256": report["decoded_image_sha256"]}, indent=2))


if __name__ == "__main__":
    main()
