#!/bin/bash
source ~/.bashrc

echo "Pulling transmission"
RES=sudo docker pull tokko/transmission:latest | grep "newer image"
RES1=sudo docker ps --all | grep "transmission"
if [ "$RES" != "" ] || [ "$RES1" == "" ] ; then
	echo "starting transmission"
	(sudo docker ps --all | grep "transmission") && sudo docker rm -f transmission 1>&2>/dev/null ;
	sudo docker run --restart=always -p 9091:9091 --privileged=true --volumes-from transmission_data --name transmission -v $MEDIA_PATH:/root/Storage tokko/transmission:latest &
else
	sudo docker start transmission
fi

echo "Pulling flexget"
RES=sudo docker pull tokko/flexget:latest | grep "newer image" 
RES1=sudo docker ps --all | grep "flexget"
if [ "$RES" != "" ] || [ "$RES1" == "" ] ; then
	echo "Starting flexget"
	(sudo docker ps --all | grep "flexget") && sudo docker rm -f flexget;
	sudo docker run --restart=always --privileged=true --name flexget --volumes-from flexget_data --link transmission -p 5050:5050 -e TRAKT_USERNAME=$TRAKT_USERNAME -v $MEDIA_PATH:/root/Storage tokko/flexget:latest "/root/flexget.sh" "$1" &
else
	sudo docker start flexget
fi

echo "Pulling sonarr"
RES=sudo docker pull tokko/sonarr:latest | grep "newer image"
RES1=sudo docker ps --all | grep "sonarr"
if [ "$RES" != "" ] || [ "$RES1" == "" ] ; then
	echo "Starting sonarr"
	sudo docker run --privileged --link transmission -d --restart=always -p 8989:8989 --name sonar --volumes-from sonarr_data -v $MEDIA_PATH:/root/Storage tokko/sonarr:latest
else
	sudo docker start sonarr
fi	

