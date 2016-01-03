#!/bin/bash
source ~/.flexget/export.sh
#sudo docker pull tokko/flexget:latest
sudo docker stop tokko/flexget:latest 2>/dev/null
sudo docker run -e TRAKT_USERNAME=$TRAKT_USERNAME -e TRAKT_ACCOUNT=TRAKT_ACCOUNT -v $MEDIA_PATH:/root/Storage -v $HOME/.flexget:/root/.flexget -p 9091:9091 tokko/flexget:latest
