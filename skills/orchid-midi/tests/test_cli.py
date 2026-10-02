import contextlib
import io
import json
import os
import tempfile
import unittest
from pathlib import Path
from unittest.mock import patch

from orchid_midi_cli import cli, settings
from orchid_midi_cli.protocol import (PARAMETERS, parameter_packet, preset_packet, voicing_packet,
                                     vendor, configuration_plan, decode)
from orchid_midi_cli.transport import MidiSession, select_port


class Protocol(unittest.TestCase):
    def test_recorded_wire_bytes(self):
        fixtures=[('CUTOFF',25,'f0 00 22 0c 01 47 00 44 00 19 2d f7'),
                  ('CUTOFF',127,'f0 00 22 0c 01 47 00 44 00 7f 47 f7'),
                  ('REVSEND',38,'f0 00 22 0c 01 47 00 72 00 26 72 f7'),
                  ('FX1P2',63,'f0 00 22 0c 01 47 00 66 00 3f 65 f7'),
                  ('FX2P2',64,'f0 00 22 0c 01 47 00 6d 00 40 5d f7')]
        for name,value,expected in fixtures:
            self.assertEqual(parameter_packet('sound',name,value)[0],bytes.fromhex(expected))
        self.assertEqual(preset_packet('bass',8),bytes.fromhex('f0 00 22 0c 01 3f 07 0b f7'))
        self.assertEqual(voicing_packet('chord',36),bytes.fromhex('f0 00 22 0c 01 45 24 68 f7'))

    def test_catalog_covers_all_indices_and_respects_ranges(self):
        self.assertEqual([p['index'] for p in PARAMETERS],list(range(135)))
        for engine in ('sound','bass'):
            for row in PARAMETERS[1:]:
                for value in (row['minimum'],row['maximum']):
                    packet,meta=parameter_packet(engine,row['name'],value)
                    self.assertEqual(packet[7]+128*packet[8],row['index'])
                    self.assertEqual(sum(packet[1:-1])%128,0)
                with self.assertRaises(ValueError):parameter_packet(engine,row['name'],row['maximum']+1)
        self.assertEqual(parameter_packet('bass','RPVOL',127)[0][6:10],bytes([1,3,1,127]))

    def test_enums_and_normalized_values(self):
        self.assertEqual(parameter_packet('sound','FX2TYPE','DELAY')[1]['raw'],7)
        self.assertEqual(parameter_packet('bass','MODEL','REED PIANO')[1]['raw'],1)
        self.assertEqual(parameter_packet('sound','CUTOFF','50','percent')[1]['raw'],64)
        self.assertEqual(parameter_packet('sound','FMALG','label:1')[1]['raw'],0)
        for value in ('nan','inf','-0.1','1.1'):
            with self.assertRaises(ValueError):parameter_packet('sound','CUTOFF',value,'normalized')

    def test_reject_unsafe_or_unmapped_values(self):
        for command in (0x36,0x71,0x72,0x73,0x77,0x7f):
            with self.assertRaises(ValueError):vendor(command)
        for engine,param,value in [('sound','VER',2),('sound','BASS_CUTOFF',25),('drums',53,0),('global',36,0),('bass','MODEL',True),('bass','MODEL',1.5)]:
            with self.assertRaises(ValueError):parameter_packet(engine,param,value)
        for engine,maximum in [('drums',52),('global',35)]:
            self.assertEqual(parameter_packet(engine,maximum,127)[1]['index'],maximum)
        for voice,value in [('sound',0),('sound',101),('bass',13)]:
            with self.assertRaises(ValueError):preset_packet(voice,value)

    def test_plan_validates_before_any_io_and_orders_dependent_settings(self):
        plan=configuration_plan({'sound_preset':2,'parameters':{'sound':{'FX2P2':64,'FX2TYPE':'CHORUS','CUTOFF':25,'MODEL':'VA'}}})
        self.assertEqual(plan[0][0],preset_packet('sound',2))
        self.assertEqual([meta.get('index') for _,meta in plan[1:]],[1,107,68,109])
        for bad in ({'raw':'f0 7f'}, {'parameters':{'sound':{'CUTOFF':25,'REVSEND':128}}},
                    {'parameters':{'sound':{'CUTOFF':25,'filter':26}}}):
            with self.assertRaises(ValueError):configuration_plan(bad)

    def test_response_value_is_not_a_checksum(self):
        msg=decode(bytes.fromhex('f0 00 22 0c 01 7e 52 18 f7'))
        self.assertEqual(msg['voicing_raw'],24)
        self.assertTrue(cli.response_matches(msg,{'query':'chord-voicing'}))
        self.assertFalse(cli.response_matches(msg,{'query':'bass-voicing'}))
        self.assertTrue(decode(bytes.fromhex('f0 7e 7f 06 02 00 22 0c 01 01 00 00 33 2e 09 02 f7'))['matches_researched_version'])


class FakeSession:
    def __init__(self,**kwargs):self.sent=[];self.messages=[];self.opened=None;self.closed=False
    def __enter__(self):return self
    def __exit__(self,*args):self.closed=True
    def open(self,**kwargs):self.opened=kwargs
    def send(self,packet):
        self.sent.append(packet)
        if packet==vendor(0x52):self.messages.extend([b'\xf8',bytes.fromhex('f0 00 22 0c 01 7e 55 17 f7'),bytes.fromhex('f0 00 22 0c 01 7e 52 18 f7')])
    def receive(self):return self.messages.pop(0) if self.messages else None


