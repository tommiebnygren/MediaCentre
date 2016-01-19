#!/bin/bash
O=$(dpkg -l | grep docker-hypriot)
if [ "$O" == "" ] ; then
	sudo apt-get update
	sudo apt-get install -y cron curl make
	wget http://downloads.hypriot.com/docker-hypriot_1.9.1-1_armhf.deb
	sudo dpkg -i docker-hypriot_1.9.1-1_armhf.deb
	sudo docker daemon 1>/dev/null &
	rm -f docker-hypriot_1.9.1-1_armhf.deb*
	sudo systemctl enable docker
	sudo newgrp docker ;
	sudo gpasswd -a $USER docker
fi

mkdir -p ~/.flexget	
mkdir -p ~/.transmission

./export.sh
source ~/.bashrc

UPDATE_COMMAND="curl $UPDATE_IP:$UPDATE_PORT/update.sh | sh"

crontab -l >> mycron

cat mycron | grep "update.sh" && echo "update already setup" || echo "45 23 * * * $UPDATE_COMMAND" >> mycron && echo "@reboot $UPDATE_COMMAND" >> mycron
cat mycron | grep "export" && echo "export already setup" || echo "@reboot source $HOME/.flexget/export.sh" >> mycron

crontab mycron
rm mycron

#sleep 15 && make runflexgetauth TRAKT_PIN=$1

./update.sh $1
#sudo docker exec flexget "flexget trakt auth" "$TRAKT_ACCOUNT $1"
