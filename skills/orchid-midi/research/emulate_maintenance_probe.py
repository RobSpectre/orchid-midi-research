#!/usr/bin/env python3
"""Offline-only execution of Orchid's stock SysEx handler in Unicorn.

LIVE FAILURE: this packet caused a loud sustained tone and required reboot.
Emulator success did not establish hardware safety. Do not transmit this packet.

No CoreMIDI, USB, serial, subprocess, or device access. The historical probe calls
an existing four-byte stock-firmware function that returns 3. The packet only
contains its address and the maintenance gate value, with no uploaded code,
flash write, or separate RAM-page write. This is an emulator result, not
authorization or proof of live safety.
"""
import hashlib
import json
import struct
import sys
from pathlib import Path
from orchid_midi import stock_service_probe_packet

ROOT = Path(__file__).resolve().parent
sys.path.insert(0, str(ROOT / "vendor"))
from unicorn import Uc, UC_ARCH_ARM, UC_MODE_THUMB, UC_MODE_MCLASS, UC_HOOK_CODE, UC_HOOK_MEM_WRITE
from unicorn.arm_const import (UC_CPU_ARM_CORTEX_M7, UC_ARM_REG_SP,
                               UC_ARM_REG_LR, UC_ARM_REG_PC, UC_ARM_REG_R0,
                               UC_ARM_REG_R1, UC_ARM_REG_XPSR)

BASE = 0x08020000
IMAGE_SHA256 = "bc5e8597244a3b7ddbcc2fa0379b48d33d37e668c94d7dd1244e77c560e3936f"
HANDLER = 0x08045D58
USB_READ = 0x08045C00
MIDI_SEND = 0x0802EEA0
LENGTH = 0x2404FB00
INPUT = 0x2404FB04
STAGING = 0x2404FC04
PROBE_ENTRY = 0x0803049C
MAGIC = 0xC0DEAFFE
RETURN_SENTINEL = BASE + 0x40


def verified_image():
    data = (ROOT / "orchid-3.92.bin").read_bytes()
    if hashlib.sha256(data).hexdigest() != IMAGE_SHA256:
        raise ValueError("This audit only applies to the verified public 3.92 image")
    if data[PROBE_ENTRY - BASE:PROBE_ENTRY - BASE + 4] != bytes.fromhex("03 20 70 47"):
        raise ValueError("Stock constant-return function differs from the audited image")
    return data


def probe_packet(magic=MAGIC):
    # Reconstruct the historical failed probe, now blocked by the CLI.
    packet = stock_service_probe_packet(magic)
    assert len(packet) == 165 and sum(packet[1:-1]) % 128 == 0
    return packet


