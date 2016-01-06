#!/bin/bash
source ~/.flexget/export.sh

RES=sudo docker pull tokko/transmission:latest | grep "newer image" 
if [ $RES -ne 0 ]; then
	sudo docker rm -f transmission
	sudo docker run -p 9091:9091 --name transmission -v $MEDIA_PATH:/root/Storage -v $HOME/.transmission:/root/.config/transmission-daemon tokko/transmission:latest &
fi
RES=sudo docker pull tokko/flexget:latest | grep "newer image" 
if [ $RES -ne 0 ]; then
	sudo docker rm -f flexget
	sudo docker run --name flexget --link transmission:transmission -e TRAKT_USERNAME=$TRAKT_USERNAME -e TRAKT_ACCOUNT=$TRAKT_ACCOUNT -v $MEDIA_PATH:/root/Storage tokko/flexget:latest &
fi
