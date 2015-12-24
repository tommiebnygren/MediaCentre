#!/usr/bin/bash
sudo apt-get update
sudo apt-get -y dist-upgrade
sudo apt-get install -y git python transmission-daemon
sudo easy_install pip
sudo pip install flexget transmissionrpc
sudo pip install flexget transmissionrpc --upgrade