class CLI(unittest.TestCase):
    def setUp(self):
        self.temp=tempfile.TemporaryDirectory();self.addCleanup(self.temp.cleanup)
        self.env=patch.dict(os.environ,{'ORCHID_CONFIG':str(Path(self.temp.name)/'config.json')});self.env.start();self.addCleanup(self.env.stop)

    def run_args(self,args,session=None):
        session=session or FakeSession()
        with contextlib.redirect_stdout(io.StringIO()),patch('orchid_midi_cli.cli.time.sleep'):
            result=cli.run(cli.parser().parse_args(args),session_factory=lambda **kw:session)
        return result,session

    def test_dry_run_never_initializes_backend(self):
        for args in [['--dry-run','filter','25'],['filter','25','--dry-run'],['set','bass','RPVOL','80','--dry-run']]:
            with contextlib.redirect_stdout(io.StringIO()):
                cli.run(cli.parser().parse_args(args),session_factory=lambda **kw:self.fail('MIDI opened'))

    def test_unresolved_controls_fail_without_midi(self):
        for cmd in ('bpm','loop','perform','key','options','master-volume','maintenance','probe-stock-service'):
            with self.assertRaisesRegex(ValueError,'DISABLED'):
                cli.run(cli.parser().parse_args([cmd]),session_factory=lambda **kw:self.fail('MIDI opened'))

    def test_send_opens_only_output(self):
        _,s=self.run_args(['filter','25']);self.assertEqual(s.opened,dict(receive=False,send=True))
        self.assertEqual(s.sent,[parameter_packet('sound','CUTOFF',25)[0]]);self.assertTrue(s.closed)

    def test_query_ignores_clock_and_wrong_response(self):
        _,s=self.run_args(['query','chord-voicing']);self.assertEqual(s.opened,dict(receive=True,send=True))
        self.assertEqual(s.sent,[vendor(0x52)])

    def test_toggle_timeout_does_not_retry(self):
        s=FakeSession()
        with self.assertRaises(TimeoutError):self.run_args(['toggle','bass','--timeout','0.05'],s)
        self.assertEqual(s.sent,[vendor(0x43)]);self.assertTrue(s.closed)

    def test_invalid_profile_sends_nothing(self):
        path=Path(self.temp.name)/'profile.json';path.write_text(json.dumps({'sound_preset':2,'parameters':{'sound':{'MODEL':99}}}))
        with self.assertRaises(ValueError):
            cli.run(cli.parser().parse_args(['apply',str(path)]),session_factory=lambda **kw:self.fail('MIDI opened'))

    def test_note_released_on_interruption(self):
        s=FakeSession()
        with contextlib.redirect_stdout(io.StringIO()),patch('orchid_midi_cli.cli.time.sleep',side_effect=KeyboardInterrupt):
            with self.assertRaises(KeyboardInterrupt):cli.run(cli.parser().parse_args(['note','60']),session_factory=lambda **kw:s)
        self.assertEqual(s.sent,[bytes([0x90,60,80]),bytes([0x80,60,0])]);self.assertTrue(s.closed)

    def test_saved_preferences_and_overrides(self):
        self.run_args(['configure','--input','Orchid A','--output','Orchid B','--api','alsa'])
        self.assertEqual(settings.load()['api'],'alsa')
        self.assertEqual(settings.load()['input'],'Orchid A')
        settings.config_path().write_text('{broken')
        self.run_args(['configure','--reset']);self.assertEqual(settings.load(),settings.DEFAULTS)
        for value in (float('nan'),float('inf'),-1):
            with self.assertRaises(ValueError):settings.validate({'timeout':value})


class NativePort:
    names=['Orchid']
    def __init__(self,**kwargs):self.deleted=False;self.closed=False;self.ignored=None;self.index=None
    def get_ports(self):return self.names
    def ignore_types(self,**kwargs):self.ignored=kwargs
    def open_port(self,index,name):self.index=index
    def close_port(self):self.closed=True
    def delete(self):self.deleted=True


class Module:
    API_UNSPECIFIED=0;API_LINUX_ALSA=1;API_UNIX_JACK=2;API_MACOSX_CORE=3;API_WINDOWS_MM=4
    MidiIn=NativePort;MidiOut=NativePort
    @staticmethod
    def get_compiled_api():return [1,2,3,4]


class Transport(unittest.TestCase):
    def test_os_names_and_ambiguous_devices(self):
        for names in [['Orchid'],['Orchid:Orchid MIDI 1 20:0'],['Orchid 0']]:self.assertEqual(select_port(names),0)
        for names in [[],['Other'],['Orchid A','Orchid B']]:
            with self.assertRaises(ValueError):select_port(names)
        self.assertEqual(select_port(['Other','Orchid'],'1'),1)
        self.assertEqual(select_port(['Other','Orchid'],'Orchid'),1)
        with self.assertRaises(ValueError):select_port(['Orchid','Orchid'],'Orchid')

    def test_all_platform_api_adapters_receive_sysex_and_close(self):
        for api in ('alsa','coremidi','winmm','jack'):
            s=MidiSession(api=api,module=Module)
            with patch('orchid_midi_cli.transport.time.sleep'):s.open(receive=True)
            inp,out=s.input,s.output
            self.assertEqual(inp.ignored,dict(sysex=False,timing=False,active_sense=False))
            s.close();self.assertTrue(inp.closed and inp.deleted and out.deleted)

    def test_failed_second_port_closes_first(self):
        s=MidiSession(module=Module,output_port='Missing')
        with self.assertRaises(ValueError):s.open(receive=True)
        self.assertIsNone(s.input);self.assertIsNone(s.output)


if __name__=='__main__':unittest.main()
