"""Regression checks against independently recorded MIDI Monitor bytes."""
import unittest
import subprocess
import sys
from pathlib import Path

from decode_mmon import decode
from orchid_midi import clock_probe_schedule, vendor_packet


class ProtocolTest(unittest.TestCase):
    def test_failed_maintenance_probe_is_blocked_before_device_access(self):
        script = Path(__file__).with_name("orchid_midi.py")
        for flags in ([], ["--dry-run"]):
            result = subprocess.run([sys.executable, str(script), "probe-stock-service", *flags], capture_output=True, text=True)
            self.assertEqual(result.returncode, 2)
            self.assertIn("DISABLED", result.stderr)
            self.assertNotIn("CoreMIDI OSStatus", result.stderr)

    def test_clock_probe_obeys_midi_timing_and_stops(self):
        # MIDI requires 24 clock ticks per quarter note. At 60 BPM, one
        # quarter-note pre-roll plus two seconds of playback is 72 ticks.
        for status in (0xFA, 0xFB):
            events = clock_probe_schedule(status, 60, 2)
            clocks = [t for t, data in events if data == b"\xf8"]
            transport = [(t, data) for t, data in events if data != b"\xf8"]
            self.assertEqual(len(clocks), 72)
            self.assertEqual(transport[0], (1.0, bytes([status])))
            self.assertEqual(transport[-1][1], b"\xfc")
            self.assertGreater(transport[-1][0], clocks[-1])
            self.assertTrue(all(a[0] < b[0] for a, b in zip(events, events[1:])))
            for a, b in zip(clocks[24:], clocks[25:]):
                self.assertAlmostEqual(b - a, 1 / 24)

    def test_clock_probe_rejects_unbounded_or_unsupported_requests(self):
        for values in ((0xFF, 87, 5), (0xFA, 0, 5), (0xFA, 241, 5),
                       (0xFA, 87, 0), (0xFA, 87, 31)):
            with self.assertRaises(ValueError):
                clock_probe_schedule(*values)

    def test_observed_packets(self):
        # Literal bytes copied from MIDI Monitor, not computed expectations.
        fixtures = [
            (0x35, [1], "f0 00 22 0c 01 35 01 1b f7"),
            (0x35, [0], "f0 00 22 0c 01 35 00 1c f7"),
            (0x47, [0, 114, 0, 46], "f0 00 22 0c 01 47 00 72 00 2e 6a f7"),
            (0x47, [0, 114, 0, 92], "f0 00 22 0c 01 47 00 72 00 5c 3c f7"),
            (0x47, [0, 114, 0, 38], "f0 00 22 0c 01 47 00 72 00 26 72 f7"),
            (0x3F, [7], "f0 00 22 0c 01 3f 07 0b f7"),
            (0x3F, [6], "f0 00 22 0c 01 3f 06 0c f7"),
            (0x47, [0, 68, 0, 25], "f0 00 22 0c 01 47 00 44 00 19 2d f7"),
            (0x47, [0, 68, 0, 127], "f0 00 22 0c 01 47 00 44 00 7f 47 f7"),
            (0x47, [0, 102, 0, 23], "f0 00 22 0c 01 47 00 66 00 17 0d f7"),
            (0x47, [0, 102, 0, 63], "f0 00 22 0c 01 47 00 66 00 3f 65 f7"),
            (0x47, [0, 109, 0, 12], "f0 00 22 0c 01 47 00 6d 00 0c 11 f7"),
            (0x47, [0, 109, 0, 64], "f0 00 22 0c 01 47 00 6d 00 40 5d f7"),
            (0x45, [36], "f0 00 22 0c 01 45 24 68 f7"),
            (0x45, [24], "f0 00 22 0c 01 45 18 74 f7"),
            (0x46, [35], "f0 00 22 0c 01 46 23 68 f7"),
        ]
        for command, payload, expected in fixtures:
            self.assertEqual(vendor_packet(command, payload), bytes.fromhex(expected))

    def test_native_archive_preserves_observed_bytes(self):
        path = Path(__file__).resolve().parents[1] / "captures/mac-to-orchid.mmon"
        records = list(decode(path))
        self.assertEqual(records[0]["hex"], "f0 7e 7f 06 01 f7")
        self.assertEqual(records[1]["hex"], "f0 00 22 0c 01 35 01 1b f7")
        self.assertTrue(all(r["direction"] == "mac-to-orchid" for r in records))
        self.assertTrue(all(r["sum_data_mod_128"] == 0 for r in records if "command_hex" in r))

    def test_reject_non_midi_data(self):
        with self.assertRaises(ValueError):
            vendor_packet(0x47, [0, 114, 0, 128])

    def test_voicing_reply_preserves_final_value_byte(self):
        path = Path(__file__).resolve().parents[1] / "captures/voicing-session-baseline-2026-10-01.mmon"
        replies = [r for r in decode(path) if "voicing_raw" in r]
        self.assertTrue(replies)
        observed = {(r["hex"], r["voicing_raw"]) for r in replies}
        self.assertIn(("f0 00 22 0c 01 7e 52 18 f7", 24), observed)
        self.assertIn(("f0 00 22 0c 01 7e 55 17 f7", 23), observed)
        self.assertTrue(all("checksum_hex" not in r for r in replies))

    def test_native_realtime_transport_capture(self):
        path = Path(__file__).resolve().parents[1] / "captures/panel-five-final-2026-10-01.mmon"
        observed = {(r["direction"], r["hex"]) for r in decode(path)}
        self.assertIn(("mac-to-orchid", "fa"), observed)
        self.assertIn(("mac-to-orchid", "fc"), observed)
        self.assertIn(("orchid-to-mac", "f8"), observed)
        self.assertIn(("orchid-to-mac", "fc"), observed)

    def test_voicing_cli_rejects_out_of_range_before_midi(self):
        script = Path(__file__).with_name("orchid_midi.py")
        for action, value in [("chord-voicing", 0), ("chord-voicing", 61),
                              ("bass-voicing", -1), ("bass-voicing", 49)]:
            result = subprocess.run([sys.executable, str(script), action, str(value), "--dry-run"], capture_output=True, text=True)
            self.assertEqual(result.returncode, 2)
            self.assertIn("absolute raw value", result.stderr)


if __name__ == "__main__":
    unittest.main()
