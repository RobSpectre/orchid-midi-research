# Install once

Use Python 3.10 or newer. From this skill folder:

```sh
python -m pip install .
orchid-midi ports
orchid-midi capabilities
```

Prefer `pipx install .` or `uv tool install .` when your OS manages the base Python environment. Both install the dependency and the `orchid-midi` executable in an isolated environment. On systems where the executable directory is not on PATH, use `python -m orchid_midi_cli` with the Python into which you installed it.

From the repository root the same install command works. A release also provides a small pure-Python wheel: `pipx install /path/to/orchid_midi_research-0.3.2-py3-none-any.whl`. The installer automatically fetches the platform-specific python-rtmidi dependency. The wheel contains the CLI and parameter catalog; the skill ZIP additionally contains the instructions and research archive.

macOS uses CoreMIDI, Linux uses ALSA (or explicitly JACK), and Windows uses WinMM. No `amidi`, shell MIDI command, Pistil installation, firmware binary or disassembler is needed. Standard supported platforms normally have python-rtmidi binary wheels. Unusual Python/platform combinations may need RtMidi build dependencies; use a Python version with an available wheel. Linux needs a working ALSA sequencer device and access to `/dev/snd/seq`; containers must expose it. Windows may require closing other applications that exclusively hold the port.

Connect Orchid with USB MIDI enabled. If exactly one matching port exists, commands work immediately. Otherwise select exact names or indices:

```sh
orchid-midi configure --input "Orchid" --output "Orchid"
orchid-midi config
orchid-midi identity
```

Use the names printed by `ports`, not these illustrative names. Configure saves only host endpoint/API/timing preferences, not instrument settings. Override any preference on a command with `--input`, `--output`, `--api`, `--timeout` or `--interval`. `--name` sets both port selectors. `configure --reset` restores automatic detection. Config lives in `$XDG_CONFIG_HOME/orchid-midi/config.json` (otherwise `~/.config/...`) on Unix or `%APPDATA%/orchid-midi/config.json` on Windows. `ORCHID_CONFIG` can select a different file.

Do not work around CLI errors using platform shell MIDI commands. Read the JSON error, fix port selection/permissions/dependency installation and retry only when appropriate. Unsupported operations deliberately fail without touching MIDI.

Backend references: [python-rtmidi API](https://spotlightkid.github.io/python-rtmidi/rtmidi.html) and [installation guide](https://spotlightkid.github.io/python-rtmidi/installation.html).

## Upgrade an existing installation

Check `orchid-midi --version` in the environment the agent actually uses. From the updated skill folder, run `python -m pip install --upgrade .`. For an existing isolated installation, use `pipx install --force /path/to/updated/orchid-midi` or `uv tool install --force /path/to/updated/orchid-midi`. Then check the version and `perform-options`; neither opens the MIDI backend. The skill files and installed CLI are separate: replacing only SKILL.md does not upgrade the executable.
