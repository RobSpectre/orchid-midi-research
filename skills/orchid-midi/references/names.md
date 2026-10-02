# Explicit Sound, Bass, Perform and FX names

Source: hash-verified Orchid 3.92 firmware (device display v3.9.2); effect names from the saved Pistil 1.0.2 frontend. Factory preset slot order was reconstructed by running only the preset-table initializer inside a guarded offline emulator. No hardware commands were sent.

Prefer a full name in the CLI or a JSON profile. Names ignore case, accents, punctuation and spacing; partial names and typos fail instead of guessing. Numbers remain supported. Display/CLI preset numbers are **1-based**; transmitted MIDI indices are **0-based**.

```sh
orchid-midi sound "Ghost"
orchid-midi bass "Fuzzy"
orchid-midi presets sound
orchid-midi names perform
orchid-midi set sound FX1TYPE PHASER
```

## Factory Sounds

| Name | Display / CLI number | MIDI index (decimal) |
|---|---:|---:|
| Orchid EP | 001 | 0 |
| Ghost | 002 | 1 |
| Analog Flower | 003 | 2 |
| Cherry Blossom | 004 | 3 |
| Eraserhead | 005 | 4 |
| Whoosh | 006 | 5 |
| Neighbour | 007 | 6 |
| Diamond Cave | 008 | 7 |
| Creepy Crawlies | 009 | 8 |
| Organ Stab | 010 | 9 |
| Porcelain Doll | 011 | 10 |
| Malarky | 012 | 11 |
| Smokey EP | 013 | 12 |
| Hymn | 014 | 13 |
| Opening Credits | 015 | 14 |
| Raphael's Defeat | 016 | 15 |
| Rich Toy Piano | 017 | 16 |
| Trembling Silver | 018 | 17 |
| Tarbox Whirl | 019 | 18 |
| Talkie | 020 | 19 |
| Late Five | 021 | 20 |
| Breakfast | 022 | 21 |
| FM Harp One | 023 | 22 |
| Distarp | 024 | 23 |
| Space Harpsi | 025 | 24 |
| Organ With Fifth | 026 | 25 |
| Fighter Jet | 027 | 26 |
| Orchid Forest | 028 | 27 |
| Rise And Shine | 029 | 28 |
| Shouting | 030 | 29 |
| Nebula Swamp | 031 | 30 |
| Frodo | 032 | 31 |
| Piano Lesson | 033 | 32 |
| 90s Hit | 034 | 33 |
| Abyss | 035 | 34 |
| Silo | 036 | 35 |
| Waiting | 037 | 36 |
| Pulsar | 038 | 37 |
| Saw Stairs | 039 | 38 |
| SNES | 040 | 39 |
| Serengeti | 041 | 40 |
| Nicholson | 042 | 41 |
| Upsidedown | 043 | 42 |
| Solaw | 044 | 43 |
| Basement | 045 | 44 |
| Warp World | 046 | 45 |
| Pigs | 047 | 46 |
| Garden Gnome | 048 | 47 |
| FM Bongo | 049 | 48 |
| Arctic | 050 | 49 |
| Cat Choir | 051 | 50 |
| Slow Strings | 052 | 51 |
| Molly Buzz | 053 | 52 |
| Scooby | 054 | 53 |
| Steel Drum | 055 | 54 |
| In Reverse | 056 | 55 |
| Falling Star | 057 | 56 |
| Stylo Foam | 058 | 57 |
| Space Sitar | 059 | 58 |
| Access | 060 | 59 |
| Dead Punk | 061 | 60 |
| Lemon | 062 | 61 |
| Logical | 063 | 62 |
| DX Guitar | 064 | 63 |
| Diapason | 065 | 64 |
| Whoops A Daisy | 066 | 65 |
| Trout | 067 | 66 |
| Plumerai La Tete | 068 | 67 |
| Bitron | 069 | 68 |
| Cosmic Day Spa | 070 | 69 |

## User Sound slots

These are the firmware’s default slot labels. Contents and custom names can differ on a particular device. Selecting `User Sound 01` always addresses slot 71; this is not a lookup of a customized hardware name. These are references to existing slots, not save commands.

