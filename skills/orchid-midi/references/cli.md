# Python CLI reference (0.3.1)

Install once using [INSTALL.md](../INSTALL.md). All examples use the same `orchid-midi` executable on macOS, Linux and Windows. CLI stdout is JSON/JSONL; errors are JSON on stderr and exit 2. Interrupted operations exit 130. Arguments are validated before MIDI access. Read-only help, parameters, capabilities and dry runs need no device or backend import.

## Commands

| Command | Values / purpose | Evidence |
|---|---|---|
| `ports` (alias `list`) | Input/output indices and exact names, compiled APIs | Native enumeration, no send |
| `configure`, `config` | Save/show endpoint, API and timing preferences | Host file only |
| `capabilities` | Machine-readable supported/unresolved operations | Research summary |
| `presets sound` / `names sound` | Explicit name/slot mappings; also `bass`, `perform`, `fx1`, `fx2`, `all` | Firmware initializer and frontend |
| `perform-options` | List factory preset donors and stored Perform mode/amount | Offline; [workaround limits](perform.md) |
| `perform-preset DONOR --timbre FACTORY_SOUND` | Recall donor, optionally apply another factory timbre; `--timbre` is optional | Neighbour/Pulsar hardware-confirmed; changes Sound slot/name |
| `parameters --engine sound` | All names, indices, ranges, defaults and enum labels; `--filter FX` narrows output | Hash-locked Pistil table |
| `identity` | Manufacturer/version reply; reports whether researched identity matches | Hardware-tested |
| `status` | Identity, Sound/Bass preset/name, chord/bass voicing | Not a complete state dump |
| `query TARGET` | `sound`, `bass`, `chord-voicing`, `bass-voicing`, `sound-slots`, `bass-refresh`, `info` | Queries 51/54/52/55/50/53/56 |
| `listen --seconds 30` | Incoming MIDI JSONL; `--include-clock` includes F8, `--file capture.jsonl` preserves it | Passive input only |
| `sound NAME_OR_NUMBER` | Full name or 1–100, including user slots; CLI number is 1-based | 1/2 physically tested; wider range from firmware |
| `bass NAME_OR_NUMBER` | Full name or 1–12, 1-based | 7/8 physically tested; wider range from receiver |
| `chord-voicing RAW` | 1–60 | Hardware-tested examples |
| `bass-voicing RAW` | 0–48 | Hardware-tested examples |
| `set ENGINE PARAM VALUE` | Named/indexed sound/bass parameter; bounded indexed drums/global DSP | Static mapping plus recorded FX examples |
| `reverb`, `filter`, `phaser`, `chorus VALUE` | Shortcuts to REVSEND/CUTOFF/FX1P2/FX2P2; optional `--engine bass` | Sound amounts hardware-tested; Bass mapping static |
| `toggle bass` | Toggle Bass enabled state once, report resulting reply | Firmware branch; not yet physically tested |
| `toggle fx-lock` | Toggle device FX lock once, report resulting reply | Firmware branch; not yet physically tested |
| `apply profile.json` | Validated desired settings, paced parameter writes | No persistent slot save |
| `note NOTE` | 0–127, `--velocity 1..127`, `--duration 0.01..30`, `--channel 1/2`; always sends note-off on interruption | Voice receiver mapping |
| `modulation VALUE` | 0–127, channel1/2 | CC1 receiver |
| `sustain VALUE` | 0–127, channel1/2; inspected firmware treats **any nonzero** value as On | CC64 receiver |
| `pitch-bend VALUE` | Signed -8192..8191, channel1/2; standard MIDI encoding, center0 | Receiver has pitch path; live behavior unverified |
| `all-notes-off` | CC123; may affect both voices despite selected channel | Firmware receiver |
| `all-sound-off` | CC120; may affect both voices despite selected channel | Firmware receiver |
| `reset-controllers` | CC121; resets controller state, not firmware/factory settings | Firmware receiver |

`query-sound`, `query-bass`, `query-chord-voicing` and `query-bass-voicing` remain compatibility aliases. Bass query now uses direct current-Bass request 54; historical query53 triggers a refresh sequence including a 54 reply. `sound-slots` reports the raw slot information payload; it does not enumerate named factory presets. `info` reports an uninterpreted fixed response. Query/toggle timeout does not automatically resend.

Global options work before or after the command: `--input`, `--output`, `--name`, `--api auto|alsa|jack|coremidi|winmm`, `--timeout 0.05..60`, `--interval 0.001..2`, `--dry-run`. Default timeout2s and inter-write gap20ms. Output-only writes do not require opening an input port. Queries open input before sending. An ambiguous port selection fails instead of picking the first instrument.

## Parameter catalog

Sound (`sound` or `treble`, engine0) and Bass (engine1) each expose indices0–134. VER at0 is version metadata and is not writable. The remaining134 entries cover:

