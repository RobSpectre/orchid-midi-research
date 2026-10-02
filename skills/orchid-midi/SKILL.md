---
name: orchid-midi
description: Control verified Telepathic Orchid sound, bass, FX and voicing parameters over USB MIDI; analyze Pistil captures and investigate remaining panel controls using recorded firmware evidence.
---

# Orchid USB MIDI research

Use this folder as the skill root. All references, tools and captures are relative to it; no Codex-specific tool is required. Python 3.10+ runs the offline tools. The included live sender requires macOS CoreMIDI; on other systems use the documented bytes with an explicitly selected MIDI backend, preserving the command restrictions below.

## Read first

- [Control map](references/control-map.md): verified setters, raw values, output-only reports and negative tests. Read before selecting commands.
- [Workflow](references/workflow.md): capture, compare, restore and validate with the instrument owner. Read before live work.
- [Research trace](references/research-trace.md): firmware, USB, Pistil and remaining unknowns. Read for reverse engineering.
- [Failed maintenance diagnostic](references/maintenance-incident.md): a command passed emulation but caused a loud sustained tone on the real instrument. Read before any maintenance or native-function research.
- [Evidence index](references/evidence-index.md): routes to original captures and scripts, including historical claims superseded by later findings.

## Operating constraints from the evidence

1. Hardware observations apply to Orchid reported v3.9.2 and Pistil 1.0.2. Identify the actual device and obtain its current baseline; historical restore values are examples, not current state.
2. Outgoing MIDI reports are not automatically accepted as incoming commands. Sending a packet, receiving an identity reply, or passing an emulator does not prove a control changed.
3. Known working controls are absolute state setters, not encoder turn/press emulation. Perform, Key, Loop, BPM, Options and master Volume have no established remote setter in this research.
4. Never transmit the maintenance diagnostic, firmware/update blobs, or whole recorded streams. `probe-stock-service` is blocked in the CLI. Maintenance 0x71/0x72/0x73, boot and framebuffer routes are offline evidence, not live control APIs. Do not remove this block as a routine troubleshooting step.
5. If the instrument produces an unexpected sustained tone or stops responding, stop testing. Do not issue more diagnostic commands automatically. Ask the owner about recovery and preserve the capture.
6. Use the user's requested scope for live changes. Capture a baseline, change one parameter, ask for physical verification when unavailable to tools, and restore that baseline. Never treat a preset query as a full settings backup.

## Entry points

From this folder, preview without hardware:

```sh
python3 research/orchid_midi.py reverb 38 --dry-run
python3 -m unittest discover -s research -p test_protocol.py -v
```

For authorized macOS hardware work:

```sh
./orchid-midi list
./orchid-midi identity --name Orchid
./orchid-midi listen --name Orchid --seconds 30
```

`ORCHID_PYTHON=/path/to/python3` selects a runtime for the shell launcher. `--name` is an exact endpoint name. The sender's fixed control allowlist intentionally limits presets to those verified. Do not broaden it merely to make a requested action appear supported.

Use any available native computer-use tool to operate Pistil and MIDI Monitor. Those apps are not necessary for previewing packets or reading saved captures. Distinguish the plugin UI, MIDI traffic and physical display/audio in the final result. Do not claim to hear audio unless the harness actually provides audio input.
