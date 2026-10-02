---
name: orchid-midi
description: Install and use the cross-platform Python orchid-midi CLI to control Telepathic Orchid presets, synth parameters, effects and voicing, capture MIDI, and inspect evidence for unresolved panel controls.
---

# Orchid MIDI control

**Use the bundled Python CLI for every MIDI operation. Do not construct `amidi`, `sendmidi`, platform shell commands or ad-hoc MIDI sender scripts.** The skill includes an installable package and its dependencies; it needs no Pistil app or firmware assets at runtime.

## Install once, then use

From this skill folder run `python -m pip install .`, or `pipx install .` / `uv tool install .` for an isolated environment. Do not repeat installation when `orchid-midi --version` already shows 0.2.0 or later. If the executable is not on PATH, use `python -m orchid_midi_cli` in the environment where it was installed. Read [INSTALL.md](INSTALL.md) for exact port configuration and OS prerequisites.

```sh
orchid-midi ports
orchid-midi capabilities
orchid-midi parameters --engine sound
orchid-midi identity
```

The backend is python-rtmidi: CoreMIDI on macOS, ALSA/JACK on Linux, WinMM on Windows. One matching Orchid endpoint is detected automatically. If multiple ports match, use the exact names or indices returned by `ports`; save them once with `configure --input ... --output ...`. Fix installation/permissions/port selection errors in this CLI instead of falling back to OS shell MIDI tools.

## Control

```sh
orchid-midi filter 25 --dry-run
orchid-midi filter 25
orchid-midi set sound FX1TYPE PHASER
orchid-midi set sound FX1P2 63
orchid-midi set bass MODEL "REED PIANO"
orchid-midi set bass RPVOL 80
orchid-midi chord-voicing 36
orchid-midi query chord-voicing
orchid-midi apply profile.json --dry-run
```

Read [CLI reference](references/cli.md) for every command, configuration schema, scales, effect controls and limitations. `parameters` is the authoritative bundled catalog: 135 entries per Sound/Bass voice, including read-only VER metadata and 134 configurable parameters. `capabilities` distinguishes supported operations and unresolved controls. Numeric values are raw unless `--scale normalized` or `--scale percent` is specified; these are linear parameter-range percentages, not guaranteed physical display percentages.

The CLI validates all writes before opening MIDI and emits JSON. A `sent` event is not a hardware confirmation. Query responses are matched to their request; most DSP parameter writes have no implemented readback. `status` reads identity, selected presets and voicings, **not a full backup**. JSON profiles are explicit desired settings, not snapshots captured from the device.

## Evidence and boundaries

- [Control map](references/control-map.md): physically verified examples and negative tests. Expanded CLI controls also include statically mapped parameters; do not claim all were tested on hardware.
- [Workflow](references/workflow.md): record the current baseline, change one setting when testing, ask the owner for display/audio confirmation, restore the current baseline. Historical restore values are not current device state.
- [Research trace](references/research-trace.md): firmware, USB, Pistil and unresolved panel controls.
- [Maintenance incident](references/maintenance-incident.md): an emulated function-call test caused a loud tone on hardware. Maintenance, flash writes and raw replay remain unavailable in the CLI. Never bypass that exclusion as troubleshooting.
- [Evidence index](references/evidence-index.md): original captures and static-analysis artifacts. Older notes describe previous stages and may be superseded by these instructions.

Perform, Key, Loop, BPM, Options, drum transport and master Volume have no established incoming setters. The CLI rejects them with explanations. Voice GAIN and RPVOL are not master Volume. Outgoing reports do not prove incoming control. Bass enable and FX lock are **toggles**, not absolute booleans; never retry them automatically after a timeout. Persistent preset saving and bulk maintenance are research-only, not configuration commands.

For new research, use `listen` or an available native computer-use tool with Pistil/MIDI Monitor. Preserve captures and distinguish UI state, traffic and physical observation. Never replay an entire capture or firmware blob. Unexpected sustained audio or device failure ends the live test: preserve evidence and ask the owner about recovery before further hardware work.
