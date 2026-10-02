# Agent task routing and coverage

This skill covers the researched USB MIDI surface of firmware v3.9.2, not every function available on Orchid's physical panel. The CLI implements both hardware-confirmed examples and statically mapped controls. It does not turn unverified paths into confirmed capabilities.

## Start a new session

1. Check `orchid-midi --version`; install or upgrade using [INSTALL.md](../INSTALL.md) if necessary. Use `--help` on any command to inspect exact arguments.
2. Run `ports`, select exact endpoints if ambiguous, then `identity`. If the firmware identity differs from the researched version, report the mismatch before treating these mappings as applicable.
3. Use `status` for current presets and voicings. It cannot read all edits or current Perform/FX values. Obtain only the missing baseline information relevant to a proposed change; prior session values are not defaults to restore.
4. Read the relevant reference below, choose a documented command, and preview new sequences with `--dry-run`. Normal requested configuration changes can remain in place. For experiments, restore the agreed baseline and verify the result.

## Tasks with implemented routes

| User intent | Command / reference | Confidence and material limits |
|---|---|---|
| Select a Sound or Bass by name | `sound "Ghost"`, `bass "Fuzzy"`; [all names](names.md) | Examples physically verified; factory names mapped from firmware. User labels address fixed slots, not customized device names. Sound recall also changes Perform. |
| Change chord or bass octave/voicing | `chord-voicing RAW`, `bass-voicing RAW`; [raw/display examples](control-map.md) | Verified examples; raw ranges 1–60 / 0–48. Do not invent octave or note-name conversion beyond mapped examples. |
| Change synth model, oscillators, envelopes, LFOs, filter, modulation, gain/pan, Reed Piano controls | `set sound NAME VALUE` or `set bass NAME VALUE`; [all 135 entries](parameters.md) | 134 writable per voice. Mostly static mappings; not all audible effects/units verified. Modulation source/destination names remain unmapped. |
| Change effect type and its parameters | `set sound FX1TYPE PHASER`, then `set sound FX1P2 63`; [FX meanings](cli.md#effects) | Amount shortcuts do not choose effect type. Sound Filter/Reverb/Phaser/Chorus examples physically verified. |
| Apply a known Perform combination | `perform-options`, `perform-preset "Neighbour" --timbre "Pulsar"`; [donors and limits](perform.md) | Neighbour/Pulsar sequence physically verified. Changes selected Sound slot; optional timbre uses factory defaults and replaces edits. No arbitrary mode/amount setter. |
| Toggle Bass enabled or FX lock | `toggle bass`, `toggle fx-lock` | Static receiver mapping, resulting state reply implemented. Toggle once; a timeout is not permission to retry. No absolute on/off setter. |
| Play/release a note; modulation, sustain, pitch bend | `note`, `modulation`, `sustain`, `pitch-bend`; [arguments](cli.md) | Channels 1/2 for sound/bass. Single-note helper is not a chord, sequencer, drum trigger, or Perform-engine trigger. Any nonzero sustain value means on in inspected firmware. |
| Release voices or reset MIDI controllers | `all-notes-off`, `all-sound-off`, `reset-controllers` | Static receiver mapping; may affect both voices. Not factory reset or a recovery guarantee after device malfunction. |
| Apply multiple settings | `apply profile.json`; [schema and ordering](cli.md#configuration-file) | Entire profile validates before I/O; execution sequential, no automatic rollback or full-state backup. |
| Read identity, presets, voicings | `identity`, `status`, `query TARGET`; [query meanings](cli.md) | Matching replies establish only requested data. Slot/info responses are partly uninterpreted. |
| Capture MIDI reports | `listen --seconds 30 --file capture.jsonl`; [workflow](workflow.md) | Key/Volume reports receive named decoding; Volume remains a relative step. Incoming traffic only. It does not spy on another app's outgoing port. Use native MIDI Monitor output spying when that is needed. Existing capture files are never overwritten by `listen`. |
| Configure host routing/timing | `ports`, `configure`, `config`; [installation](../INSTALL.md) | Host preferences only; no instrument settings change. |

`parameters`, `presets`/`names`, `perform-options` and `capabilities` are offline discovery commands. Their data is bundled; the agent does not need to inspect firmware or launch Pistil to use these controls.

## Not ready for arbitrary remote control

| Function | Current gap |
|---|---|
| Perform mode/amount independently | Only factory preset-recall combinations are available. No general direct setter. |
| Harmonic Key and Key enable | Outgoing CC107/108 reports do not work as incoming setters. |
| Loop length, record, overdub, pause/resume, clear | No working remote controls established. MIDI Start/Stop did not control the looper. |
| BPM / tempo, drum start/stop, beat selection | Transport, clock and MMC tests did not control the drums. Outgoing clock and tempo reports are not incoming setters. |
| Options and menu navigation / button presses | No remote UI action API found. |
| Master Volume | Sound GAIN/RPVOL are voice parameters, not a hardware master-volume control. |
| Named drum/global DSP settings | CLI bounds are known (53 drum indices, 36 global indices), but their meanings are not mapped. Do not sweep or guess indices. |
| Named modulation source/destination routing | Raw ranges known; names/semantics not mapped fully. |
| Read or restore all current edits | No complete parameter snapshot/readback. Factory tables and `status` are not backups. |
| Save user presets, firmware/maintenance, arbitrary SysEx | Not exposed. Persistent preset writes are research-only; maintenance remains blocked following the documented live failure. |

`perform`, `key`, `loop`, `bpm`, `drum-transport`, `options`, `master-volume`, `preset-save`, `maintenance`, and legacy `probe-stock-service` are explicit rejection commands. Their presence in help does not mean they control the device.

## What was validated

The release's offline tests cover packet construction, input validation, catalog consistency, captured-sequence equivalence and simulated port behavior. macOS hardware confirmed the examples listed in [control-map.md](control-map.md) and [perform.md](perform.md). Linux/Windows hardware and every synth parameter have not been physically tested. Documentation completeness, offline test success and a successful MIDI send are three different kinds of evidence.

The October 2 [Key/Volume audit](key-volume.md) traced their physical setters and stored-settings paths, and executed 256 ignored CC cases offline. Neither has gained a remote setter; only incoming report interpretation was added.
