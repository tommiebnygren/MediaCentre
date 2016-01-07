#!/bin/bash
#sudo apt-get update
#sudo apt-get install -y cron curl

#wget http://downloads.hypriot.com/docker-hypriot_1.9.1-1_armhf.deb
#sudo dpkg -i docker-hypriot_1.9.1-1_armhf.deb
#rm -f docker-hypriot_1.9.1-1_armhf.deb*
#sudo systemctl enable docker

cp export.sh ~/.flexget
source ~/.flexget/export.sh

sudo cp onboot.sh /etc/cron.daily
sudo cp onboot.sh /etc/init.d
sudo ln -s /etc/init.d/onboot.sh /etc/rc2.d/Sonboot.sh

mkdir -p ~/.flexget	
mkdir -p ~/.transmission


#UPDATE_COMMAND="curl $UPDATE_IP:$UPDATE_PORT/update.sh | sh"

crontab -l >> mycron

cat mycron | grep "update.sh" && echo "update already setup" || echo "45 23 * * * $UPDATE_COMMAND" >> mycron

#cat mycron | grep "export.sh" && echo "exports already setup" || echo "@reboot source ~/.flexget/export.sh" >> mycron

crontab mycron
rm mycron

eval $UPDATE_COMMAND
