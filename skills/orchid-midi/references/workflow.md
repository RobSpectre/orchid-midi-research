# Live capture and restoration

1. Establish user intent and the current hardware baseline. Confirm USB MIDI is enabled and choose exact input/output endpoints. Avoid concurrent agents or apps changing parameters during a measurement.
2. Prefer a previously verified setter. Preview it with `--dry-run` before sending. The preview and protocol tests do not open MIDI and work off-device.
3. For a new Pistil control, isolate MIDI Monitor's Orchid source and its spy-on-output destination. Keep incoming/outgoing directions distinct. Enable SysEx and realtime messages; do not filter away unknown data. Save the native `.mmon` file before decoding.
4. Operate one UI control at a time. Note its baseline, exact action and time. Save the capture and ask for the physical display or audible result. A plugin slider value is not proof the instrument changed.
5. Decode `python3 research/decode_mmon.py --help` for the available file arguments. Preserve raw `.mmon`, derived JSONL and the user's observations. CoreMIDI packet boundaries are not guaranteed to match MIDI message boundaries.
6. Construct only the smallest observed parameter write. Do not replay whole captures: they can contain notes, transport, preset changes and maintenance packets. Unknown SysEx remains offline until understood.
7. Restore the recorded current baseline, then verify it physically or with an established query. Do not restore a historical session value by default. Record when only the displayed step, rather than exact raw value, was recovered.

If the user is needed, provide a short, specific action and wait for its result. In this original session the user requested an attention chime; ask whether that preference applies in a new session. An available macOS example is `afplay /System/Library/Sounds/Glass.aiff`. Avoid repeatedly sounding alerts.

## Environment

- Python 3.10+; install the bundled package once. The live sender uses python-rtmidi with native CoreMIDI, ALSA/JACK or WinMM. See [CLI reference](cli.md).
- macOS may restrict device access in a harness sandbox. Use the harness's normal permission mechanism; do not silently bypass it. A CoreMIDI OSStatus -10833 occurred in the original sandbox.
- Linux and Windows now use the same Python CLI and python-rtmidi API. Port selection and transport behavior are unit-tested with simulated native ports; actual Linux/Windows hardware was not available for this release. Do not generate amidi or OS-specific sender commands.
- Native MIDI Monitor files are Apple property-list archives; the Python decoder reads them using the standard library.
- Pistil may need licensing/unlocking. Let the owner handle credentials. A compact editor can hide lower controls; resizing the window exposed more than scrolling did in the original session.

## Stop conditions

Unexpected sustained audio, device fault or loss of responsiveness ends the live experiment. Preserve logs and let the user recover the instrument. Do not automatically send All Notes Off, reset, boot or additional diagnostic commands as a guessed fix. The maintenance incident demonstrates why offline function-call success cannot authorize a live retry.
