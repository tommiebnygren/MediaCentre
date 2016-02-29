#!/bin/bash
mkdir -p /root/Storage/Downloads/incomplete
mkdir -p /root/Storage/Downloads/torrents
mkdir -p /root/Storage/TV\ Shows
mkdir -p /root/Storage/Movies
mkdir -p mkdir -p /var/lib/transmission-daemon/info /var/lib/transmission-daemon/downloads /var/lib/transmission-daemon/watchdir

service transmission-daemon start 
/root/hold_server.py
