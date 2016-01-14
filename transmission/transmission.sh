#!/bin/bash
/root/make_folders.sh 
cp --remove-destination /root/settings.json /etc/transmission-daemon
#transmission-daemon --foreground 1>/dev/null 2>/dev/null
service transmission-daemon start && /root/hold_server.py
