#/bin/bash
git pull
./make_folders.sh
flexget daemon stop
sudo service transmission-daemon stop

cp config.yml ~/.flexget
perl -pi -e "s/TRAKT_USERNAME/$1/g" ~/.flexget/config.yml
perl -pi -e "s/TRAKT_ACCOUNT/$2/g" ~/.flexget/config.yml
perl -pi -e "s/TRANSMISSION_USERNAME/$3/g" ~/.flexget/config.yml
perl -pi -e "s/TRANSMISSION_PASSWORD/$4/g" ~/.flexget/config.yml

sudo cp settings.json /etc/transmission-daemon
sudo perl -pi -e "s/TRANSMISSION_USERNAME/$3/g" /etc/transmission-daemon/settings.json
sudo perl -pi -e "s/TRANSMISSION_PASSWORD/$4/g" /etc/transmission-daemon/settings.json

sudo service transmission-daemon start
flexget daemon start -d
