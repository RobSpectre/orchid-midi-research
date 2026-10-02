# Evidence index

All paths below are relative to the skill root. Original capture files remain unchanged. Some contain original local paths, timestamps, app metadata and user observations. Historical fields such as “awaiting,” “not tested,” “firmware_modified: false” or “final state” describe that earlier stage, not the present state. The control map and maintenance incident reconcile later evidence.

| Question | Primary artifacts |
|---|---|
| Initial Sound/Bass/Reverb protocol | `captures/session-findings.json`, `mac-to-orchid.mmon`, `mac-to-orchid.jsonl`, `direct-reverb-38-2026-10-01.jsonl` |
| Phaser/Chorus/Filter | `captures/pistil-fx-followup.json`, `pistil-filter-*`, `pistil-phaser-*`, `pistil-chorus-*`, `direct-*-restore-*` |
| Chord/Bass voicing and Volume | `captures/voicing-session-findings.json`, `voicing-session-baseline-*`, `direct-*-voicing-*`, `readback-*` |
| Perform/Key/Loop/BPM/Options | `captures/panel-five-findings.json`, `panel-five-final-*`, `probe-*-cc-*` |
| Physical buttons, drum transport, Disco | `captures/physical-buttons-round2-findings.json`, `physical-buttons-round2-*`, `beat-selection-*`, `transport-all-tests-*`, `probe-*-clock-*`, `probe-mmc-playback-*` |
| Normal firmware receiver | `captures/stock-midi-receiver-audit.json`, `research/audit_stock_midi.py`, `research/midi-*.asm`, `research/panel-report-xrefs.asm` |
| USB and dormant CDC | `captures/usb-route-audit.json`, `usb-current-interface-descriptors.json`, `research/audit_usb_routes.py`, `research/usb-*.asm` |
| Pistil UI/native analysis | `captures/pistil-native-audit.json`, `pistil-au-audit.json`, `pistil-vst3-audit.json`, `research/audit_pistil_native.py`, `research/pistil-*-selected.asm`, `research/pistil-embedded.js` |
| Failed maintenance diagnostic | `captures/probe-stock-service-2026-10-01.jsonl`, `maintenance-probe-live-incident.json`, `maintenance-probe-offline.json`, `research/emulate_maintenance_probe.py` |

`.mmon` is the original MIDI Monitor archive; `.jsonl` is decoded or directly captured traffic; `.syx` is binary SysEx evidence. Never feed an entire evidence file to the instrument. Clock-heavy captures are deliberately retained to preserve timing context.

`evidence-manifest.json` contains sizes and SHA-256 hashes for captures and reference firmware/frontend assets at packaging. Machine-specific `research/vendor/` dependencies and Python caches are excluded. Install optional dependencies from `requirements-research.txt` instead.

## Portable parameter catalog

`src/orchid_midi_cli/parameters.json` contains135 named parameter records and source provenance. `research/extract_parameter_catalog.py` reproduces it from the hash-matched installed Pistil binary; no vendor binary is needed to use the CLI. `tests/test_cli.py` checks captured packet equivalence, every named range, profiles, endpoint selection, reply matching, cleanup and blocked operations. The old `research/orchid_midi.py` command entry point now delegates to this same portable implementation.

## Preset and mode names

`src/orchid_midi_cli/presets.json` maps all 100 Sound slots, 12 Bass presets, Perform labels and FX enums. [Explicit name mappings](names.md) distinguishes selectable presets from reference-only Perform labels. `research/extract_preset_catalog.py` reconstructs factory slot order from the hash-verified firmware initializer in a guarded offline emulator. `tests/test_names.py` verifies every name-to-packet mapping and rejects unsupported Perform selection.
