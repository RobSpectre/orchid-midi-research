# Complete Sound and Bass parameter reference

Generated from the same catalog the CLI validates. Each row applies to `sound` (alias `treble`) and `bass`. There are **134 writable parameters per voice**, plus read-only VER. This is the named synth parameter table, not a complete map of physical panel controls.

```sh
orchid-midi set sound CUTOFF 80 --dry-run
orchid-midi set bass MODEL "REED PIANO"
orchid-midi set sound FMALG label:3
orchid-midi parameters --engine sound --filter FX
```

Use `set ENGINE NAME VALUE`. Names in the choice column are accepted verbatim; numeric labels require `label:` (for example `label:3` means FM algorithm 3, raw 2). Otherwise numbers mean raw values. `--scale percent` and `--scale normalized` interpolate the listed raw range, not physical units.

Table defaults are neither current values nor factory preset values. UI labels below are preserved from the source table, including abbreviated or misspelled labels. Index 0 cannot be written. Parameter applicability depends on the selected synth model and effect type. For FX P1–P6 meanings, [read the effect table](cli.md#effects). Most entries have static firmware/Pistil evidence; [the control map](control-map.md) identifies actual hardware checks.

| Index | CLI name | Source UI label | Raw range | Table default | Raw enum → accepted label |
|---:|---|---|---|---:|---|
| 0 | `VER` | version | 2–2 | 2 | Read-only metadata |
| 1 | `MODEL` | model | 0–2 | 0 | 0 → VA; 1 → REED PIANO; 2 → FM |
| 2 | `FMALG` | fmalg | 0–7 | 0 | 0 → 1; 1 → 2; 2 → 3; 3 → 4; 4 → 5; 5 → 6; 6 → 7; 7 → 8 |
| 3 | `HIGHPASS` | highpass | 0–127 | 0 | — |
| 4 | `GLIDE` | glide | 0–127 | 0 | — |
| 5 | `GLIDEMODE` | mode | 0–3 | 0 | 0 → POLY; 1 → POLY LEGATO; 2 → MONO; 3 → MONO LEGATO |
| 6 | `BENDRANGE` | bendrange | 0–12 | 2 | — |
| 7 | `UNISON` | unison | 0–4 | 0 | — |
| 8 | `UDETUNE` | detune | 0–127 | 0 | — |
| 9 | `HPKT` | ketryack | 0–127 | 0 | — |
| 10 | `O1SHAPE` | shape | 0–3 | 1 | 0 → OFF; 1 → SAW; 2 → PULSE; 3 → TRI |
| 11 | `O1SEMI` | semitone | 0–127 | 64 | — |
| 12 | `O1DETUNE` | detune | 0–127 | 64 | — |
| 13 | `O1PW` | pulsewidth | 0–127 | 64 | — |
| 14 | `O1GAIN` | gain | 0–127 | 64 | — |
| 15 | `O2SHAPE` | shape | 0–3 | 0 | 0 → OFF; 1 → SAW; 2 → PULSE; 3 → TRI |
| 16 | `O2SEMI` | semitone | 0–127 | 64 | — |
| 17 | `O2DETUNE` | detune | 0–127 | 64 | — |
| 18 | `O2PW` | pulsewidth | 0–127 | 64 | — |
| 19 | `O2GAIN` | gain | 0–127 | 0 | — |
| 20 | `O3SHAPE` | shape | 0–3 | 0 | 0 → OFF; 1 → SAW; 2 → PULSE; 3 → TRI |
| 21 | `O3SEMI` | semitone | 0–127 | 64 | — |
| 22 | `O3DETUNE` | detune | 0–127 | 64 | — |
| 23 | `O3PW` | pulsewidth | 0–127 | 64 | — |
| 24 | `O3GAIN` | gain | 0–127 | 0 | — |
| 25 | `O4SHAPE` | shape | 0–3 | 0 | 0 → OFF; 1 → SAW; 2 → PULSE; 3 → TRI |
| 26 | `O4SEMI` | semitone | 0–127 | 64 | — |
| 27 | `O4DETUNE` | detune | 0–127 | 64 | — |
| 28 | `O4PW` | pulsewidth | 0–127 | 64 | — |
| 29 | `O4GAIN` | gain | 0–127 | 0 | — |
| 30 | `O4KT` | keytrack | 0–1 | 1 | — |
| 31 | `O4SYNC` | sync | 0–1 | 0 | — |
| 32 | `O4FB` | feedback | 0–127 | 0 | — |
| 33 | `NOISE` | gain | 0–127 | 0 | — |
| 34 | `PINK` | pink | 0–1 | 0 | 0 → WHITE; 1 → PINK |
| 35 | `E1A` | attack | 0–127 | 0 | — |
| 36 | `E1H` | hold | 0–127 | 0 | — |
| 37 | `E1D` | decay | 0–127 | 64 | — |
| 38 | `E1S` | sustain | 0–127 | 64 | — |
| 39 | `E1R` | release | 0–127 | 64 | — |
| 40 | `E2A` | attack | 0–127 | 0 | — |
| 41 | `E2H` | hold | 0–127 | 0 | — |
| 42 | `E2D` | decay | 0–127 | 64 | — |
| 43 | `E2S` | sustain | 0–127 | 127 | — |
| 44 | `E2R` | release | 0–127 | 64 | — |
| 45 | `E3A` | attack | 0–127 | 0 | — |
| 46 | `E3H` | hold | 0–127 | 0 | — |
| 47 | `E3D` | decay | 0–127 | 64 | — |
| 48 | `E3S` | sustain | 0–127 | 127 | — |
| 49 | `E3R` | release | 0–127 | 64 | — |
| 50 | `E4A` | attack | 0–127 | 0 | — |
| 51 | `E4H` | hold | 0–127 | 0 | — |
| 52 | `E4D` | decay | 0–127 | 64 | — |
| 53 | `E4S` | sustain | 0–127 | 127 | — |
| 54 | `E4R` | release | 0–127 | 64 | — |
| 55 | `L1SHAPE` | shape | 0–6 | 0 | 0 → SINE; 1 → TRI; 2 → SQU; 3 → SAW; 4 → SAW-; 5 → RAND; 6 → S&H |
| 56 | `L1RATE` | rate | 0–127 | 0 | — |
| 57 | `L1MODE` | mode | 0–3 | 0 | 0 → RESET; 1 → FREE; 2 → MONO; 3 → ONESHOT |
| 58 | `L2SHAPE` | shape | 0–6 | 0 | 0 → SINE; 1 → TRI; 2 → SQU; 3 → SAW; 4 → SAW-; 5 → RAND; 6 → S&H |
| 59 | `L2RATE` | rate | 0–127 | 0 | — |
| 60 | `L2MODE` | mode | 0–3 | 0 | 0 → RESET; 1 → FREE; 2 → MONO; 3 → ONESHOT |
| 61 | `L3SHAPE` | shape | 0–6 | 0 | 0 → SINE; 1 → TRI; 2 → SQU; 3 → SAW; 4 → SAW-; 5 → RAND; 6 → S&H |
| 62 | `L3RATE` | rate | 0–127 | 0 | — |
| 63 | `L3MODE` | mode | 0–3 | 0 | 0 → RESET; 1 → FREE; 2 → MONO; 3 → ONESHOT |
| 64 | `L4SHAPE` | shape | 0–6 | 0 | 0 → SINE; 1 → TRI; 2 → SQU; 3 → SAW; 4 → SAW-; 5 → RAND; 6 → S&H |
| 65 | `L4RATE` | rate | 0–127 | 0 | — |
| 66 | `L4MODE` | l4 mode | 0–3 | 0 | 0 → RESET; 1 → FREE; 2 → MONO; 3 → ONESHOT |
| 67 | `FTYPE` | type | 0–3 | 1 | 0 → OFF; 1 → LOWPASS; 2 → BANDPASS; 3 → HIGHPASS |
| 68 | `CUTOFF` | cutoff | 0–127 | 127 | — |
| 69 | `RESONANCE` | q | 0–127 | 0 | — |
| 70 | `FENV` | env1 | 0–127 | 0 | — |
| 71 | `FVELO` | vel | 0–127 | 0 | — |
| 72 | `FKT` | keytrack | 0–127 | 0 | — |
| 73 | `GAIN` | volume | 0–127 | 64 | — |
| 74 | `GVELO` | vel | 0–127 | 0 | — |
| 75 | `PAN` | pan | 0–127 | 64 | — |
| 76 | `M1S` | m1 source | 0–14 | 0 | — |
| 77 | `M1D` | m1 target | 0–33 | 0 | — |
| 78 | `M1A` | m1 amount | 0–127 | 64 | — |
| 79 | `M2S` | m2 source | 0–14 | 0 | — |
| 80 | `M2D` | m2 target | 0–33 | 0 | — |
| 81 | `M2A` | m2 amount | 0–127 | 64 | — |
| 82 | `M3S` | m3 source | 0–14 | 0 | — |
| 83 | `M3D` | m3 target | 0–33 | 0 | — |
| 84 | `M3A` | m3 amount | 0–127 | 64 | — |
| 85 | `M4S` | m4 source | 0–14 | 0 | — |
| 86 | `M4D` | m4 target | 0–33 | 0 | — |
| 87 | `M4A` | m4 amount | 0–127 | 64 | — |
| 88 | `M5S` | m5 source | 0–14 | 0 | — |
| 89 | `M5D` | m5 target | 0–33 | 0 | — |
| 90 | `M5A` | m5 amount | 0–127 | 64 | — |
| 91 | `M6S` | m6 source | 0–14 | 0 | — |
| 92 | `M6D` | m6 target | 0–33 | 0 | — |
| 93 | `M6A` | m6 amount | 0–127 | 64 | — |
| 94 | `M7S` | m7 source | 0–14 | 0 | — |
| 95 | `M7D` | m7 target | 0–33 | 0 | — |
| 96 | `M7A` | m7 amount | 0–127 | 64 | — |
| 97 | `M8S` | m8 source | 0–14 | 0 | — |
| 98 | `M8D` | m8 target | 0–33 | 0 | — |
| 99 | `M8A` | m8 amount | 0–127 | 64 | — |
| 100 | `FX1TYPE` | fx1 | 0–6 | 0 | 0 → OFF; 1 → CHORUS; 2 → ENSEMBLE; 3 → PHASER; 4 → FLANGER; 5 → DRIVE; 6 → TREMOLO |
| 101 | `FX1P1` | fx1 p1 | 0–127 | 0 | — |
| 102 | `FX1P2` | fx1 p2 | 0–127 | 0 | — |
| 103 | `FX1P3` | fx1 p3 | 0–127 | 0 | — |
| 104 | `FX1P4` | fx1 p4 | 0–127 | 0 | — |
| 105 | `FX1P5` | fx1 p5 | 0–127 | 0 | — |
| 106 | `FX1P6` | fx1 p6 | 0–127 | 0 | — |
| 107 | `FX2TYPE` | fx2 | 0–7 | 0 | 0 → OFF; 1 → CHORUS; 2 → ENSEMBLE; 3 → PHASER; 4 → FLANGER; 5 → DRIVE; 6 → TREMOLO; 7 → DELAY |
| 108 | `FX2P1` | fx2 p1 | 0–127 | 0 | — |
| 109 | `FX2P2` | fx2 p2 | 0–127 | 0 | — |
| 110 | `FX2P3` | fx2 p3 | 0–127 | 0 | — |
| 111 | `FX2P4` | fx2 p4 | 0–127 | 0 | — |
| 112 | `FX2P5` | fx2 p5 | 0–127 | 0 | — |
| 113 | `FX2P6` | fx2 p6 | 0–127 | 0 | — |
| 114 | `REVSEND` | reverb | 0–127 | 0 | — |
| 115 | `REVSIZE` | size | 0–127 | 100 | — |
| 116 | `REVLP` | lowpass | 0–127 | 120 | — |
| 117 | `REVHP` | highpass | 0–127 | 10 | — |
| 118 | `RPHEIGHT` | height | 0–127 | 10 | — |
| 119 | `RPDISTANCE` | distance | 0–127 | 10 | — |
| 120 | `RPKT` | keytrack | 0–127 | 64 | — |
| 121 | `RPICKUP` | pickup | 0–3 | 0 | 0 → NORMAL; 1 → MELLOW; 2 → SHARP; 3 → ODD |
| 122 | `RPDECAY` | decay | 0–127 | 110 | — |
| 123 | `RPRELEASE` | release | 0–127 | 32 | — |
| 124 | `RPTONE` | tone | 0–127 | 64 | — |
| 125 | `RPVELCURVE` | velocity | 0–127 | 90 | — |
| 126 | `RPCLANK` | clank | 0–127 | 32 | — |
| 127 | `RPCLANCURVE` | velocity | 0–127 | 32 | — |
| 128 | `RPCKT` | keytrack | 0–127 | 32 | — |
| 129 | `RPTREMOLO` | tremolo | 0–127 | 0 | — |
| 130 | `RPTREMRATE` | speed | 0–127 | 80 | — |
| 131 | `RPVOL` | volume | 0–127 | 127 | — |
| 132 | `RPHAMMER` | hammer | 0–127 | 16 | — |
| 133 | `RPKEYOFF` | key off | 0–127 | 16 | — |
| 134 | `RPTSTEREO` | stereo | 0–127 | 0 | — |

## Boundaries

M1S–M8S and M1D–M8D have numeric ranges, but source/destination names have not been mapped. A numeric index is not enough to fulfill a request such as “route envelope 2 to pitch” reliably. Do not invent that mapping.

Drum/global engines have bounded numeric indices only, not this named table: drums 0–52; global 0–35; raw values 0–127. They are not established controls for selecting drum patterns, starting drums, BPM, or master Volume. [Coverage and unresolved functions](coverage.md) distinguishes these from ready-to-use controls.
