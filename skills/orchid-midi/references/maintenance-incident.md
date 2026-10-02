# Failed live maintenance diagnostic — do not replay

On October 1, 2026, the user authorized one fixed diagnostic after offline emulation. It sent the vendor maintenance envelope 0x7F / command 0x73 intended to call the stock constant-return function at Thumb address 0x0803049D. The proposed function returns 3. No separate RAM-page upload or flash-write command was sent.

**The user reported a loud high tone and rebooted Orchid.** The cause is unresolved. Normal operation after reboot was not confirmed in the captured conversation. We cannot infer persistent-state integrity from the emulator or the absence of a flash-write command.

The sender log shows an exact identity reply, the 165-byte maintenance packet, one subsequent clock packet, and normal host-side completion after five seconds. The expected `F0 00 22 0C 01 78 03 F7` response is absent. Host process completion is not device success.

Evidence:

- `captures/probe-stock-service-2026-10-01.jsonl` (relative to the skill root): original command and traffic.
- `captures/maintenance-probe-offline.json`: earlier emulator success, superseded for live-safety conclusions by this incident.
- `captures/maintenance-probe-live-incident.json`: consolidated observed outcome.
- `research/emulate_maintenance_probe.py`: offline reconstruction; never transmits data.

The emulator modeled the parser, checksum, unpacking, gate, indirect call and response formatter. It did not model all live MPU/cache/interrupt/peripheral state. Matching a version identity also does not establish binary identity with the downloaded image. These are limitations, not a diagnosed cause.

The live CLI now rejects `probe-stock-service` before importing or opening the native MIDI backend, including with `--dry-run`. The historical packet builder exists solely so researchers can reproduce the emulator and analyze the failure offline. Never use it as a remote control primitive, and never replay the diagnostic capture or firmware blob. A regression test verifies that the disabled command fails before device access.
