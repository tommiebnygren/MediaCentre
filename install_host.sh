#!/bin/bash
sudo apt-get update
sudo apt-get -y dist-upgrade
sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get install -y cron curl make kodi
sudo perl -pi -e "s/ENABLED=0/ENABLED=1/g" /etc/default/kodi
wget http://downloads.hypriot.com/docker-hypriot_1.9.1-1_armhf.deb
sudo dpkg -i docker-hypriot_1.9.1-1_armhf.deb
sudo docker daemon 1>/dev/null &
rm -f docker-hypriot_1.9.1-1_armhf.deb*
sudo systemctl enable docker
sudo gpasswd -a $USER docker
sudo chown -R 777 $MEDIA_PATH
sudo usermod -a -G audio kodi
sudo usermod -a -G video kodi
sudo usermod -a -G input kodi
sudo usermod -a -G dialout kodi
sudo usermod -a -G plugdev kodi
sudo usermod -a -G tty kodi
./export.sh
source ~/.bashrc

UPDATE_COMMAND="curl $UPDATE_IP:$UPDATE_PORT/update.sh | sh"

crontab -l >> mycron

cat mycron | grep "update.sh" && echo "update already setup" || echo "45 23 * * * $UPDATE_COMMAND" >> mycron && echo "@reboot $UPDATE_COMMAND" >> mycron
cat mycron | grep "export" && echo "export already setup" || echo "@reboot source $HOME/.flexget/export.sh" >> mycron

crontab mycron
rm mycron

sudo reboot
