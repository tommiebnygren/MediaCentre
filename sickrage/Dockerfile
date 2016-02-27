FROM resin/raspberrypi2-buildpack-deps:jessie

WORKDIR /root

EXPOSE 8081

RUN 	apt-get update && \
	apt-get install -y python-pip python-dev git-core libssl-dev libxslt1-dev libxslt1.1 libxml2-dev libxml2 libssl-dev libffi-dev && \
	pip install -U pip && \
	pip install pyopenssl && \
	apt-get install build-essential -y && \
	wget http://rarlab.com/rar/unrarsrc-5.2.7.tar.gz && \
	tar -xvf unrarsrc-5.2.7.tar.gz && \
	cd unrar && \
	make -f makefile && \
	install -v -m755 unrar /usr/bin && \
	git clone https://github.com/SickRage/SickRage.git /opt/sickrage 
	#chown -R pi:pi /opt/sickrage

VOLUME /opt/sickrage

CMD python /opt/sickrage/SickBeard.py
