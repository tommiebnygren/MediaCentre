FROM resin/rpi-raspbian:jessie

EXPOSE 32400

CMD bash /usr/lib/plexmediaserver/start.sh &

#install curl
RUN apt-get update && apt-get install -y curl apt-transport-https 

#fix locales
RUN 	apt-get update && \
	apt-get install -y locales && \
	echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen && \
	locale-gen && \
	dpkg-reconfigure locales 

#update libc
RUN 	echo "deb http://mirrordirector.raspbian.org/raspbian/ jessie main contrib non-free" | sudo tee -a /etc/apt/sources.list && \
	echo "deb http://archive.raspbian.org/raspbian jessie main contrib non-free" | sudo tee -a /etc/apt/sources.list && \
	echo "Package: *" >> /etc/apt/preferences.d/jessie.pref && \
	echo "Pin: release n=jessie" >> /etc/apt/preferences.d/jessie.pref && \
	echo "Pin-Priority: -1" >> /etc/apt/preferences.d/jessie.pref && \
	apt-get update && \
	apt-get install -t jessie libc6 -y

#install plex
RUN	curl https://dev2day.de/pms/dev2day-pms.gpg.key | sudo apt-key add - && \
	echo "deb https://dev2day.de/pms/ jessie main" | sudo tee /etc/apt/sources.list.d/pms.list && \
	apt-get update && \
	apt-get install -t jessie plexmediaserver -y
