# Firmware, USB and Pistil trace

## Sources and version identity

The user read v3.9.2 from the instrument; its MIDI identity was interpreted as 3.92. The offline image is the public 3.92 firmware from [Telepathic's firmware site](https://firmware.telepathicinstruments.com/) and [this recorded CDN blob](https://cdn.sanity.io/files/ij4eboar/production/c6585b740c8c70f1af4b6efd3166d8d44f0b59e9.blob).

Decoded image: 474,496 bytes, base 0x08020000, SHA-256 `bc5e8597244a3b7ddbcc2fa0379b48d33d37e668c94d7dd1244e77c560e3936f`.
ITCM load at 0x080202CC copies 0x6B78 bytes to address 0. Initialized RAM copy: flash 0x0808F3CC → RAM 0x24000000..0x24003E04.

The blob is an updater stream, not an ordinary MIDI recording. Decode it offline only. `research/audit_stock_midi.py` verifies frame checksums, page ordering and vector values. `research/test_firmware_audit.py` tests corrupt frames and ordering. The tools never upload the image.

## Normal receiver

- USB pump 0x08045C00 routes CIN4..7 to SysEx and CIN8..E to the channel handler at ITCM0x51CC. The examined CIN-F path only appends realtime bytes during a SysEx packet; no normal transport/clock setter was found.
- CC handler ITCM0x4C30 recognizes modulation 1, NRPN data 6, sustain 64, NRPN selectors 98/99, and channel-mode messages. CC100..119 return without the panel-state changes sought here.
- NRPN parameters target synth engines <=2, indices <=134. Notes on channels1/2 select treble/bass voices; no drum channel10 receiver was found in this path.
- SysEx 34/35: sound bulk/select; 3E/3F: bass bulk/select; 43: bass toggle; 45/46: voicing; 47: DSP parameter; 48: FX lock; 50..56: queries. Existence in firmware does not establish a verified live CLI operation.
- Command47 engine3 indices0..35 are global DSP/drum FX, not the missing panel transport setters.
- Perform has a confirmed indirect route through Sound preset metadata, offsets +0x24/+0x25. Remote Neighbour recall loaded Arpeggiate 02; applying Pulsar factory synth parameters retained that Perform setting. See [the tested workaround](perform.md). An independent transient setter remains unresolved; persistent preset writing is not used.

The native BPM routine at 0x08034C18 writes controller+0x58C and updates clock/delay fields using floating-point operations. It requires a correct object pointer and call context. An internal routine address is not a MIDI command and must not be invoked through maintenance. `native-tempo-control-trace.asm` is an offline lead only.

## USB alternative interface

Live descriptors exposed one configuration: interface0 AudioControl (class1/subclass1, no endpoints), interface1 MIDIStreaming (class1/subclass3, bulk endpoints01/81, max64). No active HID, serial or separate vendor interface was observed.

Firmware includes CDC descriptors and strings OrchidCDC / CDC Config / CDC Interface. The CDC configuration originates at flash0x0808F3D4 and RAM0x24000008. USB init0x0802EE14 selects MIDI for r0=0 and CDC for r0=1; both identified normal callers explicitly use 0. No reachable normal control for switching to CDC was found.

CDC receive callback0x08030610 copies bytes to circular buffer0x380035B0, updates index0x380035AC and rearms USB. No command parser consuming that buffer was identified. Computed pointers/aliases were not exhaustively ruled out.

The active MIDI class Setup callback is null. Device-recipient vendor/class request dispatch appears to lack a null guard; interface-recipient dispatch checks it. This is a potential fault path, not a control API, and was never tested live.

Reproduce via `research/audit_usb_routes.py`; evidence is in `captures/usb-route-audit.json`, `captures/usb-current-interface-descriptors.json` and associated assembly.

## Pistil audit

Pistil 1.0.2 standalone, AU and VST3 native analysis plus embedded UI strings were inspected. Computer use covered compact T/B views, expanded virtual analog, Reed Piano and FM editors, connection dialog and Options. Resizing exposed lower editor controls. No Loop, drum, Perform, Key or hardware BPM UI/parameter was found. Options contained audio/MIDI setup and saved-state actions.

The standalone connection dialog described the direct MIDI bridge as disabled in standalone mode, but the host/native MIDI path still sent the verified controls. Do not interpret that label as proof no MIDI is sent. DAW/plugin tempo behavior is not evidence for Orchid's drum transport.

Reproduce the native audit with `python3 research/audit_pistil_native.py /path/to/Pistil --label standalone`; it reads a Mach-O binary without launching it. Defaults point to the standard macOS app path. The installed application is not included.

## Remaining work

No remote solution has been established for all panel dials. Useful future work is offline: inspect state transitions and protocol dispatch, compare version-matched binaries, or obtain a manufacturer-supported control specification. The exact Disco report sequence remains untested incoming, but its individual components and several transport mechanisms already failed. Do not represent further permutations as likely solutions without new evidence.

Maintenance commands 71/72/73 and display/boot routes were traced as research. The sole live 73 test failed audibly; see the incident record. This evidence takes precedence over the earlier successful emulator report.

## Portable CLI catalog (0.2.0)

`research/extract_parameter_catalog.py` verifies the original Pistil binary SHA-256, reads the x86_64 Parinfo table at0x10092D130 (135 records, stride24), and extracts name, label, raw minimum/maximum and default. Names and known FX indices were checked against captured packets; enum labels come from the saved frontend. The generated catalog is bundled in `src/orchid_midi_cli/parameters.json`. Runtime installation does not need the proprietary binary.

The native `pushParamToHardware` function scans the same135 records to resolve an index and sends command47. Firmware accepts voice indices0–134, global0–35, and the deeper drum setter implements indices0–52. The new CLI exposes those ranges with separate evidence labels. Metadata VER is not writable. Sound selector0x08035118 bounds zero-based0–99; Bass command3F at0x0804621C bounds0–11. Bass43 and FX-lock48 call toggle functions independent of their payload, so the CLI offers only explicit toggles.

Static mapping is not additional physical testing. The original failed maintenance probe remains blocked, and no new device parameter writes were used to package the portable CLI.
