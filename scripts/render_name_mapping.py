#!/usr/bin/env python3
"""Render the skill's explicit name mapping from its bundled runtime catalog."""
import json
from pathlib import Path

ROOT=Path(__file__).resolve().parents[1]/'skills/orchid-midi'
data=json.loads((ROOT/'src/orchid_midi_cli/presets.json').read_text())
lines=['# Explicit Sound, Bass, Perform and FX names','',
       'Source: hash-verified Orchid 3.92 firmware (device display v3.9.2); effect names from the saved Pistil 1.0.2 frontend. Factory preset slot order was reconstructed by running only the preset-table initializer inside a guarded offline emulator. No hardware commands were sent.','',
       'Prefer a full name in the CLI or a JSON profile. Names ignore case, accents, punctuation and spacing; partial names and typos fail instead of guessing. Numbers remain supported. Display/CLI preset numbers are **1-based**; transmitted MIDI indices are **0-based**.','',
       '```sh','orchid-midi sound "Ghost"','orchid-midi bass "Fuzzy"','orchid-midi presets sound','orchid-midi names perform','orchid-midi set sound FX1TYPE PHASER','```','']
for category,start,end,title in [('sound',0,70,'Factory Sounds'),('sound',70,100,'User Sound slots'),('bass',0,12,'Bass presets')]:
    lines += ['## '+title,'']
    if start==70:lines += ['These are the firmware’s default slot labels. Contents and custom names can differ on a particular device. Selecting `User Sound 01` always addresses slot 71; this is not a lookup of a customized hardware name. These are references to existing slots, not save commands.','']
    lines += ['| Name | Display / CLI number | MIDI index (decimal) |','|---|---:|---:|']
    for row in data[category][start:end]:lines += [f"| {row['name']} | {row['number']:03} | {row['midi_index']} |"]
    lines += ['']
lines += ['## Perform labels — reference only','',
          '**No working remote Perform setter has been established.** These indices identify entries in the firmware’s internal 16-byte label table, not SysEx values or CC setters. `orchid-midi perform ...` continues to refuse transmission. CC 103/104 reports were not symmetric incoming controls.','',
          '| Internal label | Table index | Physical menu label / interpretation |','|---|---:|---|']
for row in data['perform']:
    lines += [f"| {row['name']} | {row['table_index']} | {row['menu_label'] or row['note']} |"]
lines += ['','The normal menu also has **Exit**, which is navigation, not a Perform mode. “Arp” is the conversational abbreviation for **Arpeggiate**. The table includes **Off** as a state label and **Two Note** as an internal label absent from the inspected normal menu. Per-mode amounts were not exhaustively mapped; do not invent an amount-range or MIDI setter from this table.','',
          '## Sound/Bass effects — remotely selectable types','',
          'Use `set sound FX1TYPE NAME` / `set sound FX2TYPE NAME`, or substitute `bass`. Type values are raw enum integers, not preset numbers. Amounts and other effect parameters are separate writes; the named type command does not set them.','',
          '| Type name | FX1TYPE raw | FX2TYPE raw |','|---|---:|---:|']
fx1={r['name']:r['raw'] for r in data['fx1']}
for row in data['fx2']:lines += [f"| {row['name']} | {fx1.get(row['name'],'unavailable')} | {row['raw']} |"]
lines += ['','Reverb is separate: `REVSEND` (send), `REVSIZE` (size), `REVLP` (low-pass), `REVHP` (high-pass). See [CLI reference](cli.md) for effect-specific P1–P6 meanings. These sound effects are distinct from Perform modes.','',
          '## Provenance and confidence','',
          '- Runtime mapping: `src/orchid_midi_cli/presets.json`. Inspect with `orchid-midi presets` / `names`; it opens no MIDI ports.',
          '- Reproduce preset order and labels: `research/extract_preset_catalog.py` (optional Unicorn dependency, offline only). Firmware SHA-256: `'+data['firmware_sha256']+'`.',
          '- Initializer 0x0803DBA4 writes Sound records at 0x24048100 and Bass records at 0x24047F20, stride 40. Perform labels start at 0x0804915C, stride 16.',
          '- Sound 001/002 and Bass 007/008 match the captured physical checks. Other slot/name mappings are firmware-derived, not individually verified on hardware.',
          '- Names do not expand supported commands: no remote Perform/Loop/BPM control or maintenance operation is enabled by this catalog.','']
(ROOT/'references/names.md').write_text('\n'.join(lines))
