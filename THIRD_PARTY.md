# Provenance and redistribution scope

This is independent research, not an official Telepathic Instruments integration.

- `skills/orchid-midi/research/orchid-3.92.blob`: downloaded from the official firmware site's CDN. URL and decoded-image hash are in `references/research-trace.md`.
- `orchid-3.92.bin`: offline decoding of that blob; never flashed by these tools.
- `firmware-site.html`, `firmware-updater.js`: saved official updater assets used to understand the image format.
- `pistil-embedded.js`: extracted Pistil 1.0.2 frontend; installed binary and installer hashes are recorded in `captures/session-findings.json`.
- `*.asm`: generated disassembly excerpts of the vendor firmware and locally installed Pistil binaries.
- `.mmon`, `.jsonl`, `.syx` and findings: session captures and derived research records. Recorded device traffic includes notes and timing as well as control messages.
- Capstone 5.0.9 and Unicorn 2.1.4 are optional dependencies downloaded separately, not bundled. Their own licenses apply.

No vendor ownership or license transfer is implied. Keep this archive private unless rights and sensitive metadata have been reviewed for the intended distribution. The skill instructions and packet tools are portable, but that does not establish rights to publicly redistribute every reference asset.
