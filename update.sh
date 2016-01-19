#!/bin/bash
source ~/.bashrc

RES=sudo docker pull tokko/transmission:latest | grep "newer image"
RES1=sudo docker ps --all | grep "transmission"
if [ "$RES" != "" ] || [ "$RES1" == "" ] ; then
	(sudo docker ps --all | grep "transmission") && sudo docker rm -f transmission 1>&2>/dev/null ;
	sudo docker run --restart=always -p 9091:9091 --name transmission -v $MEDIA_PATH:/media/Storage -v $HOME/.transmission:/var/lib/transmission-daemon tokko/transmission:latest &
else
	sudo docker start transmission
fi

RES=sudo docker pull tokko/flexget:latest | grep "newer image" 
RES1=sudo docker ps --all | grep "flexget"
if [ "$RES" != "" ] || [ "$RES1" == "" ] ; then
	(sudo docker ps --all | grep "flexget") && sudo docker rm -f flexget;
	sudo docker run --restart=always --name flexget --link transmission -e TRAKT_USERNAME=$TRAKT_USERNAME -e TRAKT_ACCOUNT=$TRAKT_ACCOUNT -v $HOME/.flexget:/root/.flexget -v $MEDIA_PATH:/root/Storage tokko/flexget:latest "/root/flexget.sh" "$1" &
else
	sudo docker start flexget
fi

RES=sudo docker pull tokko/sonarr:latest | grep "newer image"
RES1=sudo docker ps --all | grep "sonarr"
if [ "$RES" != "" ] || [ "$RES1" == "" ] ; then
	sudo docker run --restart=always -p 8989:8989 --name sonar -v $MEDIA_PATH:/root/Storage -v $HOME/.sonarr:/root/.config/NzbDrone tokko/sonarr:latest &
else
	sudo docker start sonarr
fi	

