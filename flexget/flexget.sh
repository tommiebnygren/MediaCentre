#!/bin/bash
#rm -f/root/requirements.txt

/root/make_folders.sh

cp /root/config.yml_template /root/.flexget/config.yml
perl -pi -e "s/TRAKT_USERNAME/$TRAKT_USERNAME/g" /root/.flexget/config.yml
perl -pi -e "s/TRAKT_ACCOUNT/$TRAKT_ACCOUNT/g" /root/.flexget/config.yml

flexget daemon start $1
