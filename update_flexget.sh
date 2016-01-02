#!/bin/bash
sudo docker pull tokko/flexget_latest
sudo docker stop tokko/flexget_latest
sudo docker run -t -i -e TRAKT_USERNAME=$TRAK_USERNAME -e TRAKT_ACCOUNT=TRAKT_ACCOUNT -v $MEDIA_PATH:/root/Storage -v $(HOME)/.flexget:/root/.flexget tokko/flexget:latest
