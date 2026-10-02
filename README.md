# Orchid MIDI — portable Python CLI and agent skill

Install once to control the researched Telepathic Orchid USB MIDI interface on **macOS, Linux or Windows**. The CLI uses python-rtmidi directly: no `amidi`, platform shell commands or Pistil app needed.

```sh
pipx install .
orchid-midi ports
orchid-midi sound "Ghost"
orchid-midi bass "Fuzzy"
orchid-midi filter 25
orchid-midi set sound FX1TYPE PHASER
orchid-midi set sound FX1P2 63
orchid-midi set bass MODEL "REED PIANO"
orchid-midi chord-voicing 36
```

Alternatively use `python -m pip install .` in a virtual environment or `uv tool install .`. Python3.10+ is required. Releases include a small installable wheel and the complete portable skill ZIP. The installer fetches the native MIDI dependency for your platform; an unusual platform without a dependency wheel may require build libraries. Linux needs ALSA sequencer access; see [installation](skills/orchid-midi/INSTALL.md).

## What it exposes

- All135 Sound/Bass parameter entries by name and raw range:134 configurable settings per voice plus read-only version metadata. Oscillators, envelopes, LFOs, modulation routes, filters, effects/reverb, VA/FM/Reed Piano options.
- Sound presets1–100 and Bass presets1–12 by full name or number, chord/bass voicing; bass-enable and FX-lock toggles.
- Firmware-bounded indexed drum/global DSP parameters, standard voice MIDI controls and bounded note playback.
- Identity, preset/voicing queries, passive JSONL capture, automatic port selection and saved endpoint preferences.
- Validated JSON configuration files, dry runs, enum names, raw/normalized/percent values, machine-readable capabilities.

```sh
orchid-midi parameters --engine sound --filter FX
orchid-midi capabilities
orchid-midi status
orchid-midi apply profile.json --dry-run
orchid-midi apply profile.json
```

Recorded examples verified presets, Sound FX and voicing physically. The wider catalog is extracted from Pistil's parameter table and firmware receiver; it is not all hardware-tested. **Perform, Key, Loop, BPM, Options, drum transport and master Volume still have no established remote setter.** The CLI explains and refuses those operations instead of guessing a command.

The failed maintenance diagnostic remains blocked; no raw replay, flash or maintenance API is included. Read the [incident record](skills/orchid-midi/references/maintenance-incident.md).

## Agent installation

Copy the full [`skills/orchid-midi`](skills/orchid-midi) folder into any harness's skill directory and install its Python package once (`pipx install /path/to/orchid-midi`). If the harness does not discover skills, point it at [`SKILL.md`](skills/orchid-midi/SKILL.md). The skill explicitly requires the Python CLI for all device operations and prohibits falling back to shell MIDI commands. Both the repository root and the standalone extracted skill folder are installable.

The [explicit name map](skills/orchid-midi/references/names.md) lists every factory Sound, Bass, Perform and FX label. Run `orchid-midi presets` to inspect the same machine-readable catalog.

The [CLI reference](skills/orchid-midi/references/cli.md) documents every command and the configuration schema. [The evidence index](skills/orchid-midi/references/evidence-index.md) links original captures and firmware/Pistil traces.

## Offline verification and packaging

```sh
python -m pip install .
python -m unittest discover -s skills/orchid-midi/tests -v
python -m pip install -r skills/orchid-midi/requirements-research.txt
python -m unittest discover -s skills/orchid-midi/research -v
python -m pip wheel --no-deps --wheel-dir dist .
python scripts/package_skill.py
```

Tests use captured bytes and simulated native MIDI ports, including names/APIs from macOS, Linux and Windows. They do not send to hardware. The wheel contains only CLI code and the parameter catalog; `dist/orchid-midi.zip` additionally preserves the research archive.

## Research assets

This private archive includes original captures, vendor firmware/frontend assets and generated disassembly. They retain historical metadata and third-party ownership. No public redistribution license is asserted; review [THIRD_PARTY.md](THIRD_PARTY.md) before making the full archive public. Installed dependencies, credentials, build products and Python caches are excluded from Git and the skill ZIP.
