#!/usr/bin/env python3
"""Render the complete agent-readable reference from the runtime parameter table."""
import json
from pathlib import Path
root=Path(__file__).resolve().parents[1]/'skills/orchid-midi'
rows=json.loads((root/'src/orchid_midi_cli/parameters.json').read_text())['parameters']
lines=['# Complete Sound and Bass parameter reference','',
'Generated from the same catalog the CLI validates. Each row applies to `sound` (alias `treble`) and `bass`. There are **134 writable parameters per voice**, plus read-only VER. This is the named synth parameter table, not a complete map of physical panel controls.','',
'```sh','orchid-midi set sound CUTOFF 80 --dry-run','orchid-midi set bass MODEL "REED PIANO"','orchid-midi set sound FMALG label:3','orchid-midi parameters --engine sound --filter FX','```','',
'Use `set ENGINE NAME VALUE`. Names in the choice column are accepted verbatim; numeric labels require `label:` (for example `label:3` means FM algorithm 3, raw 2). Otherwise numbers mean raw values. `--scale percent` and `--scale normalized` interpolate the listed raw range, not physical units.','',
'Table defaults are neither current values nor factory preset values. UI labels below are preserved from the source table, including abbreviated or misspelled labels. Index 0 cannot be written. Parameter applicability depends on the selected synth model and effect type. For FX P1–P6 meanings, [read the effect table](cli.md#effects). Most entries have static firmware/Pistil evidence; [the control map](control-map.md) identifies actual hardware checks.','',
'| Index | CLI name | Source UI label | Raw range | Table default | Raw enum → accepted label |','|---:|---|---|---|---:|---|']
for r in rows:
 choice='; '.join(f'{i} → {v}' for i,v in enumerate(r.get('choices',[]))) or '—'
 if not r['writable']:choice='Read-only metadata'
 lines.append(f"| {r['index']} | `{r['name']}` | {r['label']} | {r['minimum']}–{r['maximum']} | {r['default']} | {choice} |")
lines+=['','## Boundaries','',
'M1S–M8S and M1D–M8D have numeric ranges, but source/destination names have not been mapped. A numeric index is not enough to fulfill a request such as “route envelope 2 to pitch” reliably. Do not invent that mapping.','',
'Drum/global engines have bounded numeric indices only, not this named table: drums 0–52; global 0–35; raw values 0–127. They are not established controls for selecting drum patterns, starting drums, BPM, or master Volume. [Coverage and unresolved functions](coverage.md) distinguishes these from ready-to-use controls.','']
(root/'references/parameters.md').write_text('\n'.join(lines))
