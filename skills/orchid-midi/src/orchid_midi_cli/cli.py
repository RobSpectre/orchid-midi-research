"""The only live-control entry point for the portable Orchid skill."""
import argparse
import json
import math
import sys
import time
from datetime import datetime, timezone
from pathlib import Path
from . import __version__, settings
from .protocol import (CATALOG, PARAMETERS, PRESETS, resolve_preset, ENGINES, LIMITS, QUERIES, RESPONSES, UNSUPPORTED,
                       decode, integer, parameter_packet, preset_packet, voicing_packet,
                       vendor, configuration_plan, engine_id)
from .transport import MidiSession, API_NAMES


def emit(**data):
    print(json.dumps(data,ensure_ascii=False),flush=True)


def parser():
    common=argparse.ArgumentParser(add_help=False,argument_default=argparse.SUPPRESS)
    common.add_argument('--input',help='Exact input port name or index; otherwise detect Orchid')
    common.add_argument('--output',help='Exact output port name or index; otherwise detect Orchid')
    common.add_argument('--name',help='Use the same exact name for input and output')
    common.add_argument('--api',choices=API_NAMES,help='Native RtMidi API (auto by default)')
    common.add_argument('--timeout',type=float,help='Query timeout in seconds, 0.05–60')
    common.add_argument('--interval',type=float,help='Minimum gap between writes, 0.001–2 seconds')
    common.add_argument('--dry-run',action='store_true',help='Validate and print without importing the MIDI backend')
    p=argparse.ArgumentParser(prog='orchid-midi',parents=[common],description='Portable Orchid control. JSON output; no amidi, shell MIDI, flash or maintenance commands.')
    p.add_argument('--version',action='version',version=__version__)
    subs=p.add_subparsers(dest='command',required=True)
    def sub(name,help,aliases=()):return subs.add_parser(name,help=help,aliases=list(aliases),parents=[common])
    sub('ports','List MIDI inputs, outputs and compiled APIs',('list',))
    sub('config','Show saved endpoint preferences')
    c=sub('configure','Save supplied port/API/timeout preferences; no device traffic')
    c.add_argument('--reset',action='store_true',help='Reset to automatic Orchid detection')
    sub('capabilities','List supported controls, evidence and unresolved controls')
    c=sub('presets','List explicit Sound, Bass, Perform and FX name mappings',('names',))
    c.add_argument('category',nargs='?',choices=['all','sound','bass','perform','fx1','fx2'],default='all')
    c=sub('parameters','List all parameter names, raw ranges, defaults and enum labels',('catalog',))
    c.add_argument('--engine',default='sound',choices=ENGINES);c.add_argument('--filter',default='')
    c=sub('identity','Request and parse the device identity')
    sub('status','Query identity, presets and voicings; not a complete settings backup')
    c=sub('query','Read available preset/voicing/slot information');c.add_argument('target',choices=QUERIES)
    for name,target in [('query-sound','sound'),('query-bass','bass'),('query-chord-voicing','chord-voicing'),('query-bass-voicing','bass-voicing')]:
        sub(name,'Compatibility query alias').set_defaults(target=target)
    c=sub('listen','Passively capture incoming MIDI as JSONL');c.add_argument('--seconds',type=float,default=30)
    c.add_argument('--include-clock',action='store_true');c.add_argument('--file',type=Path)
    for voice in ('sound','bass'):
        c=sub(voice,f'Select {voice} preset by full name or 1-based number');c.add_argument('value')
    for voice in ('chord','bass'):
        c=sub(f'{voice}-voicing','Set absolute voicing');c.add_argument('value',type=int)
    c=sub('set','Set any named sound/bass parameter or bounded drum/global index')
    c.add_argument('engine',choices=ENGINES);c.add_argument('parameter');c.add_argument('value')
    c.add_argument('--scale',choices=['raw','normalized','percent'],default='raw')
    for name in ('reverb','filter','phaser','chorus'):
        c=sub(name,'Set sound FX amount (effect type must already match for Phaser/Chorus)')
        c.add_argument('value');c.add_argument('--engine',choices=['sound','bass'],default='sound')
        c.add_argument('--scale',choices=['raw','normalized','percent'],default='raw')
    c=sub('toggle','Toggle current bass enable or FX lock once (not an absolute on/off setter)')
    c.add_argument('target',choices=['bass','fx-lock'])
    c=sub('apply','Apply a fully validated JSON configuration; no preset-slot saving')
    c.add_argument('file',type=Path)
    c=sub('note','Play one bounded MIDI note and release it')
    c.add_argument('note',type=int);c.add_argument('--channel',type=int,choices=[1,2],default=1)
    c.add_argument('--velocity',type=int,default=80);c.add_argument('--duration',type=float,default=0.5)
    for name in ('modulation','sustain','pitch-bend','all-notes-off','all-sound-off','reset-controllers'):
        c=sub(name,'Standard MIDI voice control found in the receiver (not panel transport)')
        if name in ('modulation','sustain','pitch-bend'):c.add_argument('value',type=int)
        c.add_argument('--channel',type=int,choices=[1,2],default=1)
    # Explicitly refuse tempting but unsupported action names before opening MIDI.
    for name in (*UNSUPPORTED,'probe-stock-service'):
        c=sub(name,'Unsupported: reports an explanation without sending MIDI')
        c.add_argument('arguments',nargs='*')
    return p


