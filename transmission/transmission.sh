#!/bin/bash
mkdir -p /media/Storage/Downloads/incomplete
mkdir -p /media/Storage/Downloads/torrents
mkdir -p /media/Storage/TV\ Shows
mkdir -p /media/Storage/Movies
mkdir -p mkdir -p /var/lib/transmission-daemon/info /var/lib/transmission-daemon/downloads /var/lib/transmission-daemon/watchdir

#chmod -R 777 /root/Storage
#usermod -a -G debian-transmission root
#chown -R debian-transmission:debian-transmission /var/lib/transmission-daemon

service transmission-daemon start 
/root/hold_server.py
