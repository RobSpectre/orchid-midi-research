"""Pure packet construction and response decoding. No hardware imports."""
import json
import math
from importlib.resources import files

CATALOG = json.loads(files(__package__).joinpath('parameters.json').read_text())
PARAMETERS = CATALOG['parameters']
ENGINES = {'sound':0, 'treble':0, 'bass':1, 'drums':2, 'global':3}
LIMITS = {0:134, 1:134, 2:52, 3:35}
ALIASES = {'FILTER':'CUTOFF', 'REVERB':'REVSEND', 'PHASER':'FX1P2', 'CHORUS':'FX2P2'}
QUERIES = {'sound':0x51,'bass':0x54,'chord-voicing':0x52,'bass-voicing':0x55,
           'sound-slots':0x50,'bass-refresh':0x53,'info':0x56}
# 0x53 produces a leading 0 response and then 0x54, not a 0x53 response.
RESPONSES = {**QUERIES, 'bass-refresh':0x54}
UNSUPPORTED = {
    'perform':'CC103/104 are outgoing reports; no independent incoming setter found.',
    'key':'CC107/108 reports did not work as incoming controls.',
    'loop':'Incoming Start/Stop did not control the physical looper.',
    'bpm':'Incoming CC112 and clock did not change hardware tempo or start drums.',
    'drum-transport':'Start, Continue, clock and MMC did not start drums; Stop did not stop them.',
    'options':'No remote menu-navigation or encoder-press command found.',
    'master-volume':'Voice GAIN/RPVOL are not hardware master Volume.',
    'preset-save':'Persistent slot writing was traced but is not a verified configuration operation.',
    'maintenance':'Blocked: command 0x73 caused a loud sustained tone and reboot. No maintenance/flash API.',
}
ALLOWED_COMMANDS = {0x35,0x3f,0x43,0x45,0x46,0x47,0x48,*QUERIES.values()}


def integer(value, minimum, maximum, label):
    if isinstance(value, bool):
        raise ValueError(f'{label} requires an integer, not a boolean')
    try:
        number = int(value)
    except (ValueError, TypeError, OverflowError):
        raise ValueError(f'{label} requires an integer in {minimum}–{maximum}') from None
    if isinstance(value, float) and value != number:
        raise ValueError(f'{label} requires an integer')
    if not minimum <= number <= maximum:
        raise ValueError(f'{label} must be in {minimum}–{maximum}')
    return number


def vendor(command, payload=()):
    if command not in ALLOWED_COMMANDS:
        raise ValueError('Command is outside the researched non-maintenance allowlist')
    body = bytes([0,0x22,0x0c,1,command,*[integer(x,0,127,'SysEx value') for x in payload]])
    return bytes([0xf0])+body+bytes([(-sum(body))&127,0xf7])


def engine_id(engine):
    if isinstance(engine, str) and engine.lower() in ENGINES:
        return ENGINES[engine.lower()]
    return integer(engine,0,3,'engine')


def parameter(engine, name):
    engine = engine_id(engine)
    text = str(name).upper().replace('-','_')
    for prefix, expected in [('TREBLE_',0),('SOUND_',0),('BASS_',1)]:
        if text.startswith(prefix):
            if engine != expected: raise ValueError('Parameter prefix does not match the selected engine')
            text = text[len(prefix):]
            break
    text = ALIASES.get(text,text)
    if text.isdigit():
        index = integer(text,0,LIMITS[engine],'parameter index')
        if engine < 2: return PARAMETERS[index]
        return dict(index=index,name=f'PARAM_{index}',minimum=0,maximum=127,writable=True,
                    evidence='firmware-index-range-only',label='Unmapped DSP parameter')
    if engine >= 2:
        raise ValueError('Drum/global parameter names are not established; use a bounded numeric index')
    for row in PARAMETERS:
        if row['name'] == text: return row
    raise ValueError(f'Unknown parameter {name!r}; run orchid-midi parameters')


