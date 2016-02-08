#FROM hypriot/rpi-python:latest
FROM resin/raspberrypi2-buildpack-deps:jessie

#VOLUME /root/Storage

WORKDIR /root

CMD /root/flexget.sh

RUN apt-get update && apt-get install -y \
		python \
		python-dev \
		python-dbus \
		python-pip \
		python-virtualenv \
		python-setuptools  && \
		rm -rf /var/lib/apt/lists/*

RUN pip install transmissionrpc 
RUN pip install flexget 

VOLUME /root/.flexget

COPY flexget/config.yml_template flexget/flexget.sh /root/

