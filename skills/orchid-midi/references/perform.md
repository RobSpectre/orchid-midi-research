# Perform through factory preset recall

Hardware-confirmed on firmware v3.9.2, October 2, 2026. There is still no dedicated incoming Perform mode/amount setter. The established Sound-select command does load the selected preset’s stored Perform settings. Synth parameter writes can then change its timbre while leaving Perform active.

```sh
orchid-midi perform-options
orchid-midi perform-preset "Neighbour" --timbre "Pulsar" --dry-run
orchid-midi perform-preset "Neighbour" --timbre "Pulsar"
```

The example recalls Neighbour’s **Arpeggiate 02**, then applies all 134 writable Pulsar factory synth/FX parameters. The owner confirmed both that Perform remained Arpeggiate 02 and that the resulting sound was Pulsar. The instrument’s selected slot/name remains **Neighbour 007**. It does not rename the slot or save a preset. Without `--timbre`, the donor preset’s sound is used (subject to existing FX lock).

## Scope and restoration

- Only the factory combinations below are provided. Amount values are raw stored values, not a promise that every mode uses identical display units. Neighbour Arpeggiate 02 and restored Pulsar Pattern 07 were physically checked.
- Factory timbre application replaces current Sound synth/FX settings. It does not preserve unsaved edits, customized user-slot contents, or prior FX-lock-preserved values. Establish the current baseline before testing. The CLI cannot read a complete live parameter snapshot.
- The sequence is not atomic: the donor sound exists briefly before the timbre writes finish, and an interruption can leave a partial timbre. Do not play notes during the transition; inspect state after an interrupted command instead of assuming restoration.
- Selecting another Sound preset replaces Perform with that preset’s stored settings. Restore a known unedited factory baseline with `orchid-midi sound NAME`; restore manually changed Perform amounts on the device if they are not represented by an available donor.
- This uses only commands 0x35 and 0x47. No persistent slot writing, maintenance, memory writes or arbitrary function calls are involved.
- `perform MODE AMOUNT` remains rejected because an independent arbitrary setter has not been found. `perform-preset` deliberately requires a donor preset name so its sound-slot change is explicit.

## Available factory combinations

Use any listed donor with `perform-preset`. All 70 records were extracted and their selector arguments checked offline; only the Neighbour/Pulsar sequence has the physical confirmation described above.

| Perform mode | Raw amount | Factory donor Sound(s) |
|---|---:|---|
| Strum | 0 | Orchid EP, Ghost, Cherry Blossom, Eraserhead, Whoosh, Organ Stab, Malarky, Opening Credits, Rich Toy Piano, Talkie, Late Five, Breakfast, Space Harpsi, Fighter Jet, Rise And Shine, Shouting, Nebula Swamp, Frodo, Abyss, Serengeti, Nicholson, Solaw, Basement, Pigs, Cat Choir, Slow Strings, Scooby, In Reverse, Falling Star, Stylo Foam, Access, Dead Punk, Logical, Whoops A Daisy, Trout, Plumerai La Tete, Cosmic Day Spa |
| Strum | 1 | Porcelain Doll, Raphael's Defeat |
| Strum | 5 | Arctic |
| Strum | 7 | Garden Gnome |
| Strum | 9 | Hymn |
| Strum | 10 | Space Sitar |
| Strum 2 Oct | 1 | Organ With Fifth |
| Strum 2 Oct | 3 | Creepy Crawlies |
| Strum 2 Oct | 5 | FM Harp One |
| Strum 2 Oct | 7 | SNES |
| Slop | 1 | Smokey EP, Molly Buzz |
| Arpeggiate | 0 | Diapason |
| Arpeggiate | 2 | Neighbour |
| Arpeggiate | 5 | Steel Drum, DX Guitar, Bitron |
| Arpeggiate | 6 | Upsidedown, Warp World |
| Arp 2 Octaves | 1 | Diamond Cave |
| Arp 2 Octaves | 4 | Analog Flower, Distarp |
| Pattern | 2 | Waiting |
| Pattern | 3 | Orchid Forest, Saw Stairs |
| Pattern | 4 | Piano Lesson |
| Pattern | 6 | Silo, FM Bongo |
| Pattern | 7 | Pulsar |
| Pattern | 8 | 90s Hit |
| Pattern | 13 | Lemon |
| Harp | 1 | Trembling Silver, Tarbox Whirl |

An amount of zero is stored by several presets; it does not select a separate mode named Off. Only known factory metadata is used; custom user slots may carry other combinations.

## Evidence

- `captures/perform-preset-live-findings.json`: owner-confirmed sequence and restoration.
- `captures/perform-preset-neighbour-live.jsonl`: outgoing report after remote Neighbour recall.
- `captures/perform-pulsar-timbre-write.jsonl`: exact 134-packet sequence, regression-tested against the CLI.
- `research/audit_perform_routes.py` and `captures/perform-preset-route-audit.json`: guarded execution of the real selector for all 70 presets, with synth loading, Perform setters and outgoing MIDI calls explicitly stubbed. It verifies call arguments, not full audio execution.
- `research/extract_factory_voices.py`: hash-verified offline extraction; runtime data in `src/orchid_midi_cli/factory_voices.json` needs no firmware or emulator to use.
- Normal bulk 0x34 writes only voice parameters. Save 0x36 can store Perform metadata but writes persistent preset storage and is not used. CC 103/104 still return without action in the receiver.
