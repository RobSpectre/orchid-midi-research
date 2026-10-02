"""python-rtmidi adapter. Never invokes platform MIDI shell commands."""
import time

API_NAMES={'auto':'API_UNSPECIFIED','alsa':'API_LINUX_ALSA','jack':'API_UNIX_JACK',
           'coremidi':'API_MACOSX_CORE','winmm':'API_WINDOWS_MM'}


def select_port(names, selector=None):
    if selector is not None:
        # Explicit numeric indices disambiguate identical port names.
        if str(selector).isdigit():
            index=int(selector)
            if 0<=index<len(names):return index
            raise ValueError(f'Port index {index} is unavailable; run orchid-midi ports')
        matches=[i for i,name in enumerate(names) if name==selector]
    else:
        matches=[i for i,name in enumerate(names) if 'orchid' in name.casefold()]
    if len(matches)!=1:
        raise ValueError(f'Expected one Orchid port, found {len(matches)} matches. Use --input/--output with an exact name or index; run orchid-midi ports.')
    return matches[0]


class MidiSession:
    def __init__(self, api='auto', input_port=None, output_port=None, module=None):
        if module is None:
            try: import rtmidi as module
            except ImportError as exc:
                raise RuntimeError('python-rtmidi is missing. Reinstall orchid-midi-research in this Python environment; do not use amidi as a fallback.') from exc
        self.module=module
        self.api=getattr(module,API_NAMES[api])
        if api!='auto' and self.api not in module.get_compiled_api():
            raise ValueError(f'MIDI API {api} is unavailable in this build')
        self.input_selector=input_port;self.output_selector=output_port
        self.input=None;self.output=None

    def ports(self):
        result={}
        for kind,constructor in [('inputs',self.module.MidiIn),('outputs',self.module.MidiOut)]:
            port=constructor(rtapi=self.api)
            try:result[kind]=[{'index':i,'name':name} for i,name in enumerate(port.get_ports())]
            finally:port.delete()
        result['apis']=[name for name,attr in API_NAMES.items() if name!='auto' and getattr(self.module,attr) in self.module.get_compiled_api()]
        return result

    def open(self, receive=False, send=True):
        try:
            if receive:
                self.input=self.module.MidiIn(rtapi=self.api,queue_size_limit=16384)
                self.input.ignore_types(sysex=False,timing=False,active_sense=False)
                index=select_port(self.input.get_ports(),self.input_selector)
                self.input.open_port(index,'Orchid CLI input')
            if send:
                self.output=self.module.MidiOut(rtapi=self.api)
                index=select_port(self.output.get_ports(),self.output_selector)
                self.output.open_port(index,'Orchid CLI output')
            if receive:time.sleep(0.05)
            return self
        except Exception:
            self.close();raise

    def send(self, data):
        self.output.send_message(list(data))

    def receive(self):
        item=self.input.get_message()
        return bytes(item[0]) if item else None

    def close(self):
        for attr in ('input','output'):
            port=getattr(self,attr)
            if port is not None:
                try:port.close_port()
                finally:port.delete();setattr(self,attr,None)

    def __enter__(self):return self
    def __exit__(self,*_):self.close()