def build_plan(a):
    cmd=a.command
    if cmd in UNSUPPORTED or cmd=='probe-stock-service':
        raise ValueError('DISABLED: '+UNSUPPORTED.get(cmd,UNSUPPORTED['maintenance']))
    if cmd in ('sound','bass'):
        number=resolve_preset(cmd,a.value)
        return [(preset_packet(cmd,number),{'operation':cmd,'preset':number,'name':PRESETS[cmd][number-1]['name'],'evidence':'firmware-initializer-and-recorded-examples'})]
    if cmd in ('chord-voicing','bass-voicing'):return [(voicing_packet(cmd.split('-')[0],a.value),{'operation':cmd,'raw':a.value})]
    if cmd=='set':return [parameter_packet(a.engine,a.parameter,a.value,a.scale)]
    if cmd in ('reverb','filter','phaser','chorus'):return [parameter_packet(a.engine,cmd,a.value,a.scale)]
    if cmd=='apply':return configuration_plan(json.loads(a.file.read_text()))
    if cmd=='toggle':return [(vendor(0x43 if a.target=='bass' else 0x48),{'operation':'toggle','target':a.target,'evidence':'firmware-receiver; not hardware-tested'})]
    if cmd in ('identity','status'):return [(bytes.fromhex('f0 7e 7f 06 01 f7'),{'query':'identity'})]+(
        [(vendor(QUERIES[t]),{'query':t}) for t in ('sound','bass','chord-voicing','bass-voicing')] if cmd=='status' else [])
    if cmd=='query' or cmd.startswith('query-'):return [(vendor(QUERIES[a.target]),{'query':a.target})]
    if cmd=='note':
        note=integer(a.note,0,127,'note');velocity=integer(a.velocity,1,127,'velocity')
        if not math.isfinite(a.duration) or not 0.01<=a.duration<=30:raise ValueError('duration must be in 0.01–30 seconds')
        return [(bytes([0x90+a.channel-1,note,velocity]),{'operation':'note-on','duration':a.duration}),
                (bytes([0x80+a.channel-1,note,0]),{'operation':'note-off'})]
    if cmd in ('modulation','sustain','all-notes-off','all-sound-off','reset-controllers'):
        cc={'modulation':1,'sustain':64,'all-notes-off':123,'all-sound-off':120,'reset-controllers':121}[cmd]
        v=integer(getattr(a,'value',0),0,127,'CC value')
        return [(bytes([0xb0+a.channel-1,cc,v]),{'operation':cmd,'raw':v,'evidence':'firmware-receiver'})]
    if cmd=='pitch-bend':
        v=integer(a.value,-8192,8191,'pitch bend')+8192
        return [(bytes([0xe0+a.channel-1,v&127,v>>7]),{'operation':cmd,'value':a.value,'evidence':'firmware-channel-handler'})]
    return []


def response_matches(message, metadata):
    if metadata.get('operation')=='toggle':return message.get('command')==(0x43 if metadata['target']=='bass' else 0x48) and 'enabled' in message
    target=metadata['query']
    if target=='identity':return message.get('type')=='identity'
    if message.get('type')!='orchid_reply' or message.get('command')!=RESPONSES[target]:return False
    if target in ('chord-voicing','bass-voicing'):return 'voicing_raw' in message
    if target in ('sound','bass','bass-refresh'):return 'preset' in message
    return bool(message.get('payload'))


def await_reply(midi,metadata,timeout):
    deadline=time.monotonic()+timeout
    while time.monotonic()<deadline:
        data=midi.receive()
        if data is None:time.sleep(0.002);continue
        message=decode(data)
        if response_matches(message,metadata):return message
    raise TimeoutError(f'No matching reply for {metadata} in {timeout:g}s. Command was sent; do not retry a toggle automatically.')


