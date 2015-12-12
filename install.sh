#/bin/bash
flexget daemon stop
service transmission stop
git pull

cp config.yml ~/.flexget
perl -pi -e "s/TRAKT_USERNAME/$1/g ~/.flexget/config.yml
perl -pi -e "s/TRAKT_ACCOUNT/$2/g ~/.flexget/config.yml
perl -pi -e "s/TRANSMISSION_USERNAME/$3/g ~/.flexget/config.yml
perl -pi -e "s/TRANSMISSION_PASSWORD/$4/g ~/.flexget/config.yml

cp settings.json /etc/transmission
perl -pi -e "s/TRANSMISSION_USERNAME/$3/g ~/etc/transmission/settings.json
perl -pi -e "s/TRANSMISSION_PASSWORD/$4/g ~/etc/transmission/settings.json

service transmission start
flexget daemon start -d
