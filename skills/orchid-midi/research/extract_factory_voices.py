#!/usr/bin/env python3
"""Extract factory voice data and associated Perform defaults, offline only."""
import json
import struct
from extract_preset_catalog import initialized_tables, SHA256, ROOT


def extract():
    u,image=initialized_tables()
    rows=[]
    for index in range(70):
        record=bytes(u.mem_read(0x24048100+40*index,40))
        pointer=struct.unpack_from('<I',record,32)[0]
        if not (0x08020000<=pointer<=0x08020000+len(image)-135 or 0x24000000<=pointer<=0x24003e04-135):
            raise ValueError(f'Preset {index+1}: pointer outside initialized factory data')
        raw=list(u.mem_read(pointer,135))
        if any(v>127 for v in raw):raise ValueError('Non MIDI-safe factory parameter')
        mode,amount=record[36:38]
        if not 1<=mode<=7:raise ValueError('Unexpected factory Perform mode')
        name=image[0x2915c+mode*16:0x2915c+(mode+1)*16].split(b'\0')[0].decode('ascii')
        rows.append({'number':index+1,'name':record[:32].split(b'\0')[0].decode('ascii'),
                     'perform':{'mode':mode,'name':name,'amount_raw':amount},'parameters':raw})
    return {'firmware_sha256':SHA256,'firmware':'3.92',
            'source':'Guarded factory table initializer; record +0x20 parameter pointer, +0x24/+0x25 Perform defaults',
            'notes':['Factory defaults only, not current edited hardware state.',
                     'Mode/amount are applied by Sound preset selection, not a dedicated Perform command.',
                     'Synth-only writes leave the recalled preset name/slot unchanged.'],
            'sound':rows}


if __name__=='__main__':
    path=ROOT/'src/orchid_midi_cli/factory_voices.json'
    path.write_text(json.dumps(extract(),indent=2)+'\n')
    print(path)
