#!/usr/bin/env python3
"""Build a deterministic, self-contained skill zip without dependencies/caches."""
from pathlib import Path
from zipfile import ZipFile, ZipInfo, ZIP_DEFLATED

ROOT = Path(__file__).resolve().parents[1]
SKILL = ROOT / "skills" / "orchid-midi"


def main():
    destination = ROOT / "dist" / "orchid-midi.zip"
    destination.parent.mkdir(exist_ok=True)
    count = 0
    with ZipFile(destination, "w", compression=ZIP_DEFLATED) as archive:
        for path in sorted(SKILL.rglob("*")):
            relative = path.relative_to(SKILL)
            if any(part in {"vendor", "__pycache__", ".venv", ".git", "build", "dist"} for part in relative.parts):
                continue
            if any(part.endswith(".egg-info") for part in relative.parts):
                continue
            if not path.is_file() or path.name == ".DS_Store" or path.suffix in {".pyc", ".pyo"}:
                continue
            if path.is_symlink():
                raise ValueError(f"Skill must be self-contained, found symlink: {relative}")
            info = ZipInfo(str(Path("orchid-midi") / relative), date_time=(2026, 10, 2, 0, 0, 0))
            info.compress_type = ZIP_DEFLATED
            info.external_attr = (0o100755 if path.name == "orchid-midi" else 0o100644) << 16
            archive.writestr(info, path.read_bytes())
            count += 1
    print(f"Built {destination}: {count} files, {destination.stat().st_size:,} bytes")


if __name__ == "__main__":
    main()
