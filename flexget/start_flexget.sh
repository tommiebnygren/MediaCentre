#!/bin/bash
source ~/.bashrc
mkdir -p $HOME/.flexget
OP=$(sudo docker ps --all | grep "flexget")
if [ "$OP" == "" ] ; then
	echo "starting"
	sudo docker run --restart=always --privileged=true -p 5050:5050 --name flexget --link transmission -e TRAKT_USERNAME=$TRAKT_USERNAME -e TRAKT_ACCOUNT=$TRAKT_ACCOUNT -v $HOME/.flexget:/root/.flexget -v $MEDIA_PATH:/root/Storage tokko/flexget:latest /root/flexget.sh $1 &
fi

