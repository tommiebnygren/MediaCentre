#!/bin/bash
/root/make_folders.sh 
chown -R debian-transmission /var/lib/transmission-daemon
chgrp -R debian-transmission /var/lib/transmission-daemon
chmod -R 666 $MEDIA_PATH
cp --remove-destination /root/settings.json /var/lib/transmission-daemon/info
cp --remove-destination /root/settings.json /etc/transmission-daemon
service transmission-daemon start 
/root/hold_server.py
