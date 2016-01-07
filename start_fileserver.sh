#!/bin/bash
(sudo docker ps | grep fileserver && sudo docker start fileserver) || sudo docker run --restart=always --name fileserver -p $(UPDATE_PORT):7070 tokko/fileserver:latest &
