"""Portable distribution invariants, without opening a MIDI backend."""
import json
import unittest
from importlib.resources import files
from orchid_midi_cli import __version__
from orchid_midi_cli.cli import main
from unittest.mock import patch
import contextlib
import io


class Packaging(unittest.TestCase):
    def test_catalog_is_installed_as_package_data(self):
        catalog=json.loads(files('orchid_midi_cli').joinpath('parameters.json').read_text())
        self.assertEqual(len(catalog['parameters']),135)
        self.assertEqual(catalog['parameters'][134]['name'],'RPTSTEREO')
        self.assertEqual(__version__,'0.3.0')

    def test_installed_entrypoint_handles_dry_run_without_midi(self):
        output=io.StringIO()
        with contextlib.redirect_stdout(output),patch('builtins.__import__',wraps=__import__) as imports:
            self.assertEqual(main(['set','bass','RPVOL','80','--dry-run']),0)
        self.assertFalse(any(call.args[0]=='rtmidi' for call in imports.call_args_list))
        self.assertEqual(json.loads(output.getvalue())['packets'][0]['index'],131)


if __name__=='__main__':unittest.main()
