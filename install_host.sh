#!/bin/bash
sudo apt-get install -y cron

wget http://downloads.hypriot.com/docker-hypriot_1.9.1-1_armhf.deb

sudo dpkg -i docker-hypriot_1.9.1-1_armhf.deb

mkdir -p ~/.flexget	
cp update_flexget.sh ~/.flexget
#cp export.sh ~/.flexget

sudo crontab -l 2>/dev/null | grep "docker daemon" && echo "docker daemon crontab already setup" || echo "@reboot docker daemon &" | sudo crontab -

sudo crontab -l 2>/dev/null | grep "update_flexget.sh" && echo "Flexget crontab already present" || echo "45 23 * * * ~/.flexget/update_flexget.sh" | sudo crontab -

sudo crontab -l 2>/dev/null | grep "export.sh" && echo "exports already setup" || echo "@reboot source ~/.flexget/export.sh" | sudo crontab -

sudo ~/.flexget/update_flexget.sh
rm docker-hypriot_1.9.1-1_armhf.deb*
