#!/bin/bash
source ~/.flexget/export.sh
OP=$(sudo docker ps --all | grep "flexget")
if [ "$OP" != "" ] ; then
	sudo docker run --restart=always --name flexget --link transmission -e TRAKT_USERNAME=$TRAKT_USERNAME -e TRAKT_ACCOUNT=$TRAKT_ACCOUNT -v $HOME/.flexget:/root/.flexget -v $MEDIA_PATH:/root/Storage tokko/flexget:latest /root/flexget.sh $1 &
fi
