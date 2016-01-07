#!/bin/bash
/root/make_folders.sh 
cp --remove-destination /root/settings.json /root/.config/transmission-daemon
transmission-daemon --foreground 1>/dev/null 2>/dev/null
