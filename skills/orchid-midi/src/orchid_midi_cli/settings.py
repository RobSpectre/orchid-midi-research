"""Optional persistent endpoint preferences; never store device state guesses."""
import json
import math
import os
from pathlib import Path
from .transport import API_NAMES

DEFAULTS={'api':'auto','input':None,'output':None,'timeout':2.0,'interval':0.02}


def config_path():
    if os.environ.get('ORCHID_CONFIG'):return Path(os.environ['ORCHID_CONFIG']).expanduser()
    if os.name=='nt':base=Path(os.environ.get('APPDATA',Path.home()/'AppData/Roaming'))
    else:base=Path(os.environ.get('XDG_CONFIG_HOME',Path.home()/'.config'))
    return base/'orchid-midi'/'config.json'


def validate(values):
    if not isinstance(values,dict) or set(values)-set(DEFAULTS):raise ValueError('Unknown endpoint configuration fields')
    merged={**DEFAULTS,**values}
    if merged['api'] not in API_NAMES:raise ValueError('Unknown MIDI API')
    for key,lower,upper in [('timeout',0.05,60),('interval',0.001,2)]:
        if isinstance(merged[key],bool):raise ValueError(f'Invalid {key}')
        try:v=float(merged[key])
        except (ValueError,TypeError):raise ValueError(f'{key} must be numeric') from None
        if not math.isfinite(v) or not lower<=v<=upper:raise ValueError(f'{key} must be in {lower}–{upper}')
        merged[key]=v
    for key in ('input','output'):
        if merged[key] is not None and (not isinstance(merged[key],str) or not merged[key]):raise ValueError(f'{key} must be a nonempty port name/index string')
    return merged


def load():
    path=config_path()
    return validate(json.loads(path.read_text()) if path.exists() else {})


def save(values):
    values=validate(values);path=config_path();path.parent.mkdir(parents=True,exist_ok=True)
    temporary=path.with_suffix('.tmp');temporary.write_text(json.dumps(values,indent=2)+'\n');temporary.replace(path)
    return path
