#FROM hypriot/rpi-alpine-scratch
FROM dduportal/rpi-alpine

VOLUME /root/Storage

WORKDIR /root

CMD /root/flexget.sh

RUN 		apk update && \
		apk add --update bash \
		python \
		python-dev \
		py-dbus \
		py-virtualenv \
		py-setuptools \
		py-pip && \
		pip install -U pip && \
		pip install -U transmissionrpc flexget && \
		rm -rf /var/cache/apk/*
		
COPY flexget/config.yml_template flexget/flexget.sh /root/

