#!/bin/bash
source ~/.flexget/export.sh
sudo docker create --restart=always --name flexget --link transmission:transmission -e TRAKT_USERNAME=$TRAKT_USERNAME -e TRAKT_ACCOUNT=$TRAKT_ACCOUNT -v $HOME/.flexget:/root/.flexget -v $MEDIA_PATH:/root/Storage tokko/flexget:latest
if [ $1 == "" }; then
	sudo docker start flexget &
fi

