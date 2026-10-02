#!/usr/bin/env python3
"""Decode saved Snoize MIDI Monitor v2 documents offline; never opens MIDI.

Uses plistlib only (does not instantiate archived Objective-C classes). SysEx
framing is restored from statusByte and wasReceivedWithEOX, never repaired.
"""
import argparse
import json
import plistlib
from datetime import datetime, timedelta, timezone
from pathlib import Path


def decode(path):
    document = plistlib.loads(Path(path).read_bytes())
    if document.get("version") != 2:
        raise ValueError("Expected MIDI Monitor document version 2")
    if "messageData" not in document:
        return
    archive = plistlib.loads(document["messageData"])
    objects = archive["$objects"]

    def resolve(value):
        return objects[value.data] if isinstance(value, plistlib.UID) else value

    root = resolve(archive["$top"]["root"])
    for ref in root["NS.objects"]:
        item = resolve(ref)
        cls = resolve(item["$class"])["$classname"]
        source = resolve(item["originatingEndpoint"])
        result = {"class": cls, "source": source,
                  "direction": "mac-to-orchid" if source == "To Orchid" else
                               "orchid-to-mac" if source == "From Orchid" else "unknown"}
        if "clockTimeStamp" in item:
            result["utc"] = (datetime(2001, 1, 1, tzinfo=timezone.utc) +
                             timedelta(seconds=item["clockTimeStamp"])).isoformat()
        result["host_timestamp"] = item.get("timeStamp")
        if cls == "SMSystemExclusiveMessage":
            data = resolve(item["data"])
            if not isinstance(data, bytes) or item["statusByte"] != 0xF0:
                raise ValueError("Unexpected SysEx archive representation")
            raw = b"\xf0" + data + (b"\xf7" if item["wasReceivedWithEOX"] else b"")
            result["complete"] = item["wasReceivedWithEOX"]
        elif "dataBytes" in item:
            raw = bytes([item["statusByte"]]) + resolve(item["dataBytes"])
        elif cls in ("SMRealTimeMessage", "SMSystemRealTimeMessage", "SMSystemCommonMessage"):
            raw = bytes([item["statusByte"]])
        else:
            raise ValueError(f"Unimplemented message class: {cls}; original archive retained")
        result["hex"] = raw.hex(" ")
        if len(raw) >= 8 and raw.startswith(bytes.fromhex("f0 00 22 0c 01")) and raw[-1] == 0xF7:
            result["command_hex"] = f"{raw[5]:02x}"
            # Orchid replies use 0x7e followed by response data, with no
            # request-style checksum. Preserve the final data byte.
            if result["direction"] == "orchid-to-mac" and raw[5] == 0x7E:
                result["reply_hex"] = f"{raw[6]:02x}"
                result["payload_hex"] = raw[7:-1].hex(" ")
                if raw[6] in (0x45, 0x46, 0x52, 0x55) and len(raw) == 9:
                    result["voicing_raw"] = raw[7]
                yield result
                continue
            result["payload_hex"] = raw[6:-2].hex(" ")
            # This check is a candidate until compared with multiple captured commands.
            result["sum_data_mod_128"] = sum(raw[1:-1]) % 128
            result["checksum_candidate_hex"] = f"{(-sum(raw[1:-2])) & 0x7f:02x}"
            result["checksum_hex"] = f"{raw[-2]:02x}"
        yield result


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("path", type=Path)
    parser.add_argument("--syx", type=Path, help="Export SysEx events only, preserving incomplete packets")
    args = parser.parse_args()
    records = list(decode(args.path))
    if args.syx:
        if args.syx.resolve() == args.path.resolve():
            parser.error("Export must not overwrite source")
        args.syx.write_bytes(b"".join(bytes.fromhex(r["hex"]) for r in records
                                     if r["class"] == "SMSystemExclusiveMessage"))
    for record in records:
        print(json.dumps(record))


if __name__ == "__main__":
    main()
