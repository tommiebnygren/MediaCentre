perl -pi -e "s/STORAGE/$DISK_NAME/g" ./make_folders.sh
/data/make_folders.sh
flexget daemon stop
sudo service transmission-daemon stop

cp ./config.yml ~/.flexget
perl -pi -e "s/TRAKT_USERNAME/$TRAKT_USERNAME/g" ~/.flexget/config.yml
perl -pi -e "s/TRAKT_ACCOUNT/$TRAKT_ACCOUNT/g" ~/.flexget/config.yml
perl -pi -e "s/STORAGE/$DISK_NAME/g" ~/.flexget/config.yml
#perl -pi -e "s/TRANSMISSION_USERNAME/$TRANSMISSION_USERNAME/g" ~/.flexget/config.yml
#perl -pi -e "s/TRANSMISSION_PASSWORD/$TRANSMISSION_PASSWORD/g" ~/.flexget/config.yml

sudo cp xbmc-upd.sh /etc/transmission-daemon
sudo cp settings.json /etc/transmission-daemon
#sudo perl -pi -e "s/TRANSMISSION_USERNAME/$TRANSMISSION_USERNAME/g" /etc/transmission-daemon/settings.json
#sudo perl -pi -e "s/TRANSMISSION_PASSWORD/$TRANSMISSION_PASSWORD/g" /etc/transmission-daemon/settings.json

sudo service transmission-daemon start
flexget daemon start -d
