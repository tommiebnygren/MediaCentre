#!/bin/bash

mkdir -p /root/Storage/Downloads/incomplete
mkdir -p /root/Storage/Downloads/torrents
mkdir -p /root/Storage/TV\ Shows
mkdir -p /root/Storage/Movies

cp /root/config.yml_template /root/.flexget/config.yml
perl -pi -e "s/TRAKT_USERNAME/$TRAKT_USERNAME/g" /root/.flexget/config.yml
perl -pi -e "s/TRAKT_ACCOUNT/$TRAKT_ACCOUNT/g" /root/.flexget/config.yml


if [ "$1" != "" ] ; then
	flexget trakt auth $TRAKT_ACCOUNT $1
fi

flexget daemon start
