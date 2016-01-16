#!/bin/bash
source ~/.flexget/export.sh

echo "pulling transmission image"
RES=sudo docker pull tokko/transmission:latest | grep "newer image"
echo "pull complete"
RES1=sudo docker ps --all | grep "transmission"
if [ "$RES" != "" ] || [ "$RES1" == "" ] ; then
	(sudo docker ps --all | grep "transmission") && sudo docker rm -f transmission 1>&2>/dev/null ;
	echo "running transmission"
	sudo docker run --restart=always -p 9091:9091 --name transmission -v $MEDIA_PATH:/media/Storage -v $HOME/.transmission:/var/lib/transmission-daemon tokko/transmission:latest &
else
	echo "just starting transmission"
	sudo docker start transmission
fi

echo "pulling flexget"
RES=sudo docker pull tokko/flexget:latest | grep "newer image" 
echo "pull complete"
RES1=sudo docker ps --all | grep "flexget"
if [ "$RES" != "" ] || [ "$RES1" == "" ] ; then
	echo "running flexget"
	(sudo docker ps --all | grep "flexget") && sudo docker rm -f flexget;
	echo "arg: $1"
	sudo docker run --restart=always --name flexget --link transmission -e TRAKT_USERNAME=$TRAKT_USERNAME -e TRAKT_ACCOUNT=$TRAKT_ACCOUNT -v $HOME/.flexget:/root/.flexget -v $MEDIA_PATH:/root/Storage tokko/flexget:latest "/root/flexget.sh" "$1" &
else
	echo "just starting flexget"
	sudo docker start flexget
fi
