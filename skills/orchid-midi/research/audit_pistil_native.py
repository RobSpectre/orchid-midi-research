#!/usr/bin/env python3
"""Read-only Pistil Mach-O audit; never launches or modifies the application."""
import argparse
import json
import re
import struct
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parent
sys.path.insert(0, str(ROOT / "vendor"))
from capstone import Cs, CS_ARCH_X86, CS_MODE_64
from capstone.x86 import X86_OP_MEM, X86_REG_RIP


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("source", nargs="?", type=Path, default=Path("/Applications/Pistil.app/Contents/MacOS/Pistil"))
    parser.add_argument("--label", choices=["standalone", "vst3", "au"], default="standalone")
    args = parser.parse_args()
    source = args.source
    fat = source.read_bytes()
    assert fat[:4] == bytes.fromhex("cafebabe")
    for i in range(struct.unpack_from(">I", fat, 4)[0]):
        cpu, subtype, offset, size, align = struct.unpack_from(">5I", fat, 8 + 20*i)
        if cpu == 0x01000007:
            blob = fat[offset:offset+size]
            break
    else:
        raise ValueError("No x86_64 slice; this audit does not emulate the app")
    assert blob[:4] == bytes.fromhex("cffaedfe")
    segments, sections = [], []
    pos = 32
    for _ in range(struct.unpack_from("<I", blob, 16)[0]):
        cmd, length = struct.unpack_from("<2I", blob, pos)
        if cmd == 0x19:
            name = blob[pos+8:pos+24].split(b"\0")[0].decode()
            vm, vmsize, fileoff, filesize = struct.unpack_from("<4Q", blob, pos+24)
            segments.append((vm, fileoff, filesize, name))
            count = struct.unpack_from("<I", blob, pos+64)[0]
            for j in range(count):
                entry = pos + 72 + 80*j
                sections.append(blob[entry:entry+16].split(b"\0")[0].decode())
        elif cmd == 2:
            symoff, nsyms, stroff, strsize = struct.unpack_from("<4I", blob, pos+8)
        pos += length

    def read(address, size):
        for vm, off, length, _ in segments:
            if vm <= address < vm+length:
                return blob[off+address-vm:off+address-vm+min(size,vm+length-address)]
        return b""

    def cstring(address):
        raw = read(address, 600).split(b"\0")[0]
        return raw.decode("ascii") if raw and all(32 <= x < 127 for x in raw) else None

    symbols = {}
    for i in range(nsyms):
        ix, typ, sect, desc, address = struct.unpack_from("<IBBHQ", blob, symoff+16*i)
        if (typ & 0xE) == 0xE and sect and sections[sect-1] == "__text":
            name = blob[stroff+ix:stroff+strsize].split(b"\0",1)[0].decode()
            symbols[address] = name
    ordered = sorted(symbols)
    index = {address:i for i,address in enumerate(ordered)}
    selected = {a:n for a,n in symbols.items() if
                n.startswith(("__ZN15OrchidProcessor", "__ZNK15OrchidProcessor")) or
                n.startswith("__ZN12OrchidEditor20handleWebViewMessage") or
                n.startswith("__ZN13OrchidWebView15pageAboutToLoad") or
                n.startswith("__Z21createParameterLayout") or
                n.startswith("__ZN4juce22StandaloneFilterWindow13buttonClicked")}
    md = Cs(CS_ARCH_X86, CS_MODE_64)
    md.detail = True
    report = {"source":str(source), "architecture":"x86_64 slice, offline only",
              "scope":"Named processor methods, native web message dispatch, legacy URL dispatch, parameter layout, and standalone Options handler", "functions":{}}
    lines = []
    for address, name in sorted(selected.items()):
        end = ordered[index[address]+1]
        calls, strings = set(), set()
        lines.append(f"\n; {name} at {address:#x}")
        for ins in md.disasm(read(address, end-address), address):
            annotations = []
            if ins.mnemonic in ("call", "jmp") and ins.op_str.startswith("0x"):
                target = int(ins.op_str,16)
                if target in symbols:
                    calls.add(symbols[target]); annotations.append(symbols[target])
            for op in ins.operands:
                if op.type == X86_OP_MEM and op.mem.base == X86_REG_RIP:
                    text = cstring(ins.address+ins.size+op.mem.disp)
                    if text:
                        strings.add(text); annotations.append(repr(text))
            lines.append(f"{ins.address:016x}: {ins.mnemonic:9} {ins.op_str}" + (" ; "+" | ".join(annotations) if annotations else ""))
        report["functions"][name] = {"address":hex(address),"bytes":end-address,"direct_calls":sorted(calls),"literal_strings":sorted(strings)}
    stem = "pistil-native" if args.label == "standalone" else "pistil-" + args.label
    (ROOT / f"{stem}-selected.asm").write_text("\n".join(lines)+"\n")
    (ROOT.parent / f"captures/{stem}-audit.json").write_text(json.dumps(report,indent=2)+"\n")
    print(json.dumps({"functions":len(selected),"disassembly_lines":len(lines)}))
    for name, data in report["functions"].items():
        if any(key in name for key in ("handleWebViewMessage", "createParameterLayout", "processBlock", "buttonClicked")):
            print(name, "bytes",data["bytes"],"literal_count",len(data["literal_strings"]))


if __name__ == "__main__":
    main()
