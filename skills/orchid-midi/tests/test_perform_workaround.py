import contextlib
import io
import json
from pathlib import Path
import unittest
from orchid_midi_cli import cli
from orchid_midi_cli.protocol import FACTORY_VOICES, PRESETS, perform_preset_plan


class PerformWorkaround(unittest.TestCase):
    def test_all_factory_donors_and_timbres_validate(self):
        self.assertEqual(len(FACTORY_VOICES['sound']),70)
        for row in FACTORY_VOICES['sound']:
            self.assertEqual(row['name'],PRESETS['sound'][row['number']-1]['name'])
            plan=perform_preset_plan(row['name'],row['name'])
            self.assertEqual(len(plan),135)
            self.assertEqual(plan[0][0][5],0x35)
            self.assertEqual(sorted(meta['index'] for _,meta in plan[1:]),list(range(1,135)))
            self.assertTrue(all(packet[5]==0x47 and packet[6]==0 for packet,_ in plan[1:]))
            self.assertTrue(all(sum(packet[1:-1])%128==0 for packet,_ in plan))

    def test_live_sequence_equivalence(self):
        plan=perform_preset_plan('Neighbour','Pulsar')
        self.assertEqual(plan[0][0].hex(' '),'f0 00 22 0c 01 35 06 16 f7')
        self.assertEqual(plan[0][1]['expected_perform'],{'mode':4,'name':'Arpeggiate','amount_raw':2})
        capture=Path(__file__).resolve().parents[1]/'captures/perform-pulsar-timbre-write.jsonl'
        recorded=[json.loads(line)['hex'] for line in capture.read_text().splitlines()]
        self.assertEqual([packet.hex(' ') for packet,_ in plan[1:]],recorded)
        self.assertTrue(all(meta['selected_slot_remains']==7 for _,meta in plan[1:]))

    def test_invalid_donor_or_timbre_never_opens_midi(self):
        for args in [['perform-preset','User Sound 01'],['perform-preset','Neighbour','--timbre','User Sound 01'],
                     ['perform-preset','Arpeggiate'],['perform-preset','Neighbour','--timbre','unknown']]:
            with self.assertRaises(ValueError):
                cli.run(cli.parser().parse_args(args),session_factory=lambda **kw:self.fail('Opened MIDI'))

    def test_options_and_dry_run_are_offline(self):
        for args in [['perform-options'],['perform-preset','Neighbour','--timbre','Pulsar','--dry-run']]:
            with contextlib.redirect_stdout(io.StringIO()) as out:
                result=cli.run(cli.parser().parse_args(args),session_factory=lambda **kw:self.fail('Opened MIDI'))
            self.assertEqual(result,0)
            output=json.loads(out.getvalue())
            self.assertEqual(len(output['options'] if args[0]=='perform-options' else output['packets']),70 if args[0]=='perform-options' else 135)

    def test_donor_only_and_original_preset_restore(self):
        self.assertEqual(len(perform_preset_plan('Neighbour')),1)
        original=perform_preset_plan('Pulsar')[0]
        self.assertEqual(original[1]['expected_perform'],{'mode':6,'name':'Pattern','amount_raw':7})
        self.assertEqual(original[0].hex(' '),'f0 00 22 0c 01 35 25 77 f7')

if __name__=='__main__':unittest.main()
