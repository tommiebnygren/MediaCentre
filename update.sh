#!/bin/bash

#echo "TRAKT_USER: $2"
echo "MEDIA_PATH: $1"
function data {
	RES= sudo docker ps -a | grep Exit | grep $1_data
	if [ "$RES" == "" ] ; then
		sudo docker run --name $1_data tokko/$1:latest echo "$1 data container"
	fi

}

data transmission
RES=sudo docker pull tokko/transmission:latest | grep "newer image"
RES1=sudo docker ps | grep "transmission"
if [ "$RES" != "" ] || [ "$RES1" == "" ] ; then
	(sudo docker ps | grep "transmission") && sudo docker rm -f transmission 1>&2>/dev/null ;
	sudo docker run --restart=always -p 9091:9091 --privileged=true --volumes-from transmission_data --name transmission -d -v $1:/root/Storage tokko/transmission:latest
fi

data sickrage
RES=sudo docker pull tokko/sickrage:latest | grep "newer image"
RES1=sudo docker ps  | grep "sickrage"
if [ "$RES" != "" ] || [ "$RES1" == "" ] ; then
	echo "Starting sickrage"
	(sudo docker ps | grep "sickrage") && sudo docker rm -f sickrage;
	sudo docker run --privileged --link transmission -d --restart=always -p 8081:8081 --name sickrage --volumes-from sickrage_data -v $1:/root/Storage tokko/sickrage:latest
fi	

