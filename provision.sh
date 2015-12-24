#!/usr/bin/bash
sudo apt-get update
sudo apt-get -y dist-upgrade
sudo apt-get install -y python transmission-daemon vim
sudo easy_install pip
sudo pip install flexget transmissionrpc
sudo pip install flexget transmissionrpc --upgrade
