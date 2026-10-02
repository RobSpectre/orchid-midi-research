#!/usr/bin/env python3
"""Reconstruct factory preset tables offline. Never opens MIDI or USB.

Only the table initializer can execute; emulated writes are restricted to SRAM.
The bundled catalog can be used without Unicorn or a firmware image.
"""
import hashlib
import json
import re
import struct
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
SHA256 = 'bc5e8597244a3b7ddbcc2fa0379b48d33d37e668c94d7dd1244e77c560e3936f'


def initialized_tables():
    sys.path.insert(0,str(ROOT/'research/vendor'))
    from unicorn import Uc, UC_ARCH_ARM, UC_MODE_THUMB, UC_MODE_MCLASS, UC_HOOK_CODE, UC_HOOK_MEM_WRITE
    from unicorn.arm_const import UC_ARM_REG_SP, UC_ARM_REG_LR, UC_ARM_REG_PC
    image=(ROOT/'research/orchid-3.92.bin').read_bytes()
    if hashlib.sha256(image).hexdigest()!=SHA256:raise ValueError('Unrecognized firmware image')
    base=0x08020000;stop=base+0x40
    u=Uc(UC_ARCH_ARM,UC_MODE_THUMB|UC_MODE_MCLASS)
    for address,size in [(base,0x80000),(0x24000000,0x80000),(0x20000000,0x20000)]:u.mem_map(address,size)
    u.mem_write(base,image);u.mem_write(0x24000000,image[0x6f3cc:0x6f3cc+0x3e04])
    u.reg_write(UC_ARM_REG_SP,0x2001f000);u.reg_write(UC_ARM_REG_LR,stop|1)
    def code_guard(emu,address,size,_):
        if address==stop:emu.emu_stop();return
        if not 0x0803dba4<=address<0x0803f5c0:raise ValueError(f'Execution outside table initializer: {address:#x}')
    def write_guard(emu,access,address,size,value,_):
        if not (0x24000000<=address and address+size<=0x24080000 or 0x20000000<=address and address+size<=0x20020000):
            raise ValueError(f'Write outside emulated SRAM: {address:#x}')
    code_hook=u.hook_add(UC_HOOK_CODE,code_guard)
    u.hook_add(UC_HOOK_MEM_WRITE,write_guard)
    u.emu_start(0x0803dba5,stop,count=20000)
    if u.reg_read(UC_ARM_REG_PC)!=stop:raise ValueError('Initializer did not return normally')
    u.hook_del(code_hook)
    return u,image


def extract():
    u,image=initialized_tables()
    def records(address,count):
        rows=[]
        for index in range(count):
            name=bytes(u.mem_read(address+40*index,32)).split(b'\0')[0].decode('ascii')
            if not name or not all(32<=ord(c)<127 for c in name):raise ValueError('Invalid preset name')
            rows.append({'number':index+1,'midi_index':index,'name':name,
                         'kind':'user-slot-default-label' if name.startswith('User Sound ') else 'factory',
                         'remote_selectable':True})
        return rows
    sound=records(0x24048100,100);bass=records(0x24047f20,12)
    assert [r['name'] for r in sound[:2]]==['Orchid EP','Ghost']
    assert bass[6]['name']=='RP chill bass' and bass[7]['name']=='Fuzzy'
    assert all(sound[i+70]['name']==f'User Sound {i+1:02}' for i in range(30))
    perform=[]
    for index in range(9):
        name=image[0x2915c+16*index:0x2915c+16*(index+1)].split(b'\0')[0].decode('ascii')
        perform.append({'table_index':index,'name':name,'remote_selectable':False,
                        'menu_label':{0:None,2:'Strum 2 Octaves',8:None}.get(index,name),
                        'note':{0:'Off state label, not the menu Exit item.',8:'Internal label; not present in the inspected normal Perform menu.'}.get(index,'Physical Perform mode; independent setter not established. See perform-options for preset recall.')})
    assert [r['name'] for r in perform]==['Off','Strum','Strum 2 Oct','Slop','Arpeggiate','Arp 2 Octaves','Pattern','Harp','Two Note']
    js=(ROOT/'research/pistil-embedded.js').read_text()
    fx={key:[{'raw':i,'name':name,'remote_selectable':True} for i,name in enumerate(json.loads(re.search(rf'{key}:(\[[^\]]+\])',js.split('cB={',1)[1]).group(1)))] for key in ['fx1','fx2']}
    return {'firmware_sha256':SHA256,'firmware':'3.92 / device display v3.9.2',
            'provenance':{'initializer':'0x0803DBA4','sound_table':'0x24048100','bass_table':'0x24047F20','preset_stride':40,'perform_label_table':'0x0804915C','perform_label_stride':16,'fx_names':'saved Pistil 1.0.2 frontend cB.fx1/cB.fx2'},
            'sound':sound,'bass':bass,'perform':perform,**fx,
            'notes':['Preset numbers are 1-based; MIDI indices are 0-based.',
                     'User Sound names are default slot labels, not a readback of customized hardware names.',
                     'Perform table indices are NOT MIDI setter values. No independent Perform setter was found; perform-options lists the preset-recall workaround.',
                     'Off and Two Note are internal state labels, not additional verified selectable menu entries.']}


if __name__=='__main__':
    destination=ROOT/'src/orchid_midi_cli/presets.json'
    destination.write_text(json.dumps(extract(),indent=2)+'\n')
    print(destination)
