#FROM resin/rpi-raspbian:jessie
FROM alpine

EXPOSE 9091

VOLUME /etc/var/lib/transmission-daemon/info

WORKDIR /root

RUN 	apk update && \
	apk add --update \
	bash \
	python \ 
	transmission-daemon && \
	rm -rf /var/cache/apk/* && \
	service transmission-daemon stop && \
	mkdir -p /var/lib/transmission-daemon/downloads /var/lib/transmission-daemon/info && \
	chown -R debian-transmission /var/lib/transmission-daemon && \
	chgrp -R debian-transmission /var/lib/transmission-daemon

CMD /root/transmission.sh

COPY transmission/hold_server.py transmission/xbmc-upd.sh transmission/settings.json transmission/transmission.sh /root/
