#!/bin/bash
/root/make_folders.sh 
cp --remove-destination /root/settings.json /etc/transmission-daemon
chown -R debian-transmission /var/lib/transmission-daemon
chgrp -R debian-transmission /var/lib/transmission-daemon
chmod -R 666 $MEDIA_PATH
#transmission-daemon --foreground 1>/dev/null 2>/dev/null
service transmission-daemon start && /root/hold_server.py
