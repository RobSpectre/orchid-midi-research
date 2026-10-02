#!/usr/bin/env python3
"""Offline Key/master Volume audit. No MIDI, USB or maintenance access.

Executes the actual channel/CC receivers against a synthetic DSP object to
check ignored report messages. The object snapshot is not a hardware dump.
"""
import json
from extract_preset_catalog import initialized_tables, SHA256, ROOT


def audit():
    u,image=initialized_tables()
    from unicorn import UC_HOOK_CODE
    from unicorn.arm_const import UC_ARM_REG_R0, UC_ARM_REG_R1, UC_ARM_REG_SP, UC_ARM_REG_LR, UC_ARM_REG_PC
    u.mem_map(0,0x7000);u.mem_write(0,image[0x2cc:0x2cc+0x6b78])
    stop=0x08020040;obj=0x24010000;packet=0x24030000
    initial=bytes([0x55])*0x7000
    tested=[];trace=[]
    def guard(emu,address,size,_):
        trace.append(address)
        if address==stop:emu.emu_stop();return
        if not (0x51cc<=address<0x5248 or 0x4c30<=address<0x4d78):
            raise ValueError(f'Unexpected receiver branch: {address:#x}')
    u.hook_add(UC_HOOK_CODE,guard)
    for channel in range(16):
        for cc in [7,107,108,113]:
            for value in [0,1,85,127]:
                data=bytes([0xb0+channel,cc,value])
                u.mem_write(obj,initial);u.mem_write(packet,data)
                for reg,v in [(UC_ARM_REG_R0,obj),(UC_ARM_REG_R1,packet),
                              (UC_ARM_REG_SP,0x2001f000),(UC_ARM_REG_LR,stop|1)]:u.reg_write(reg,v)
                trace.clear();u.emu_start(0x51cd,stop,count=1000)
                assert u.reg_read(UC_ARM_REG_PC)==stop
                assert 0x4c86 in trace
                assert bytes(u.mem_read(obj,len(initial)))==initial
                tested.append({'channel':channel+1,'cc':cc,'value':value,'dsp_state_changed':False})
    roots=[image[0x531cc+i*3:0x531cc+(i+1)*3].split(b'\0')[0].decode('ascii') for i in range(21)]
    keys=[{'report_value':i,'firmware_root_label':roots[i%21],
           'quality':'Major' if i<21 else 'Minor'} for i in range(42)]
    return {'firmware_sha256':SHA256,'execution':'Actual channel/CC receiver, guarded offline emulator, synthetic state',
            'live_writes_sent':False,'receiver_cases':tested,'key_report_labels':keys,
            'key':{'selection':'Controller+0x38; setter 0x08034954; emits CC107',
                   'enabled':'Controller+0x3c; setter 0x08034AE8; emits CC108',
                   'other_writers':'Session-state loader 0x08035408 writes key and enable fields; called from stored-state loader 0x0803B2xx/0x0803B3xx.',
                   'preset_recall':'Sound-select route loads only Perform metadata +0x24/+0x25, not Key state.',
                   'incoming_route':'No ordinary incoming MIDI branch to these setters or the session loader identified.'},
            'volume':{'panel_range':[0,99],'panel_state':'Voice/controller object +4; absolute setter 0x080317CC',
                      'relative_setter':'0x0803182C adds delta then calls absolute setter',
                      'outgoing':'Main rotary handler 0x0803ABF2 emits CC113 with signed step, not current display value.',
                      'audio_gain':'0x080317CC calls veneer 0x080490B0 -> ITCM 0x4154; writes DSP+0x6668 float. Also scales click/beep level via 0x080307F4.',
                      'global_parameter_2':'Writes DSP+0x6B2 and is used as an audio crossfade at ITCM0x3E1A; not the physical master Volume state or its gain coefficient.',
                      'other_writers':'Stored settings loader 0x080326C0 and controller state loader can call the master setter; no normal MIDI dispatch path identified.'},
            'limits':['Ignored receiver cases are verified offline, not live replay tests.',
                      'Direct-call and state traces do not constitute formal whole-program proof of every computed path.',
                      'Only firmware 3.92 was inspected; no firmware modification or device memory access was attempted.',
                      'No remote Key/master Volume setter is established. Do not substitute oscillator pitch, voice gain, or an unrelated global DSP parameter.']}


if __name__=='__main__':
    result=audit()
    path=ROOT/'captures/key-volume-route-audit.json'
    path.write_text(json.dumps(result,indent=2)+'\n')
    print(json.dumps({'report':str(path),'ignored_receiver_cases':len(result['receiver_cases'])}))
