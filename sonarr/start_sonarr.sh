#!/bin/bash
source ~/.flexget/export.sh
if [ "$1" == "-rm" ] ; then
	sudo docker rm -f sonarr
fi
RES=sudo docker ps --all | grep "sonarr"
if [ "$RES" == "" ] ; then
	sudo docker run --restart=always -p 8989:8989 --name sonarr -v $MEDIA_PATH:/root/Storage -v $HOME/.sonarr:/root/.config/NzbDrone tokko/sonarr:latest &
else
	sudo docker start sonarr
fi	

