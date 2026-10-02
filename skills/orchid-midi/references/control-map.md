# Control map

Status through the October 1, 2026 hardware session; packaged October 2. Firmware display v3.9.2, identity interpreted as 3.92; Pistil 1.0.2. Evidence is local to this version and instrument.

## Verified controls

Vendor write frame: `F0 00 22 0C 01 <command> <payload> <checksum> F7`.
All data bytes are 7-bit. Checksum is `(-sum(body)) & 127`, where body starts at `00` after F0 and excludes the checksum and F7. CLI values below are decimal; command bytes are hex.

| Control | Command / payload | CLI | Physical confirmation |
|---|---|---|---|
| Sound preset | 35, zero-based index | `sound 1` / `sound 2` | ORCHID EP 001 / GHOST 002 |
| Bass preset | 3F, zero-based index | `bass 7` / `bass 8` | 07 / FUZZY 08 |
| Sound Reverb | 47, `00 72 00 raw` | `reverb 0..127` | raw 38 → 03; 46 → 04; 92 → 07 |
| Sound Filter | 47, `00 44 00 raw` | `filter 0..127` | raw 25 → 25; 127 → 127 |
| Sound Phaser amount | 47, `00 66 00 raw` | `phaser 0..127` | raw 63 → 05; 13 → 01 |
| Sound Chorus amount | 47, `00 6D 00 raw` | `chorus 0..127` | raw 64 → 05; 0 → Off |
| Chord voicing | 45, raw | `chord-voicing 1..60` | 24 → second octave; 36 → third |
| Bass voicing | 46, raw | `bass-voicing 0..48` | 23 → first octave; 35 → second |

These are verified example values, not exhaustive testing of each accepted range. Phaser and Chorus amounts target FX1/FX2 parameter 2; the appropriate effect types must already be selected. The same index can mean something different for another effect type. Engine 0 is the sound engine in these examples.

Reverb restoration recovered the original displayed step 03, not its unknown original raw sub-step. Reloading ORCHID EP did not restore the displayed reverb during the experiment. Pistil UI can remain stale after direct commands; it once showed a different Bass preset than the hardware.

Read-only queries: `query-sound` (51), `query-bass` (53), `query-chord-voicing` (52), `query-bass-voicing` (55). Sound/Bass queries return slot/name, not a complete parameter backup. Voicing replies observed as `F0 00 22 0C 01 7E 52 18 F7` and `... 55 17 F7`; their last data byte is the value, not a checksum.

Identity request: `F0 7E 7F 06 01 F7`. Observed reply: `F0 7E 7F 06 02 00 22 0C 01 01 00 00 33 2E 09 02 F7`. Identity version matching does not authenticate the full firmware image.

## Panel reports and unresolved remote controls

| Physical control | Observed outgoing MIDI | Incoming replay / conclusion |
|---|---|---|
| Perform amount | Channel 1 CC103, Off=0, Strum01=1, Strum02=2 | CC103=1 did not change Off |
| Perform mode | CC104=127 for both Arp and Strum selections | No mode ID established |
| Key selection | CC107 values 22,23,24 during adjacent selections | Incoming CC107 ignored; enharmonic entries mean clicks are not a simple semitone formula |
| Key enabled | CC108=127 On, 0 Off | Incoming replay ignored |
| BPM value | CC112 with numeric BPM, e.g. 87 | Incoming 88 did not change displayed 87 |
| BPM press / drums | Both On and Off emitted `FC FA` | Exact replay left drums silent |
| Loop menu | FA/FC while navigating length choices | No length ID or reliable per-choice mapping captured |
| Loop playback | Physical press paused the loop | Incoming Stop did not pause; Start did not resume |
| Options | No MIDI found for open, scroll to Instrument, return to Exit | No remote menu control established |
| Master Volume | Pistil gain movement left physical master at 99 | Plugin voice gain is distinct from master Volume |

Key sequence was reported as C# minor → Db minor → D minor by the mapping audit; the owner initially described two half steps. Preserve that ambiguity rather than assigning a universal key-index formula.

Loop menu: Exit, Free, 1/2/4/8/16 bars. A disposable one-bar loop was recorded, paused physically, then cleared by the user. Long-press BPM opens beat selection. Selecting Disco started the drums and emitted `FC B0 70 57 FA` (Stop, CC112=87, Start), with no beat identifier. The exact three-message Disco sequence was prepared but **not tested as an incoming replay**.

Negative live tests: FC/FA button-pair replay; Start with 24-PPQN clock at 87 BPM; Continue with that clock; MMC Play and Deferred Play; MIDI Stop while Disco played. None controlled the drums. MIDI clock F8 continued while drums were silent, so clock is not a playback indicator. At 87 BPM it is about 34.8 pulses/second.

The CLI retains bounded `probe-*` transport/report experiments for reproducibility, clearly marked as unsupported setters. They are not part of the verified-control workflow. The maintenance probe is separately disabled after a live failure.
