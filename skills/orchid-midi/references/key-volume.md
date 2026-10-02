# Key and master Volume: reports supported, remote setters unresolved

Follow-up on firmware v3.9.2, October 2, 2026. The CLI can interpret physical Key/Volume reports in `listen`. It still cannot set these physical controls remotely. Neither changing oscillator pitch nor changing voice gain reproduces the corresponding panel function.

```sh
orchid-midi listen --seconds 30 --file panel-capture.jsonl
```

| Report (channel 1) | Interpretation | Limits |
|---|---|---|
| CC107 | Key selection index 0–41 | Firmware has 21 root spellings for Major, then the same 21 for Minor. CLI reports `firmware_root_label` and `quality`; `~` is retained literally from the firmware's root labels. Raw22 is C# Minor; raw23 is D~ Minor. Do not equate each dial step with one semitone. |
| CC108 = 0 / 127 | Key Off / On | Other values are retained without inventing a boolean meaning. Not a query of current state. |
| CC113 = 127 / 1 | Master Volume down one / up one | Relative movement, not current level. The owner verified 85 → 83 → 85 with two clicks each way. Other raw values are not assigned unverified delta semantics. |

Reports retain original bytes and have `remote_setter: false`. No historical baseline or absolute Volume value is synthesized. Without a report, current Key state is unknown unless physically observed. The owner reported Key Off during this session; that is not a baseline for later sessions.

## Receiver and state trace

`research/audit_key_volume_routes.py` executes the actual firmware channel and CC receivers against a synthetic DSP object, with code execution restricted to those receivers and writes restricted to emulated SRAM. For all 16 channels, CC7/107/108/113 at values 0/1/85/127 returned without changing the object: **256 cases**. These are offline tests, not new live replay results. Previous live CC107/108 tests already failed to change Key.

- Key selection setter `0x08034954` writes controller offset `+0x38` and emits CC107. Key-enable setter `0x08034AE8` writes `+0x3C` and emits CC108. Normal Sound recall loads Perform metadata, not these Key fields.
- Main Volume uses native setter `0x080317CC`, clamped to 0–99, with state at voice/controller object `+4`. The rotary path calls relative wrapper `0x0803182C` and emits CC113 steps.
- The native master setter calls veneer `0x080490B0` → ITCM `0x4154`, writing a gain coefficient at DSP `+0x6668`. It also updates a derived click/beep level. Ordinary parameter writes do not reach this setter in the inspected dispatch.
- Global DSP parameter 2 writes `+0x6B2` and is used for an audio crossfade at ITCM `0x3E1A`. It is not master Volume; do not test it as an interchangeable substitute.
- Controller state loader `0x08035408` can restore Key fields; stored-settings loader `0x080326C0` can call the master Volume setter. Their identified callers are in the stored-device-state loading path, not ordinary USB MIDI dispatch. No usable remote session-recall command was established.

This is a trace of one matching firmware, not formal whole-program proof that no other path could exist. Maintenance and flash paths remain excluded, and this follow-up sent no live setting writes. No arbitrary command sweeps or repeated ignored-report experiments are justified by these findings.

## What would establish remote support

A normal incoming command that reaches the actual state setters, or a documented non-destructive state-loading API, would be a new candidate. It would still need a bounded physical test with current baselines and restoration. A function address, outgoing report, unrelated gain parameter, or successful emulator call is not such a command.

Evidence: `captures/key-volume-panel-2026-10-02.jsonl`, `captures/key-volume-live-findings.json`, `captures/key-volume-route-audit.json`. The CLI tests check captured relative steps, known Key decoding, unknown values and continued refusal of unsupported setters.

## Manufacturer cross-check

On October 2, 2026 the [official firmware page](https://firmware.telepathicinstruments.com/) still lists 3.92 as latest. The [manufacturer's MIDI-input guide](https://support.telepathicinstruments.com/hc/en-us/articles/15303106395023-Using-Orchid-as-a-Polyphonic-Sound-Module-via-MIDI-In) describes incoming notes as playing the raw sound/bass engines rather than engaging chord generation or Perform. This supports treating keyboard-note input as a different path; it does not itself prove that every possible control command is absent.
