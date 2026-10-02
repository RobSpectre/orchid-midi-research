import contextlib
import io
import json
import unittest
from orchid_midi_cli import cli
from orchid_midi_cli.protocol import PRESETS, resolve_preset, preset_packet, name_key, configuration_plan, PARAMETERS


class Names(unittest.TestCase):
    def test_all_names_resolve_to_their_exact_midi_slot(self):
        for voice,count in [('sound',100),('bass',12)]:
            rows=PRESETS[voice]
            self.assertEqual(len(rows),count)
            self.assertEqual(len({name_key(r['name']) for r in rows}),count)
            for i,row in enumerate(rows):
                self.assertEqual(row['number'],i+1)
                self.assertEqual(row['midi_index'],i)
                self.assertEqual(resolve_preset(voice,row['name']),i+1)
                self.assertEqual(preset_packet(voice,row['name']),preset_packet(voice,i+1))
                self.assertEqual(preset_packet(voice,row['name'])[6],i)

    def test_recorded_examples_and_normalization(self):
        self.assertEqual(preset_packet('sound','ghost'),bytes.fromhex('f0 00 22 0c 01 35 01 1b f7'))
        self.assertEqual(preset_packet('bass','FUZZY'),bytes.fromhex('f0 00 22 0c 01 3f 07 0b f7'))
        self.assertEqual(resolve_preset('sound','  orchid-ep '),1)
        self.assertEqual(resolve_preset('sound','Raphael’s Defeat'),16)
        self.assertEqual(resolve_preset('sound','Plumerai La Tête'),68)
        self.assertEqual(resolve_preset('sound','User Sound 01'),71)
        self.assertEqual(resolve_preset('sound','User Sound 30'),100)
        self.assertEqual(resolve_preset('bass','RP chill bass'),7)

    def test_unknown_names_fail_without_device_access(self):
        for args in [('sound','Gh'),('sound','Fuzzy'),('bass','Ghost'),('bass','custom name')]:
            with self.assertRaisesRegex(ValueError,'Unknown or ambiguous'):
                cli.run(cli.parser().parse_args(args),session_factory=lambda **kw:self.fail('Opened MIDI'))

    def test_name_configuration_and_cli_dry_run(self):
        plan=configuration_plan({'sound_preset':'Orchid EP','bass_preset':'Fuzzy'})
        self.assertEqual([m['preset'] for _,m in plan],[1,8])
        with contextlib.redirect_stdout(io.StringIO()) as out:
            cli.run(cli.parser().parse_args(['sound','Ghost','--dry-run']),session_factory=lambda **kw:self.fail('Opened MIDI'))
        self.assertEqual(json.loads(out.getvalue())['packets'][0]['preset'],2)

    def test_reference_catalog_does_not_enable_perform(self):
        self.assertEqual(len(PRESETS['perform']),9)
        self.assertTrue(all(not r['remote_selectable'] for r in PRESETS['perform']))
        for row in PRESETS['perform']:
            with self.assertRaisesRegex(ValueError,'DISABLED'):
                cli.run(cli.parser().parse_args(['perform',row['name']]),session_factory=lambda **kw:self.fail('Opened MIDI'))
        for command in ('presets','names'):
            with contextlib.redirect_stdout(io.StringIO()) as out:
                cli.run(cli.parser().parse_args([command,'perform']),session_factory=lambda **kw:self.fail('Opened MIDI'))
            self.assertEqual(json.loads(out.getvalue())['perform'],PRESETS['perform'])

    def test_effect_name_maps_match_runtime_parameter_enums(self):
        for key,index in [('fx1',100),('fx2',107)]:
            self.assertEqual([r['name'] for r in PRESETS[key]],PARAMETERS[index]['choices'])
            self.assertEqual([r['raw'] for r in PRESETS[key]],list(range(len(PARAMETERS[index]['choices']))))

if __name__=='__main__':unittest.main()
