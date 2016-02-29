#!/bin/bash
source ~/.bashrc

sudo docker create --name transmission_data tokko/transmission:latest
sudo docker run --restart=always -p 9091:9091 --privileged=true --volumes-from transmission_data --name transmission -d -v $MEDIA_PATH:/root/Storage tokko/transmission:latest 

sudo docker create --name flexget_data tokko/flexget:latest
sudo docker run -d --restart=always --privileged=true --name flexget --volumes-from flexget_data --link transmission -p 5050:5050 -e TRAKT_USERNAME=$TRAKT_USERNAME -v $MEDIA_PATH:/root/Storage tokko/flexget:latest "/root/flexget.sh" "$1" 

sudo docker create --name sickrage_data tokko/sickrage:latest
sudo docker run --privileged --link transmission -d --restart=always -p 8081:8081 --name sickrage --volumes-from sickrage_data -v $MEDIA_PATH:/root/Storage tokko/sickrage:latest
