#!/bin/bash
MEDIA_PATH="/media/$DISK_NAME/$SUBFOLDER"
echo $MEDIA_PATH
mkdir -p ~/.flexget
mkdir -p $MEDIA_PATH/Downloads/incomplete
mkdir -p $MEDIA_PATH/TV\ Shows
mkdir -p $MEDIA_PATH/Movies
