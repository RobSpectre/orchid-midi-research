"""Integrity checks for the offline firmware evidence, never device tests."""
import struct
import unittest
from pathlib import Path

from audit_stock_midi import decode_image


class FirmwareDecodeTest(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        cls.blob = Path(__file__).with_name("orchid-3.92.blob").read_bytes()

    def test_cortex_vectors_and_known_setter(self):
        image, checks = decode_image(self.blob)
        self.assertEqual(checks["image_pages"], 3707)
        self.assertEqual(len(image), 474496)
        self.assertEqual(struct.unpack_from("<2I", image), (0x20020000, 0x0803F5C1))
        # Independently supplied audit address: cmp r2,#3 at the parameter wrapper.
        self.assertEqual(image[0x12178:0x1217A], bytes.fromhex("03 2a"))

    def test_corrupt_packet_is_rejected(self):
        damaged = bytearray(self.blob)
        damaged[8] ^= 1
        with self.assertRaisesRegex(ValueError, "checksum"):
            decode_image(damaged)

    def test_valid_checksum_wrong_page_order_is_rejected(self):
        damaged = bytearray(self.blob)
        start = damaged.index(bytes.fromhex("f0 54 6c 70 01 7f 70"))
        damaged[start + 8] = 1
        damaged[start + 10] = 1
        damaged[start + 163] = (damaged[start + 163] - 2) & 127
        with self.assertRaisesRegex(ValueError, "Non-contiguous"):
            decode_image(damaged)


if __name__ == "__main__":
    unittest.main()