def raw_value(row, value, scale='raw'):
    if scale != 'raw':
        try: v=float(value)
        except (TypeError,ValueError): raise ValueError('Scaled value must be numeric') from None
        maximum = 100 if scale == 'percent' else 1
        if not math.isfinite(v) or not 0 <= v <= maximum:
            raise ValueError(f'{scale} value must be finite and in 0–{maximum}')
        return row['minimum'] + math.floor((row['maximum']-row['minimum'])*v/maximum+0.5)
    # Numeric input always means raw. Prefix a numeric enum label with label:.
    text = str(value)
    if text.startswith('label:'): text=text[6:]; numeric=False
    else:
        try: int(text); numeric=True
        except ValueError: numeric=False
    if not numeric and 'choices' in row:
        key=text.upper().replace('_',' ').replace('-',' ')
        matches=[i for i,c in enumerate(row['choices']) if c.upper().replace('_',' ').replace('-',' ')==key]
        if len(matches)==1:return matches[0]
    return integer(value,row['minimum'],row['maximum'],row['name'])


def parameter_packet(engine, name, value, scale='raw'):
    e=engine_id(engine); row=parameter(e,name)
    if not row['writable']: raise ValueError(f'{row["name"]} is version metadata, not a configurable control')
    raw=raw_value(row,value,scale); index=row['index']
    return vendor(0x47,[e,index&127,index>>7,raw]),dict(engine=e,parameter=row['name'],index=index,raw=raw,
        evidence='hardware-verified-examples' if e==0 and index in (68,102,109,114) else row['evidence'])


def preset_packet(voice, number):
    number=integer(number,1,100 if voice=='sound' else 12,f'{voice} preset')
    return vendor(0x35 if voice=='sound' else 0x3f,[number-1])


def voicing_packet(voice, value):
    return vendor(0x45 if voice=='chord' else 0x46,[integer(value,1 if voice=='chord' else 0,
        60 if voice=='chord' else 48,'absolute raw value')])


def decode(data):
    data=bytes(data)
    result={'hex':data.hex(' ')}
    if data.startswith(bytes.fromhex('f0 00 22 0c 01 7e')) and data[-1:]==b'\xf7' and len(data)>=8:
        code=data[6]; payload=data[7:-1]
        result.update(type='orchid_reply',command=code,payload=list(payload))
        if code in (0x45,0x46,0x52,0x55) and len(payload)==1:result['voicing_raw']=payload[0]
        elif code in (0x43,0x48) and len(payload)==1:result['enabled']=bool(payload[0])
        elif code in (0x51,0x54) and len(payload)>=2:
            result.update(preset=payload[0]+1,name=payload[1:].split(b'\0')[0].decode('ascii',errors='replace'))
    elif len(data)==17 and data[:2]==b'\xf0\x7e' and data[3:8]==bytes.fromhex('06 02 00 22 0c') and data[-1]==0xf7:
        result.update(type='identity',manufacturer='Telepathic Instruments',version_bytes=list(data[12:16]),
                      matches_researched_version=data==bytes.fromhex('f0 7e 7f 06 02 00 22 0c 01 01 00 00 33 2e 09 02 f7'))
    elif data==b'\xf8':result['type']='clock'
    else:result['type']='midi'
    return result


def configuration_plan(config):
    """Validate every operation before returning any packets; no implicit defaults."""
    allowed={'schema_version','sound_preset','bass_preset','chord_voicing','bass_voicing','parameters'}
    if not isinstance(config,dict) or set(config)-allowed:
        raise ValueError('Configuration must be an object with only schema_version, presets, voicings and parameters')
    if type(config.get('schema_version',1)) is not int or config.get('schema_version',1)!=1:raise ValueError('Unsupported configuration schema_version')
    plan=[]
    for voice in ('sound','bass'):
        key=f'{voice}_preset'
        if key in config:plan.append((preset_packet(voice,config[key]),{'operation':key,'value':config[key]}))
    for voice in ('chord','bass'):
        key=f'{voice}_voicing'
        if key in config:plan.append((voicing_packet(voice,config[key]),{'operation':key,'value':config[key]}))
    params=config.get('parameters',{})
    if not isinstance(params,dict):raise ValueError('parameters must be an object keyed by engine')
    for engine,values in params.items():
        if not isinstance(values,dict):raise ValueError('Each engine must contain parameter/value pairs')
        entries=[(parameter(engine,key)['index'],key,value) for key,value in values.items()]
        if len({i for i,_,_ in entries})!=len(entries):raise ValueError('Duplicate parameter aliases in configuration')
        # Model and effect types precede their dependent settings regardless of JSON order.
        entries.sort(key=lambda x:(0 if x[0] in (1,100,107) else 1,x[0]))
        for _,key,value in entries:plan.append(parameter_packet(engine,key,value))
    if not plan:raise ValueError('Configuration contains no settings')
    if len(plan)>400:raise ValueError('Configuration exceeds 400 writes')
    return plan
