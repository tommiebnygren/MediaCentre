#/bin/bash
cd /home/xbian/Flexget
git submodule update --recursive
cd -
#/home/xbian/Flexget/provision.sh
perl -pi -e "s/STORAGE/$DISK_NAME/g" /home/xbian/Flexget/make_folders.sh
/home/xbian/Flexget/make_folders.sh
flexget daemon stop
sudo service transmission-daemon stop

cp /home/xbian/Flexget/config.yml /home/xbian/.flexget
perl -pi -e "s/TRAKT_USERNAME/$TRAKT_USERNAME/g" /home/xbian/.flexget/config.yml
perl -pi -e "s/TRAKT_ACCOUNT/$TRAKT_ACCOUNT/g" /home/xbian/.flexget/config.yml
perl -pi -e "s/TRANSMISSION_USERNAME/$TRANSMISSION_USERNAME/g" /home/xbian/.flexget/config.yml
perl -pi -e "s/TRANSMISSION_PASSWORD/$TRANSMISSION_PASSWORD/g" /home/xbian/.flexget/config.yml
perl -pi -e "s/STORAGE/$DISK_NAME/g" /home/xbian/.flexget/config.yml

sudo cp /hom/xbian/Flexget/xbmc-upd.sh /etc/transmission-daemon
sudo cp /home/xbian/Flexget/settings.json /etc/transmission-daemon
sudo perl -pi -e "s/TRANSMISSION_USERNAME/$TRANSMISSION_USERNAME/g" /etc/transmission-daemon/settings.json
sudo perl -pi -e "s/TRANSMISSION_PASSWORD/$TRANSMISSION_PASSWORD/g" /etc/transmission-daemon/settings.json

sudo service transmission-daemon start
flexget daemon start -d