- MODEL (VA, REED PIANO, FM), FM algorithm, high-pass, glide/mode, pitch-bend range, unison/detune.
- Four oscillators: shape, semitone, detune, pulse width and gain; fourth oscillator key tracking, sync and feedback; noise/color.
- Four envelopes: attack, hold, decay, sustain and release.
- Four LFOs: shape, rate and mode.
- Filter type/cutoff/resonance/envelope/velocity/key tracking; voice gain/velocity and pan.
- Eight modulation routes: source, destination and amount. Source/target numeric bounds are known; no unverified labels are invented.
- FX1 and FX2 type plus six parameters each; reverb send, size, low-pass and high-pass.
- Reed Piano pickup height/distance/tracking/type, decay/release/tone, velocity curve, clank/curve/tracking, tremolo/rate, voice volume, hammer, key-off and stereo.

[The complete parameter reference](parameters.md) lists every entry, range and enum. `parameters` (alias `catalog`) provides the same runtime catalog; `parameters --filter FX` or `parameters --filter RP` narrows it. Full names such as `BASS_CUTOFF` are accepted only when their prefix matches the selected engine. Numeric indices are also accepted and enforce the same table ranges, including the second index byte for indices128–134.

Raw MIDI integers are the default. Recognized enum strings (e.g. `LOWPASS`, `PHASER`, `REED PIANO`) also work. Numeric enum labels are explicit: FMALG raw0 is displayed algorithm1, so use `0` or `label:1`. Do not translate semitone/pan values without checking their centered raw encoding; many have center64.

`--scale normalized` maps 0..1 to the selected parameter's table range; `--scale percent` maps0..100. Values are rounded half up; no clipping. These are parameter-range percentages, not physical unit conversions or exact display replication. For example, some LFO rate positions encode subdivisions before a continuous range.

Drum engine2 accepts numeric indices0–52; Global engine3 accepts0–35, values0–127. These are firmware-bounded DSP parameter paths with unmapped names, not a drum-start or BPM API. Use them only when the relevant DSP index has been established for the task. Neither engine is silently substituted for the named Sound/Bass table.

## Effects

FX1 types: OFF, CHORUS, ENSEMBLE, PHASER, FLANGER, DRIVE, TREMOLO. FX2 additionally supports DELAY. A type change is a separate parameter write:

```sh
orchid-midi set sound FX1TYPE PHASER
orchid-midi set sound FX1P2 63
orchid-midi set sound FX2TYPE CHORUS
orchid-midi set sound FX2P2 64
```

Pistil's advanced editor labels the effect parameters as follows:

| Effect | P1 | P2 | P3 | P4 | P5 | P6 |
|---|---|---|---|---|---|---|
| Chorus | Rate | Depth | Phase | | | |
| Ensemble | Rate | Depth | Rate2 | Depth2 | | |
| Phaser / Flanger | Rate | Depth | Feedback | Stereo | | |
| Drive | Pre-gain | Post | | | | |
| Tremolo | Rate | Depth | Phase | | | |
| Delay (FX2) | Time | Mix | Feedback | Filter | Spread | HP |

The simple Phaser/Chorus shortcuts only change the amount index; they do not silently change effect type. FX-type-specific units and audible results have not all been tested. Table defaults are not factory-preset settings or the current instrument baseline.

## Configuration file

```json
{
  "schema_version": 1,
  "sound_preset": "Orchid EP",
  "bass_preset": "RP chill bass",
  "chord_voicing": 24,
  "bass_voicing": 23,
  "parameters": {
    "sound": {"FX1TYPE": "PHASER", "FX1P2": 13, "CUTOFF": 127, "REVSEND": 38},
    "bass": {"RPVOL": 80}
  }
}
```

Preset fields accept a full preset name or a 1-based number. See [names.md](names.md) for the complete mapping. Name matching ignores case, accents, punctuation and spacing, but never guesses partial or misspelled names. User Sound labels address fixed slots; custom names stored on a particular device are not in the bundled catalog.

Omit everything you do not want changed. Values use raw integers or enum names. The whole file validates before port access. Presets precede voicing and parameters; model/effect types precede dependent parameters even if the JSON order differs. Invalid fields, duplicate aliases and unsupported settings fail without sending any packet. Only supplied settings are sent; no default reset occurs.

Application is sequential, **not atomic**. If disconnected partway through, some settings may have changed; the sent log records progress. There is no automatic rollback because full hardware readback is not established. Toggles are excluded from profiles so reapplying a file cannot invert a boolean unexpectedly. A supplied profile is not a backup retrieved from the instrument.

## Unsupported operations

Direct `perform MODE AMOUNT`, Key, Loop, BPM, Options, master Volume and drum transport are explicitly rejected. Use the separately documented `perform-preset` workaround for stored factory combinations. Maintenance, firmware, raw SysEx replay and persistent preset saving are not exposed. Legacy `probe-*` replay commands are not the portable CLI's control API; their old packet builders and recorded negative results remain offline research only.

Most expanded parameters have static code evidence, not physical verification. A successful send is reported with `verified: false`; only a matching query reply or a physical observation establishes a result. See [control-map.md](control-map.md) for actual hardware confirmations.

## Perform via a factory preset

`perform-options` lists offline donor names with their stored mode/amount. `perform-preset DONOR [--timbre FACTORY_SOUND]` selects the donor, then optionally applies all 134 writable factory voice parameters with the same validated ordering as `apply`. It changes the selected Sound slot/name and replaces Sound edits; no state backup or persistent saving occurs. `--dry-run` prints the full plan before MIDI access. See [the hardware-tested example and limits](perform.md).
