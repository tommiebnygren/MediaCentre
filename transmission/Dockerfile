FROM resin/raspberrypi2-buildpack-deps

EXPOSE 9091

WORKDIR /root

RUN 	apt-get update && apt-get install -y python transmission-daemon && \
	service transmission-daemon stop

COPY transmission/hold_server.py make_folders.sh transmission/xbmc-upd.sh transmission/transmission.sh /root/
COPY transmission/settings.json /etc/transmission-daemon

RUN 	chown -R debian-transmission:debian-transmission /var/lib/transmission-daemon && \
	chown -R debian-transmission:debian-transmission /etc/transmission-daemon && \
	chown -R debian-transmission:debian-transmission /root

VOLUME /var/lib/transmission-daemon /etc/transmission-daemon

CMD /root/transmission.sh

