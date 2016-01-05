#!/bin/bash
sudo apt-get install -y cron curl

wget http://downloads.hypriot.com/docker-hypriot_1.9.1-1_armhf.deb
sudo dpkg -i docker-hypriot_1.9.1-1_armhf.deb
rm docker-hypriot_1.9.1-1_armhf.deb*


mkdir -p ~/.flexget	
mkdir -p ~/.transmission
UPDATE_COMMAND="curl $UPDATE_IP:$UPDATE_PORT/update.sh | sh"
cp export.sh ~/.flexget
sudo crontab -l 2>/dev/null | grep "docker daemon" && echo "docker daemon crontab already setup" || echo "@reboot docker daemon &" | sudo crontab -

sudo crontab -l 2>/dev/null | grep "update.sh" && echo "update already setup" || echo "45 23 * * * " | sudo crontab -

sudo crontab -l 2>/dev/null | grep "export.sh" && echo "exports already setup" || echo "@reboot source ~/.flexget/export.sh" | sudo crontab -

eval $UPDATE_COMMAND
