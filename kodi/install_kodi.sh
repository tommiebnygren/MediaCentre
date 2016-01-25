#!/bin/bash

wget http://steinerdatenbank.de/software/kodi-15-jessie-rpb.tar.gz
tar -xzf kodi-15-jessie-rpb.tar.gz
cd kodi-15-jessie
./install

addgroup --system input

echo "SUBSYSTEM==input, GROUP=input, MODE=0660" > /etc/udev/rules.d/99-input.rulessudo 
echo "KERNEL==tty[0-9]*, GROUP=tty, MODE=0660" > /etc/udev/rules.d/99-input.rules

# input
echo KERNEL=="mouse*|mice|event*",   MODE="0660", GROUP="input" > /etc/udev/rules.d/10-permissions.rules
echo KERNEL=="ts[0-9]*|uinput",     MODE="0660", GROUP="input" > /etc/udev/rules.d/10-permissions.rules
echo KERNEL==js[0-9]*,             MODE=0660, GROUP=input > /etc/udev/rules.d/10-permissions.rules
# tty
echo KERNEL==tty[0-9]*,            MODE=0666 > /etc/udev/rules.d/10-permissions.rules
# vchiq
echo SUBSYSTEM==vchiq,  GROUP=video, MODE=066 > /etc/udev/rules.d/10-permissions.rules
0

sudo usermod -a -G audio root
sudo usermod -a -G video root
sudo usermod -a -G input root
sudo usermod -a -G dialout root
sudo usermod -a -G plugdev root
sudo usermod -a -G tty root
