~/make_folders.sh
service transmission-daemon stop

cp ./config.yml_template ~/.flexget/config.yml
perl -pi -e "s/TRAKT_USERNAME/$TRAKT_USERNAME/g" ~/.flexget/config.yml
perl -pi -e "s/TRAKT_ACCOUNT/$TRAKT_ACCOUNT/g" ~/.flexget/config.yml
perl -pi -e "s/STORAGE/$DISK_NAME/g" ~/.flexget/config.yml
perl -pi -e "s/SUBFOLDER/$SUBFOLDER/g" ~/.flexget/config.yml

cp xbmc-upd.sh /etc/transmission-daemon
cp settings.json /etc/transmission-daemon
perl -pi -e "s/STORAGE/$DISK_NAME/g" /etc/transmission-daemon/settings.json
perl -pi -e "s/SUBFOLDER/$SUBFOLDER/g" /etc/transmission-daemon/settings.json

service transmission-daemon start
flexget daemon start -d
