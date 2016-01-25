FROM resin/rpi-raspbian:jessie
RUN apt-get update && apt-get install -y wget && rm -rf /etc/apt/sources.list/*
COPY install_kodi.sh /root
RUN bash /root/install_kodi.sh
