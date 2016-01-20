FROM resin/rpi-raspbian:jessie

RUN apt-get update && apt-get install -y python transmission-daemon cron vim
RUN service transmission-daemon stop
#RUN echo "*/5 * * * * transmission-remote -t all --start" | crontab -

EXPOSE 9091

#RUN mkdir -p /root/.config/transmission-daemon
RUN mkdir -p /var/lib/transmission-daemon/downloads /var/lib/transmission-daemon/info
VOLUME /etc/var/lib/transmission-daemon/info
RUN chown -R debian-transmission /var/lib/transmission-daemon
RUN chgrp -R debian-transmission /var/lib/transmission-daemon

WORKDIR /root

COPY transmission/hold_server.py transmission/xbmc-upd.sh transmission/settings.json transmission/transmission.sh /root/

CMD /root/transmission.sh
