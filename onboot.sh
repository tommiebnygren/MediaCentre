#!/bin/bash
source /root/.flexget/export.sh
curl $UPDATE_IP:$UPDATE_PORT/update.sh | sh
