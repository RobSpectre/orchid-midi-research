#!/usr/bin/env python3
"""Extract the version-specific Pistil Parinfo table offline; never open MIDI."""
import argparse
import hashlib
import json
import re
import struct
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
EXPECTED = '42ea0e7851299138869e18066969e02286e2dc72bbcca43cd45e29382ef1add8'


def extract(source):
    fat = source.read_bytes()
    if hashlib.sha256(fat).hexdigest() != EXPECTED:
        raise ValueError('Expected the audited Pistil 1.0.2 binary; table addresses are version-specific')
    for i in range(struct.unpack_from('>I', fat, 4)[0]):
        cpu, _, off, size, _ = struct.unpack_from('>5I', fat, 8 + 20*i)
        if cpu == 0x01000007:
            binary = fat[off:off+size]
            break
    else:
        raise ValueError('No x86_64 slice')
    segments, pos = [], 32
    for _ in range(struct.unpack_from('<I', binary, 16)[0]):
        cmd, length = struct.unpack_from('<II', binary, pos)
        if cmd == 0x19:
            vm, _, off, size = struct.unpack_from('<4Q', binary, pos+24)
            segments.append((vm, off, size))
        pos += length
    def read(address, size):
        for vm, off, length in segments:
            if vm <= address and address + size <= vm + length:
                return binary[off+address-vm:off+address-vm+size]
        raise ValueError(f'Unmapped address {address:#x}')
    def string(encoded):
        # This hash-locked image uses chained rebases: low 32 bits are image offsets.
        return read(0x100000000 + (encoded & 0xffffffff), 128).split(b'\0')[0].decode('ascii')
    rows = []
    for index in range(135):
        raw = read(0x10092d130 + index*24, 24)
        name, label = (string(v) for v in struct.unpack_from('<QQ', raw))
        minimum, maximum, default, display = raw[16:20]
        if not re.fullmatch('[A-Z][A-Z0-9]*', name) or not minimum <= default <= maximum <= 127:
            raise ValueError(f'Invalid table entry {index}')
        rows.append(dict(index=index, name=name, label=label, minimum=minimum,
                         maximum=maximum, default=default, display_type=display,
                         writable=index != 0, evidence='pistil-table-and-firmware-receiver'))
    assert len({r['name'] for r in rows}) == 135
    assert [(rows[i]['name'], rows[i]['maximum']) for i in (68,102,109,114,131)] == [
        ('CUTOFF',127),('FX1P2',127),('FX2P2',127),('REVSEND',127),('RPVOL',127)]
    js = (ROOT/'research/pistil-embedded.js').read_text()
    enums = {key: json.loads(values) for key,values in re.findall(
        r'(\w+):(\[[^\]]+\])', js.split('cB={',1)[1].split('},os=',1)[0])}
    enum_keys = {'MODEL':'model','FMALG':'routing','RPICKUP':'pickupTypes','FX1TYPE':'fx1',
                 'FX2TYPE':'fx2','FTYPE':'filter','PINK':'noise','GLIDEMODE':'glideMode'}
    for row in rows:
        name = row['name']
        key = enum_keys.get(name)
        if re.fullmatch('O[1-4]SHAPE', name): key='osc'
        if re.fullmatch('L[1-4]SHAPE', name): key='lfoShape'
        if re.fullmatch('L[1-4]MODE', name): key='lfo'
        if key:
            assert len(enums[key]) == row['maximum']+1
            row['choices'] = enums[key]
    return {'source_sha256':EXPECTED,'source':'Pistil 1.0.2 x86_64 Parinfo at 0x10092d130; 135 entries, 24-byte stride',
            'firmware':'Orchid reported v3.9.2 / public 3.92', 'parameters':rows,
            'notes':['Defaults are table defaults, not a captured hardware baseline.',
                     'Only selected sound FX indices were tested live; other named parameters are statically mapped.',
                     'Numeric values are raw MIDI values; enum labels come from the saved Pistil frontend.']}

if __name__ == '__main__':
    p=argparse.ArgumentParser(description=__doc__)
    p.add_argument('source',type=Path)
    p.add_argument('--output',type=Path,default=ROOT/'src/orchid_midi_cli/parameters.json')
    a=p.parse_args();a.output.write_text(json.dumps(extract(a.source),indent=2)+'\n')
    print(a.output)