def run(a, session_factory=MidiSession):
    cmd=a.command
    # Validate every write before configuration loading or device enumeration.
    plan=build_plan(a)
    if cmd in ('presets','names'):
        categories=['sound','bass','perform','fx1','fx2'] if a.category=='all' else [a.category]
        emit(firmware=PRESETS['firmware'],notes=PRESETS['notes'],**{key:PRESETS[key] for key in categories});return 0
    if cmd=='capabilities':
        emit(version=__version__,backend='python-rtmidi',platforms=['macOS/CoreMIDI','Linux/ALSA or JACK','Windows/WinMM'],
             parameters_per_voice=135,configurable_parameters_per_voice=134,
             engine_index_ranges=LIMITS,presets={'sound':[1,100],'bass':[1,12]},
             preset_names=True,queries=QUERIES,toggles=['bass','fx-lock'],unsupported=UNSUPPORTED,
             verification='Only recorded controls were tested on hardware; others are static mappings.');return 0
    if cmd in ('parameters','catalog'):
        e=engine_id(a.engine)
        rows=PARAMETERS if e<2 else [dict(index=i,name=f'PARAM_{i}',minimum=0,maximum=127,evidence='firmware-index-range-only') for i in range(LIMITS[e]+1)]
        emit(engine=e,parameters=[r for r in rows if a.filter.casefold() in json.dumps(r).casefold()],source=CATALOG['source']);return 0
    if getattr(a,'dry_run',False):
        settings.validate({key:getattr(a,key) for key in settings.DEFAULTS if hasattr(a,key)})
        emit(dry_run=True,command=cmd,packets=[{**meta,'hex':data.hex(' ')} for data,meta in plan]);return 0
    preferences=settings.validate({}) if cmd=='configure' and a.reset else settings.load()
    overrides={key:getattr(a,key) for key in settings.DEFAULTS if hasattr(a,key)}
    if getattr(a,'name',None):overrides.update(input=a.name,output=a.name)
    preferences=settings.validate({**preferences,**overrides})
    if cmd=='config':emit(path=str(settings.config_path()),**preferences);return 0
    if cmd=='configure':
        if a.reset:preferences=settings.validate(overrides)
        path=settings.save(preferences);emit(saved=str(path),**preferences);return 0
    if cmd=='listen' and (not math.isfinite(a.seconds) or not 0<a.seconds<=3600):raise ValueError('seconds must be in (0,3600]')
    midi=session_factory(api=preferences['api'],input_port=preferences['input'],output_port=preferences['output'])
    with midi:
        if cmd in ('ports','list'):emit(**midi.ports());return 0
        needs_reply=cmd in ('identity','status','query','toggle') or cmd.startswith('query-')
        midi.open(receive=needs_reply or cmd=='listen',send=cmd!='listen')
        if cmd=='listen':
            # Exclusive creation prevents silently destroying a previous recording.
            handle=a.file.open('x') if a.file else None
            try:
                deadline=time.monotonic()+a.seconds
                while time.monotonic()<deadline:
                    data=midi.receive()
                    if data is None:time.sleep(0.002);continue
                    if data==b'\xf8' and not a.include_clock:continue
                    record={'utc':datetime.now(timezone.utc).isoformat(),'direction':'orchid-to-mac',**decode(data)}
                    emit(**record)
                    if handle:handle.write(json.dumps(record)+'\n');handle.flush()
            finally:
                if handle:handle.close()
            return 0
        if cmd=='note':
            midi.send(plan[0][0])
            try:time.sleep(a.duration)
            finally:midi.send(plan[1][0])
            emit(sent=True,verified=False,packets=[d.hex(' ') for d,_ in plan]);return 0
        for i,(data,metadata) in enumerate(plan):
            if i:time.sleep(preferences['interval'])
            midi.send(data)
            emit(event='sent',hex=data.hex(' '),verified=False,**metadata)
            if needs_reply:
                reply=await_reply(midi,metadata,preferences['timeout'])
                emit(event='reply',**reply)
        # Keep the native port alive while the final short SysEx is delivered.
        time.sleep(max(0.05,preferences['interval']))
        return 0


def main(argv=None):
    try:
        a=parser().parse_args(argv)
        return run(a)
    except (ValueError,RuntimeError,OSError,TimeoutError) as exc:
        print(json.dumps({'error':str(exc)}),file=sys.stderr);return 2
    except KeyboardInterrupt:
        print(json.dumps({'error':'Interrupted; device state may reflect completed writes.'}),file=sys.stderr);return 130
