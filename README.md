# Orchid USB MIDI research

A portable agent skill and reproducible research archive for Telepathic Orchid and Pistil. Verified remote controls cover Sound/Bass presets, Reverb, Filter, Phaser/Chorus amounts and chord/bass voicing. **Perform, Key, Loop, BPM, Options and master Volume remain unresolved.**

The last live maintenance diagnostic caused a loud sustained tone and the owner rebooted the instrument. The sender now blocks that operation. The failure is preserved alongside the earlier emulator results; emulation did not prove live safety.

## Use with an agent harness

Copy the entire [`skills/orchid-midi`](skills/orchid-midi) folder into your harness's skill directory. Its [`SKILL.md`](skills/orchid-midi/SKILL.md) uses plain Markdown with `name` and `description` frontmatter and relative links. No Codex SDK, account, MCP server or absolute workspace path is required.

If your harness does not discover SKILL.md files, explicitly instruct it: “Read `/path/to/orchid-midi/SKILL.md` and use its references for this task.” Native computer-use tools are optional for Pistil/MIDI Monitor interaction. Tool availability and permissions remain the harness's responsibility.

From this repository:

```sh
python3 skills/orchid-midi/research/orchid_midi.py reverb 38 --dry-run
python3 -m unittest discover -s skills/orchid-midi/research -p test_protocol.py -v
python3 scripts/package_skill.py
```

The last command produces `dist/orchid-midi.zip` with one self-contained `orchid-midi/` folder. Extract and copy that folder to another harness. The package includes the historical captures and offline evidence, so it is larger than an instructions-only skill.

## Requirements and validation

Python 3.10+ suffices for protocol construction, capture decoding and the live sender. **Live MIDI requires macOS CoreMIDI.** Offline tools work independently of the device; a Linux/Windows live backend has not been implemented. `ORCHID_PYTHON=/path/to/python3 ./orchid-midi …` selects another runtime.

Optional firmware analysis:

```sh
python3 -m venv .venv
.venv/bin/python -m pip install -r skills/orchid-midi/requirements-research.txt
.venv/bin/python -m unittest discover -s skills/orchid-midi/research -v
```

The Unicorn emulator is an optional forensic tool; it is not run by the normal test suite and can be restricted by JIT/memory-execution sandboxes. Never treat its success as permission to send maintenance packets.

Read the [control map](skills/orchid-midi/references/control-map.md), [research trace](skills/orchid-midi/references/research-trace.md), [incident](skills/orchid-midi/references/maintenance-incident.md) and [evidence index](skills/orchid-midi/references/evidence-index.md). Tests are offline and do not prove hardware behavior beyond the recorded physical observations.

## Archive and third-party materials

Original session captures, downloaded firmware/frontend assets and generated disassembly are retained for research reproducibility. They may contain historical local paths and timing metadata. Vendor binaries/frontend assets remain third-party materials; no redistribution license is asserted for them. This initial repository is private. No open-source license has been assigned to the original research yet. Review those materials and licensing before public redistribution.

See [`THIRD_PARTY.md`](THIRD_PARTY.md) for provenance. The package excludes installed dependencies, Python caches and credentials.