| Name | Display / CLI number | MIDI index (decimal) |
|---|---:|---:|
| User Sound 01 | 071 | 70 |
| User Sound 02 | 072 | 71 |
| User Sound 03 | 073 | 72 |
| User Sound 04 | 074 | 73 |
| User Sound 05 | 075 | 74 |
| User Sound 06 | 076 | 75 |
| User Sound 07 | 077 | 76 |
| User Sound 08 | 078 | 77 |
| User Sound 09 | 079 | 78 |
| User Sound 10 | 080 | 79 |
| User Sound 11 | 081 | 80 |
| User Sound 12 | 082 | 81 |
| User Sound 13 | 083 | 82 |
| User Sound 14 | 084 | 83 |
| User Sound 15 | 085 | 84 |
| User Sound 16 | 086 | 85 |
| User Sound 17 | 087 | 86 |
| User Sound 18 | 088 | 87 |
| User Sound 19 | 089 | 88 |
| User Sound 20 | 090 | 89 |
| User Sound 21 | 091 | 90 |
| User Sound 22 | 092 | 91 |
| User Sound 23 | 093 | 92 |
| User Sound 24 | 094 | 93 |
| User Sound 25 | 095 | 94 |
| User Sound 26 | 096 | 95 |
| User Sound 27 | 097 | 96 |
| User Sound 28 | 098 | 97 |
| User Sound 29 | 099 | 98 |
| User Sound 30 | 100 | 99 |

## Bass presets

| Name | Display / CLI number | MIDI index (decimal) |
|---|---:|---:|
| PWM bass | 001 | 0 |
| RP bass | 002 | 1 |
| Klub bass | 003 | 2 |
| PBass | 004 | 3 |
| Thriller | 005 | 4 |
| Orch808 | 006 | 5 |
| RP chill bass | 007 | 6 |
| Fuzzy | 008 | 7 |
| Fifth Organ Bass | 009 | 8 |
| Meadow Bass | 010 | 9 |
| String Split | 011 | 10 |
| Rezdist bass | 012 | 11 |

## Perform labels — reference only

**No independent remote Perform setter has been established.** A [preset-recall workaround](perform.md) is now hardware-confirmed; use `perform-options` for its factory combinations. These indices identify entries in the firmware’s internal 16-byte label table, not SysEx values or CC setters. `orchid-midi perform ...` continues to refuse transmission. CC 103/104 reports were not symmetric incoming controls.

| Internal label | Table index | Physical menu label / interpretation |
|---|---:|---|
| Off | 0 | Off state label, not the menu Exit item. |
| Strum | 1 | Strum |
| Strum 2 Oct | 2 | Strum 2 Octaves |
| Slop | 3 | Slop |
| Arpeggiate | 4 | Arpeggiate |
| Arp 2 Octaves | 5 | Arp 2 Octaves |
| Pattern | 6 | Pattern |
| Harp | 7 | Harp |
| Two Note | 8 | Internal label; not present in the inspected normal Perform menu. |

The normal menu also has **Exit**, which is navigation, not a Perform mode. “Arp” is the conversational abbreviation for **Arpeggiate**. The table includes **Off** as a state label and **Two Note** as an internal label absent from the inspected normal menu. Per-mode amounts were not exhaustively mapped; do not invent an amount-range or MIDI setter from this table.

## Sound/Bass effects — remotely selectable types

Use `set sound FX1TYPE NAME` / `set sound FX2TYPE NAME`, or substitute `bass`. Type values are raw enum integers, not preset numbers. Amounts and other effect parameters are separate writes; the named type command does not set them.

| Type name | FX1TYPE raw | FX2TYPE raw |
|---|---:|---:|
| OFF | 0 | 0 |
| CHORUS | 1 | 1 |
| ENSEMBLE | 2 | 2 |
| PHASER | 3 | 3 |
| FLANGER | 4 | 4 |
| DRIVE | 5 | 5 |
| TREMOLO | 6 | 6 |
| DELAY | unavailable | 7 |

Reverb is separate: `REVSEND` (send), `REVSIZE` (size), `REVLP` (low-pass), `REVHP` (high-pass). See [CLI reference](cli.md) for effect-specific P1–P6 meanings. These sound effects are distinct from Perform modes.

## Provenance and confidence

- Runtime mapping: `src/orchid_midi_cli/presets.json`. Inspect with `orchid-midi presets` / `names`; it opens no MIDI ports.
- Reproduce preset order and labels: `research/extract_preset_catalog.py` (optional Unicorn dependency, offline only). Firmware SHA-256: `bc5e8597244a3b7ddbcc2fa0379b48d33d37e668c94d7dd1244e77c560e3936f`.
- Initializer 0x0803DBA4 writes Sound records at 0x24048100 and Bass records at 0x24047F20, stride 40. Perform labels start at 0x0804915C, stride 16.
- Sound 001/002 and Bass 007/008 match the captured physical checks. Other slot/name mappings are firmware-derived, not individually verified on hardware.
- Names do not expand supported commands: no independent Perform setter, Loop/BPM control or maintenance operation is enabled by this catalog.
