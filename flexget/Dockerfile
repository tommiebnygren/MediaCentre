FROM alpine
#FROM resin/raspberrypi2-buildpack-deps:jessie

#VOLUME /root/Storage

WORKDIR /root

CMD /root/flexget.sh

RUN 		apk update && \
		apk add curl && \
		curl http://dl-4.alpinelinux.org/alpine/v3.2/main >> /etc/apk/repositories && \
		apk update && \
		apk add --update python \
		#python-dev \
		#python-dbus \
		py-pip && \
		#python-virtualenv \
		#python-setuptools  && \
		pip install -U pip && \
		pip install transmissionrpc flexget && \
		apk del curl && \
		rm -rf /var/cache/apk/*
		#rm -rf /var/cache/apk/*
		
COPY flexget/config.yml_template flexget/flexget.sh /root/

