#rm -f/root/requirements.txt

/root/make_folders.sh
service transmission-daemon stop

cp /root/config.yml_template /root/.flexget/config.yml
perl -pi -e "s/TRAKT_USERNAME/$TRAKT_USERNAME/g" /root/.flexget/config.yml
perl -pi -e "s/TRAKT_ACCOUNT/$TRAKT_ACCOUNT/g" /root/.flexget/config.yml
#per -pi -e "s/STORAGE/$DISK_NAME/g" /root/.flexget/config.yml
#perl -pi -e "s/SUBFOLDER/$SUBFOLDER/g" /root/.flexget/config.yml

cp /root/xbmc-upd.sh /etc/transmission-daemon
cp /root/settings.json /etc/transmission-daemon
#perl -pi -e "s/STORAGE/$DISK_NAME/g" /etc/transmission-daemon/settings.json
#perl -pi -e "s/SUBFOLDER/$SUBFOLDER/g" /etc/transmission-daemon/settings.json

service transmission-daemon start
