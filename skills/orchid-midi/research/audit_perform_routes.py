#!/usr/bin/env python3
"""Offline trace of Sound selection into Perform setters; never opens MIDI.

Runs the real preset selector with explicit stubs at synth-load, Perform-setter,
and MIDI-output boundaries. This verifies arguments and control flow, not audio,
full firmware execution, or independent arbitrary Perform control.
"""
import json
import struct
from pathlib import Path
from extract_preset_catalog import initialized_tables, SHA256, ROOT


def audit():
    u,image=initialized_tables()
    from unicorn import UC_HOOK_CODE
    from unicorn.arm_const import UC_ARM_REG_R0, UC_ARM_REG_R1, UC_ARM_REG_R2, UC_ARM_REG_R3, UC_ARM_REG_SP, UC_ARM_REG_LR, UC_ARM_REG_PC
    registers=[UC_ARM_REG_R0,UC_ARM_REG_R1,UC_ARM_REG_R2,UC_ARM_REG_R3]
    stop=0x08020040;controller=0x24040000;voice=0x24041000
    stubs={0x08033c2c:'load_synth',0x08034e00:'perform_mode',0x08034c88:'perform_amount',
           0x08031f68:'outgoing_cc',0x08032038:'outgoing_sysex'}
    allowed=[(0x08035118,0x0803514a),(0x0803501c,0x08035112),
             (0x08031908,0x0803193e),(0x0803195c,0x080319c0),(0x0803db28,0x0803db74)]
    calls=[]
    def hook(emu,address,size,_):
        if address==stop:emu.emu_stop();return
        if address in stubs:
            calls.append({'function':stubs[address],'address':hex(address),
                          'arguments':[emu.reg_read(r) for r in registers]})
            emu.reg_write(UC_ARM_REG_PC,emu.reg_read(UC_ARM_REG_LR));return
        if not any(lo<=address<hi for lo,hi in allowed):
            raise ValueError(f'Unexpected execution address {address:#x}')
    handle=u.hook_add(UC_HOOK_CODE,hook)
    presets=[]
    for index in range(70):
        record=bytes(u.mem_read(0x24048100+40*index,40))
        name=record[:32].split(b'\0')[0].decode('ascii')
        mode,amount=record[36:38]
        u.mem_write(controller,bytes(0x600));u.mem_write(voice,bytes(0x200))
        u.mem_write(controller+4,struct.pack('<I',voice))
        calls.clear()
        for reg,value in [(UC_ARM_REG_R0,controller),(UC_ARM_REG_R1,index),
                          (UC_ARM_REG_SP,0x2001f000),(UC_ARM_REG_LR,stop|1)]:u.reg_write(reg,value)
        u.emu_start(0x08035119,stop,count=20000)
        if u.reg_read(UC_ARM_REG_PC)!=stop:raise ValueError('Selector did not return normally')
        perform=[c for c in calls if c['function'].startswith('perform_')]
        assert [c['function'] for c in perform]==['perform_mode','perform_amount']
        assert perform[0]['arguments']==[controller,mode,0,0]
        assert perform[1]['arguments'][0:3]==[controller,amount,0]
        assert sum(c['function']=='load_synth' for c in calls)==1
        label=image[0x2915c+mode*16:0x2915c+(mode+1)*16].split(b'\0')[0].decode('ascii')
        presets.append({'number':index+1,'name':name,'perform_mode':mode,'perform_name':label,
                        'perform_amount_raw':amount,'selector_calls_verified':True})
    u.hook_del(handle)
    # Both panel CC entries return immediately, regardless of data value/channel.
    cc_targets={str(cc):hex(0x4c52+2*image[0x2cc+0x4c52+cc-98]) for cc in [103,104]}
    assert set(cc_targets.values())=={'0x4c86'}
    return {'firmware_sha256':SHA256,'method':'Guarded offline preset-selector execution with explicit boundary stubs',
            'normal_command':'0x35 Sound select, zero-based slot',
            'route':['0x080461E8 SysEx branch','0x08035118 selector','0x0803501C load',
                     '0x080350F2 calls mode setter with record+0x24','0x0803510C calls amount setter with record+0x25'],
            'cc_report_receive_targets':cc_targets,'stubbed_functions':{hex(k):v for k,v in stubs.items()},
            'limitations':['No live MIDI is sent by this audit.',
                          'Mode and amount setters are intercepted, not executed; only caller arguments are verified.',
                          'Selecting a preset also reloads its synth parameters and changes the selected slot.',
                          'This does not provide arbitrary mode/amount selection independent of a preset.',
                          'User-slot metadata may differ from factory initialization and is not assumed.',
                          'Normal bulk command 0x34 writes only synth parameters through 0x08032148; it is not a Perform setter.',
                          'Command 0x36 persists a user preset; maintenance and persistent writes are not used.'],
            'factory_presets':presets}


if __name__=='__main__':
    result=audit()
    destination=ROOT/'captures/perform-preset-route-audit.json'
    destination.write_text(json.dumps(result,indent=2)+'\n')
    print(json.dumps({'report':str(destination),'factory_routes_verified':len(result['factory_presets'])}))
