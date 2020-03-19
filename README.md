## Introduction

This is an osquery extension to perform actions like blocking ip/port and killing process.
It use iptable to perform actions. It is for Linux systems only. 


## Execution

* `pip install osquery`
* `chmod +x active_response_extension.py`
* `sudo osqueryi --allow_unsafe --extension active_response_extension.py`

> Blocking IP and Port using iptables

    select * from active_response where action="iptable_rule" and arguments='{"-s": "45.10.23.67,45.68.98.0","-j": "DROP", "-A": "OUTPUT", "--dports": "67,78,96", "-p": "tcp", "-m": "multiport"}';

> Killing a process

    select * from active_response where action="process_kill" and arguments='{"signal":"9","pid":56776}';
    
## ScreenShots

![IPTABLE QUERY](lhttps://imgur.com/TkZhQup)

![PROCESS KILL QUERY](https://imgur.com/KLbaJhu)


## TODO

* Patching using `sudo apt-get install`
