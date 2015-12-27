~/make_folders.sh
flexget daemon stop
service transmission-daemon stop

cp ./config.yml ~/.flexget
perl -pi -e "s/TRAKT_USERNAME/$TRAKT_USERNAME/g" ~/.flexget/config.yml
perl -pi -e "s/TRAKT_ACCOUNT/$TRAKT_ACCOUNT/g" ~/.flexget/config.yml
perl -pi -e "s_STORAGE_$MEDIA_PATH_g" ~/.flexget/config.yml

cp xbmc-upd.sh /etc/transmission-daemon
cp settings.json /etc/transmission-daemon
perl -pi -e "s_STORAGE_$MEDIA_PATH_g" /etc/transmission-daemon/settings.json

service transmission-daemon start
flexget daemon start -d
