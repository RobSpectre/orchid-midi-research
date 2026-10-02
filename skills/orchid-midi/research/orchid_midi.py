#!/usr/bin/env python3
"""macOS CoreMIDI capture and narrowly scoped Orchid controls.

Exposes scoped Sound (001/002), Bass (007/008), captured Sound FX writes,
absolute chord/bass voicing controls and read-only voicing queries.
Phaser/Chorus edit FX1/FX2 parameter 2; these effect types must already be selected.
Actions prefixed probe- replay outgoing panel/transport reports for experiments;
they are not supported setters. Stock firmware ignored the tested incoming reports.
The stock-service probe is DISABLED: its live test caused a loud sustained tone
and required a reboot. Its packet builder remains only for offline analysis.
There are no save-slot, bulk-write, arbitrary replay, or flash-writing operations.
Capture records are raw CoreMIDI packets, not necessarily complete MIDI messages.
"""
import argparse
import ctypes as C
import json
import math
import queue
import struct
import time
from datetime import datetime, timezone

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
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("action", choices=["list", "listen", "identity", "sound", "bass", "probe-mmc-playback", "probe-stock-service", *SOUND_FX_PARAMETERS, *READ_ONLY_QUERIES, *VOICING_CONTROLS, *PANEL_CC_PROBES, *TRANSPORT_PROBES, *CLOCK_PROBES])
    parser.add_argument("value", nargs="?", type=int, help="Sound 1/2, Bass 7/8, Sound FX 0–127, chord voicing 1–60, bass voicing 0–48 (raw)")
    parser.add_argument("--dry-run", action="store_true", help="Print packet without opening CoreMIDI")
    parser.add_argument("--name", default="Orchid", help="Exact endpoint name")
    parser.add_argument("--seconds", type=float, default=5)
    parser.add_argument("--clock-bpm", type=float, default=87, help="Clock probe tempo, 30–240 BPM")
    args = parser.parse_args()
    if args.action == "probe-stock-service":
        parser.error("DISABLED: live maintenance probe caused a loud sustained tone and required reboot; offline evidence only")
    if not 0 < args.seconds <= 3600:
        parser.error("--seconds must be in (0, 3600]")
    data = None
    schedule = None
    if args.action in CLOCK_PROBES:
        try:
            schedule = clock_probe_schedule(CLOCK_PROBES[args.action], args.clock_bpm, args.seconds)
        except ValueError as exc:
            parser.error(str(exc))
    elif args.action == "probe-mmc-playback":
        if not 1 <= args.seconds <= 15:
            parser.error("MMC probe requires 1–15 seconds per playback window")
        # Universal realtime MMC, broadcast device ID: Play, Stop,
        # Deferred Play, Stop. Never sends record, erase, or reset.
        schedule = [(0, bytes.fromhex("f0 7f 7f 06 02 f7")),
                    (args.seconds, bytes.fromhex("f0 7f 7f 06 01 f7")),
                    (args.seconds + 1, bytes.fromhex("f0 7f 7f 06 03 f7")),
                    (args.seconds * 2 + 1, bytes.fromhex("f0 7f 7f 06 01 f7"))]
    if args.action == "sound":
        if args.value not in (1, 2):
            parser.error("Sound control is limited to the observed factory presets 1 and 2")
        data = vendor_packet(0x35, [args.value - 1])
    elif args.action == "bass":
        if args.value not in (7, 8):
            parser.error("Bass control is limited to the test presets 7 and 8")
        data = vendor_packet(0x3F, [args.value - 1])
    elif args.action in SOUND_FX_PARAMETERS:
        if args.value is None or not 0 <= args.value <= 127:
            parser.error("Sound FX needs a raw value in 0–127")
        parameter = SOUND_FX_PARAMETERS[args.action]
        data = vendor_packet(0x47, [0, parameter, 0, args.value])
    elif args.action == "identity":
        data = bytes.fromhex("f0 7e 7f 06 01 f7")
    elif args.action in TRANSPORT_PROBES:
        data = TRANSPORT_PROBES[args.action]
    elif args.action in READ_ONLY_QUERIES:
        data = vendor_packet(READ_ONLY_QUERIES[args.action], [])
    elif args.action in VOICING_CONTROLS:
        command, minimum, maximum = VOICING_CONTROLS[args.action]
        if args.value is None or not minimum <= args.value <= maximum:
            parser.error(f"{args.action} needs an absolute raw value in {minimum}–{maximum}")
        data = vendor_packet(command, [args.value])
    elif args.action in PANEL_CC_PROBES:
        if args.value is None or not 0 <= args.value <= 127:
            parser.error("Experimental CC replay needs a 7-bit value in 0–127")
        if args.action == "probe-key-enable-cc" and args.value not in (0, 127):
            parser.error("Key enable report replay is limited to 0 or 127")
        data = bytes([0xB0, PANEL_CC_PROBES[args.action], args.value])
    if args.value is not None and args.action not in ("sound", "bass", *SOUND_FX_PARAMETERS, *VOICING_CONTROLS, *PANEL_CC_PROBES):
        parser.error("This action does not take a value")
    if args.dry_run:
        preview = {"action": args.action, "hex": data.hex(" ") if data else None}
        if schedule:
            preview.update(clock_bpm=args.clock_bpm if args.action in CLOCK_PROBES else None,
                           schedule=[{"seconds": t, "hex": packet.hex(" ")} for t, packet in schedule])
        print(json.dumps(preview))
        return
    midi = C.CDLL("/System/Library/Frameworks/CoreMIDI.framework/CoreMIDI")
    cf = C.CDLL("/System/Library/Frameworks/CoreFoundation.framework/CoreFoundation")
    u32, ptr = C.c_uint32, C.c_void_p

    def bind(lib, name, result, *params):
        fn = getattr(lib, name)
        fn.restype, fn.argtypes = result, list(params)
        return fn

    cfstr = bind(cf, "CFStringCreateWithCString", ptr, ptr, C.c_char_p, u32)
    release = bind(cf, "CFRelease", None, ptr)
    getstr = bind(cf, "CFStringGetCString", C.c_bool, ptr, ptr, C.c_long, u32)
    getprop = bind(midi, "MIDIObjectGetStringProperty", C.c_int32, u32, ptr, C.POINTER(ptr))
    create = bind(midi, "MIDIClientCreate", C.c_int32, ptr, ptr, ptr, C.POINTER(u32))
    dispose = bind(midi, "MIDIClientDispose", C.c_int32, u32)
    runloop = bind(cf, "CFRunLoopRunInMode", C.c_int32, ptr, C.c_double, C.c_bool)
    default_mode = ptr.in_dll(cf, "kCFRunLoopDefaultMode")
    name_key = ptr.in_dll(midi, "kMIDIPropertyName")
    events = queue.Queue()

    def emit(**event):
        print(json.dumps({"utc": datetime.now(timezone.utc).isoformat(), **event}), flush=True)

    def check(status, operation):
        if status:
            raise RuntimeError(f"{operation}: CoreMIDI OSStatus {status}")

    def string(text):
        return cfstr(None, text.encode(), 0x08000100)

    def endpoint_name(endpoint):
        value = ptr()
        check(getprop(endpoint, name_key, C.byref(value)), "get endpoint name")
        try:
            buf = C.create_string_buffer(4096)
            if not getstr(value, buf, len(buf), 0x08000100):
                raise RuntimeError("Endpoint name conversion failed")
            return buf.value.decode()
        finally:
            release(value)

    client = u32()
    label = string("Orchid protocol research")
    try:
        check(create(label, None, None, C.byref(client)), "create client")
    finally:
        release(label)
    try:
        endpoints = {}
        for kind in ["Source", "Destination"]:
            count = bind(midi, f"MIDIGetNumberOf{kind}s", C.c_size_t)
            get = bind(midi, f"MIDIGet{kind}", u32, C.c_size_t)
            endpoints[kind] = [(get(i), endpoint_name(get(i))) for i in range(count())]
            for endpoint, name in endpoints[kind]:
                emit(event="endpoint", kind=kind, ref=endpoint, name=name)
        if args.action == "list":
            return

        def select(kind):
            matches = [ref for ref, name in endpoints[kind] if name == args.name]
            if len(matches) != 1:
                raise RuntimeError(f"Expected exactly one {kind} named {args.name!r}, got {len(matches)}")
            return matches[0]

        callback_type = C.CFUNCTYPE(None, ptr, ptr, ptr)

        @callback_type
        def receive(packet_list, _, __):
            try:
                count = C.c_uint32.from_address(packet_list).value
                packet = packet_list + 4  # CoreMIDI MIDIPacketList is packed to 4 bytes.
                for _ in range(count):
                    timestamp, length = struct.unpack("=QH", C.string_at(packet, 10))
                    data = C.string_at(packet + 10, length)
                    events.put({"event": "packet", "direction": "orchid-to-mac",
                                "host_timestamp": timestamp, "hex": data.hex(" ")})
                    packet = (packet + 10 + length + 3) & ~3
            except Exception as exc:
                events.put({"event": "capture_error", "error": str(exc)})

        input_port = u32()
        label = string("Orchid passive capture")
        try:
            input_create = bind(midi, "MIDIInputPortCreate", C.c_int32, u32, ptr, callback_type, ptr, C.POINTER(u32))
            check(input_create(client, label, receive, None, C.byref(input_port)), "create input")
        finally:
            release(label)
        connect = bind(midi, "MIDIPortConnectSource", C.c_int32, u32, u32, ptr)
        check(connect(input_port, select("Source"), None), "connect source")
        # Let CoreMIDI finish connecting before sending; no device changes here.
        runloop(default_mode, 0.2, False)
        if data is not None or schedule:
            output_port = u32()
            label = string("Orchid observed controls")
            try:
                output_create = bind(midi, "MIDIOutputPortCreate", C.c_int32, u32, ptr, C.POINTER(u32))
                check(output_create(client, label, C.byref(output_port)), "create output")
            finally:
                release(label)
            init = bind(midi, "MIDIPacketListInit", ptr, ptr)
            add = bind(midi, "MIDIPacketListAdd", ptr, ptr, C.c_size_t, ptr, C.c_uint64, C.c_size_t, ptr)
            send = bind(midi, "MIDISend", C.c_int32, u32, u32, ptr)
            scheduled_packets = [(0, data)]
            if schedule:
                system = C.CDLL("/usr/lib/libSystem.B.dylib")
                absolute_time = bind(system, "mach_absolute_time", C.c_uint64)
                class Timebase(C.Structure):
                    _fields_ = [("numer", C.c_uint32), ("denom", C.c_uint32)]
                timebase = Timebase()
                get_timebase = bind(system, "mach_timebase_info", C.c_int32, C.POINTER(Timebase))
                check(get_timebase(C.byref(timebase)), "get host clock timebase")
                ticks_per_second = 1e9 * timebase.denom / timebase.numer
                origin = absolute_time() + round(0.25 * ticks_per_second)
                scheduled_packets = [(origin + round(t * ticks_per_second), packet_data) for t, packet_data in schedule]
            buffer = C.create_string_buffer(max(1024, len(scheduled_packets) * 16 + 4))
            packet = init(buffer)
            for timestamp, packet_data in scheduled_packets:
                packet = add(buffer, len(buffer), packet, timestamp, len(packet_data), C.c_char_p(packet_data))
                if not packet:
                    raise RuntimeError("Could not build MIDI packet")
            check(send(output_port, select("Destination"), buffer), "send MIDI packet")
            if schedule:
                emit(event="scheduled", direction="mac-to-orchid",
                     clock_bpm=args.clock_bpm if args.action in CLOCK_PROBES else None,
                     host_origin=origin, ticks_per_second=ticks_per_second,
                     schedule=[{"seconds": t, "hex": packet_data.hex(" ")} for t, packet_data in schedule])
            else:
                emit(event="sent", direction="mac-to-orchid", hex=data.hex(" "))
        emit(event="listening", seconds=args.seconds)
        deadline = time.monotonic() + (schedule[-1][0] + 0.75 if schedule else args.seconds)
        while time.monotonic() < deadline:
            runloop(default_mode, min(0.05, deadline - time.monotonic()), False)
            while not events.empty():
                emit(**events.get_nowait())
        emit(event="finished")
    finally:
        dispose(client)


if __name__ == "__main__":
    main()