def emulate(packet):
    firmware = verified_image()
    uc = Uc(UC_ARCH_ARM, UC_MODE_THUMB | UC_MODE_MCLASS)
    uc.ctl_set_cpu_model(UC_CPU_ARM_CORTEX_M7)
    for address, length in ((BASE, 0x80000), (0, 0x10000),
                            (0x20000000, 0x20000), (0x24000000, 0x80000),
                            (0x38000000, 0x10000)):
        uc.mem_map(address, length)
    uc.mem_write(BASE, firmware)
    uc.mem_write(0, firmware[0x2CC:0x2CC + 0x6B78])
    uc.mem_write(INPUT, packet)
    uc.mem_write(LENGTH, bytes([len(packet)]))
    uc.reg_write(UC_ARM_REG_SP, 0x2001F000)
    uc.reg_write(UC_ARM_REG_LR, RETURN_SENTINEL | 1)
    uc.reg_write(UC_ARM_REG_XPSR, 0x01000000)
    sent = []
    writes = []
    probe_instructions = []
    visited = set()
    returned = False

    def code_hook(cpu, address, size, _):
        nonlocal returned
        visited.add(address)
        if address == RETURN_SENTINEL:
            returned = True
            cpu.emu_stop()
        elif address == USB_READ:
            # Replace only the physical USB packet-pump boundary. The stock
            # parser, checksum, unpacker, gate, BLX, and response code execute.
            cpu.reg_write(UC_ARM_REG_R0, len(packet))
            cpu.reg_write(UC_ARM_REG_PC, cpu.reg_read(UC_ARM_REG_LR))
        elif address == MIDI_SEND:
            data = cpu.mem_read(cpu.reg_read(UC_ARM_REG_R0), cpu.reg_read(UC_ARM_REG_R1))
            sent.append(bytes(data).hex(" "))
            cpu.reg_write(UC_ARM_REG_R0, 0)
            cpu.reg_write(UC_ARM_REG_PC, cpu.reg_read(UC_ARM_REG_LR))
        elif PROBE_ENTRY <= address < PROBE_ENTRY + 4:
            probe_instructions.append({"address": hex(address), "hex": bytes(cpu.mem_read(address, size)).hex(" ")})
        elif STAGING <= address < STAGING + 133:
            raise AssertionError("This probe must not execute uploaded RAM content")

    def write_hook(cpu, access, address, size, value, _):
        # Stack and the existing SysEx input/unpack buffers are the complete
        # expected write set for this proposed read-only probe.
        stack = 0x2001E000 <= address and address + size <= 0x20020000
        protocol_buffer = LENGTH <= address and address + size <= STAGING + 133
        if not (stack or protocol_buffer):
            raise AssertionError(f"Unexpected memory write: {address:#x}, {size} bytes")
        writes.append((address, size))

    uc.hook_add(UC_HOOK_CODE, code_hook)
    uc.hook_add(UC_HOOK_MEM_WRITE, write_hook)
    uc.emu_start(HANDLER | 1, RETURN_SENTINEL, timeout=2_000_000, count=50_000)
    # Unicorn can stop at the supplied until address before invoking the hook.
    returned = returned or uc.reg_read(UC_ARM_REG_PC) == RETURN_SENTINEL
    if not returned:
        raise AssertionError("Handler did not return normally")
    return {
        "handler_returned": returned,
        "responses": sent,
        "probe_instructions": probe_instructions,
        "stock_indirect_call_reached": 0x080462FC in visited,
        "flash_program_path_reached": 0x0804570C in visited or 0x080456F8 in visited,
        "memory_write_count": len(writes),
        "writes_confined_to_stack_and_sysex_buffers": True,
    }


def main():
    positive = emulate(probe_packet())
    rejected = emulate(probe_packet(magic=0))
    bad_checksum = bytearray(probe_packet())
    bad_checksum[-2] ^= 1
    invalid = emulate(bytes(bad_checksum))
    assert positive["responses"] == ["f0 00 22 0c 01 78 03 f7"], positive
    assert positive["stock_indirect_call_reached"]
    assert len(positive["probe_instructions"]) == 2
    assert not positive["flash_program_path_reached"]
    assert rejected["responses"] == ["f0 00 22 0c 01 78 02 f7"], rejected
    assert not rejected["stock_indirect_call_reached"]
    assert not invalid["stock_indirect_call_reached"]
    report = {
        "firmware_sha256": IMAGE_SHA256,
        "hardware_access": False,
        "uploaded_code": False,
        "stock_probe_function": {"address": hex(PROBE_ENTRY),
                                  "instructions": ["movs r0, #3", "bx lr"]},
        "packet_bytes": len(probe_packet()),
        "packet_hex_for_review_only": probe_packet().hex(" "),
        "valid_probe": positive,
        "invalid_gate": rejected,
        "invalid_checksum": invalid,
        "limitations": [
            "The physical USB boundary and outgoing MIDI sender are mocked.",
            "The emulator does not reproduce Orchid's live MPU, caches, interrupt activity, or all hardware state.",
            "No packet has been sent to the device; a live test could still fault and require a power cycle.",
            "Returning a constant establishes no encoder or transport control by itself.",
        ],
    }
    target = ROOT.parent / "captures/maintenance-probe-offline.json"
    target.write_text(json.dumps(report, indent=2) + "\n")
    print(json.dumps({"report": str(target), "valid_probe": positive,
                      "invalid_gate_rejected": not rejected["stock_indirect_call_reached"],
                      "invalid_checksum_rejected": not invalid["stock_indirect_call_reached"]}, indent=2))


if __name__ == "__main__":
    main()
