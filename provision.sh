#!/usr/bin/bash
apt-get update
apt-get -y dist-upgrade
apt-get update
apt-get -y upgrade
apt-get install -y python transmission-daemon vim
easy_install pip
pip install flexget transmissionrpc
pip install flexget transmissionrpc --upgrade
