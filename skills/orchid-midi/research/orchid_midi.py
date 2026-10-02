#!/usr/bin/env python3
"""Historical offline packet builders and a compatibility CLI launcher.

The public CLI delegates to orchid_midi_cli, using python-rtmidi on all platforms.
No CoreMIDI ctypes or hardware I/O remains in this file. Old transport schedules
and the blocked service packet are retained only for offline reproducibility.
The service packet caused a loud sustained tone on hardware; never transmit it.
Capture records can be CoreMIDI packets rather than complete MIDI messages.
"""
import json
import math
import struct

SOUND_FX_PARAMETERS = {"reverb": 114, "filter": 68, "phaser": 102, "chorus": 109}
READ_ONLY_QUERIES = {"query-sound": 0x51, "query-bass": 0x53,
                     "query-chord-voicing": 0x52, "query-bass-voicing": 0x55}
VOICING_CONTROLS = {"chord-voicing": (0x45, 1, 60), "bass-voicing": (0x46, 0, 48)}
# Experimental replay of observed outgoing panel reports. These are NOT
# established setters: stock 3.92's CC receiver appears to ignore them.
PANEL_CC_PROBES = {"probe-perform-cc": 103, "probe-key-cc": 107,
                   "probe-key-enable-cc": 108, "probe-bpm-cc": 112}
TRANSPORT_PROBES = {"probe-start": b"\xfa", "probe-stop": b"\xfc",
                    "probe-bpm-press": b"\xfc\xfa", "probe-continue": b"\xfb",
                    # Observed on selecting Disco at 87 BPM; no beat ID.
                    "probe-beat-selection": bytes.fromhex("fc b0 70 57 fa")}
CLOCK_PROBES = {"probe-start-clock": 0xFA, "probe-continue-clock": 0xFB}
STOCK_392_IDENTITY = bytes.fromhex("f0 7e 7f 06 02 00 22 0c 01 01 00 00 33 2e 09 02 f7")


def stock_service_probe_packet(magic=0xC0DEAFFE):
    """Fixed stock 3.92 function call: movs r0,#3; bx lr at 0x0803049c.

    OFFLINE EVIDENCE ONLY: this packet caused a loud sustained tone on hardware.
    The magic override exists only for offline negative tests. Never transmit it.
    """
    payload = bytearray(133)
    struct.pack_into("<II", payload, 0, 0x0803049D, magic)
    packed = bytearray()
    for offset in range(0, 133, 7):
        group = payload[offset:offset + 7]
        packed.extend(value >> 1 for value in group)
        packed.append(sum((value & 1) << bit for bit, value in enumerate(group)))
    body = bytes.fromhex("00 22 0c 01 7f 73 00 00 00 00") + packed
    return b"\xf0" + body + bytes([(-sum(body)) & 127, 0xF7])


def clock_probe_schedule(status, bpm, seconds):
    """Clock for one quarter note before transport, then a bounded play window.

    Times are relative seconds; callers must schedule them with CoreMIDI host
    timestamps. Stop follows the final clock tick. No settings are written.
    """
    if status not in (0xFA, 0xFB) or not 30 <= bpm <= 240 or not 1 <= seconds <= 30:
        raise ValueError("Clock probe requires Start/Continue, BPM 30–240, and 1–30 seconds")
    interval = 60 / (bpm * 24)
    count = math.ceil(seconds / interval)
    events = [(i * interval, b"\xf8") for i in range(24)]
    start = 24 * interval
    events.append((start, bytes([status])))
    events.extend((start + (i + 1) * interval, b"\xf8") for i in range(count))
    events.append((start + (count + 1) * interval, b"\xfc"))
    return events


def vendor_packet(command, payload):
    body = bytes([0, 0x22, 0x0C, 1, command, *payload])
    if any(value >= 128 for value in body):
        raise ValueError("SysEx data must be 7-bit")
    return b"\xf0" + body + bytes([(-sum(body)) & 127, 0xF7])


def main():
    # Historical packet builders above remain for offline research only.
    # All CLI calls now use the same portable installed implementation.
    import sys
    from pathlib import Path
    sys.path.insert(0, str(Path(__file__).resolve().parents[1] / "src"))
    from orchid_midi_cli.cli import main as portable_main
    raise SystemExit(portable_main())


if __name__ == "__main__":
    main()
