import json
from pathlib import Path
import unittest
from orchid_midi_cli.protocol import decode
from orchid_midi_cli import cli


class PanelReports(unittest.TestCase):
    def test_captured_volume_steps_do_not_invent_absolute_state(self):
        path=Path(__file__).resolve().parents[1]/'captures/key-volume-panel-2026-10-02.jsonl'
        reports=[decode(bytes.fromhex(json.loads(line)['hex'])) for line in path.read_text().splitlines()]
        self.assertEqual([r['delta'] for r in reports],[-1,-1,1,1])
        self.assertTrue(all(r['control']=='master-volume-step' and not r['absolute_value_known'] for r in reports))
        self.assertTrue(all('value' not in r and not r['remote_setter'] for r in reports))
        self.assertNotIn('delta',decode(bytes.fromhex('b0 71 40')))

    def test_key_report_spelling_quality_and_unknown_values(self):
        row=decode(bytes.fromhex('b0 6b 16'))
        self.assertEqual((row['firmware_root_label'],row['quality']),('C#','Minor'))
        self.assertEqual(decode(bytes.fromhex('b0 6b 17'))['firmware_root_label'],'D~')
        self.assertFalse(decode(bytes.fromhex('b0 6c 00'))['enabled'])
        self.assertTrue(decode(bytes.fromhex('b0 6c 7f'))['enabled'])
        self.assertNotIn('enabled',decode(bytes.fromhex('b0 6c 01')))
        self.assertNotIn('quality',decode(bytes.fromhex('b0 6b 7f')))
        self.assertEqual(decode(bytes.fromhex('b1 71 01'))['type'],'midi')

    def test_reporting_does_not_enable_fake_setters(self):
        for args in [['key','C#','minor'],['master-volume','85']]:
            with self.assertRaisesRegex(ValueError,'No incoming'):
                cli.run(cli.parser().parse_args(args),session_factory=lambda **kw:self.fail('Opened MIDI'))

if __name__=='__main__':unittest.main()
