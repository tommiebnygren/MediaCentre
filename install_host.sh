#!/bin/bash
#sudo apt-get update
#sudo apt-get install -y cron curl

#wget http://downloads.hypriot.com/docker-hypriot_1.9.1-1_armhf.deb
#sudo dpkg -i docker-hypriot_1.9.1-1_armhf.deb
#rm -f docker-hypriot_1.9.1-1_armhf.deb*


mkdir -p ~/.flexget	
mkdir -p ~/.transmission

cp export.sh ~/.flexget
source ~/.flexget/export.sh

UPDATE_COMMAND="curl $UPDATE_IP:$UPDATE_PORT/update.sh | sh"

sudo crontab -l >> mycron
cat mycron| grep "docker daemon" && echo "docker daemon crontab already setup" || echo "@reboot docker daemon" >> mycron

cat mycron | grep "update.sh" && echo "update already setup" || echo "45 23 * * * $UPDATE_COMMAND" >> mycron

cat mycron | grep "export.sh" && echo "exports already setup" || echo "@reboot source ~/.flexget/export.sh" >> mycron

cat mycron | grep "transmission" && echo "transmission autostart already setup" || echo "@reboot docker start transmission" >> mycron

cat mycron | grep "flexget" && echo "flexget autostart already setup" || echo "@reboot docker start flexget" >> mycron

sudo crontab mycron
crontab mycron
rm mycron

eval $UPDATE_COMMAND
