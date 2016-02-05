#!/bin/bash
mkdir -p /media/Storage/Downloads/incomplete
mkdir -p /media/Storage/Downloads/torrents
mkdir -p /media/Storage/TV\ Shows
mkdir -p /media/Storage/Movies
mkdir -p /var/lib/transmission-daemon/info /var/lib/transmission-daemon/downloads
chmod -R 777 /media/Storage

chown -R debian-transmission /var/lib/transmission-daemon
chgrp -R debian-transmission /var/lib/transmission-daemon

cp --remove-destination /root/settings.json /var/lib/transmission-daemon/info
cp --remove-destination /root/settings.json /etc/transmission-daemon
service transmission-daemon start 
/root/hold_server.py
