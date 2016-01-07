#!/bin/bash
source /root/.flexget/export.sh
docker start fileserver
docker daemon
curl $UPDATE_IP:$UPDATE_PORT/update.sh | sh
source ~/.flexget/export.sh
docker start transmission
