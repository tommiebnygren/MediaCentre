all: env flexgetimage transmissionimage fileserverimage sonarrimage

env: export.sh
	./export.sh

flexgetimage: flexget/Dockerfile flexget/config.yml_template flexget/flexget.sh flexget/make_folders.sh flexget/requirements.txt
	sudo docker build --rm=true -t tokko/flexget:latest -f flexget/Dockerfile .

pushflexget: flexgetimage
	sudo docker push tokko/flexget:latest

pushtransmission: transmissionimage
	sudo docker push tokko/transmission:latest

transmissionimage: 
	sudo docker build --rm=true -t tokko/transmission:latest -f transmission/Dockerfile .

runtransmission: transmissionimage
	(sudo docker ps --all | grep "transmission") && sudo docker rm -f transmission || echo "no need to remove"
	transmission/start_transmission.sh

runtransmissioni: transmissionimage
	sudo docker run -ti --rm=true -p 9092:9091 -v $(HOME)/.transmission:/var/lib/transmission-daemon -v $(HOME)/tmp:/media/Storage tokko/transmission:latest bash

runflexget: flexgetimage
	sudo docker rm -f flexget ; ./start_flexget.sh

runflexgetauth: 
	#sudo docker pull tokko/flexget:latest
	flexget/start_flexget.sh $(TRAKT_PIN)
	#sudo docker run --rm=true -ti -e TRAKT_USERNAME=$(TRAKT_USERNAME) -e TRAKT_ACCOUNT=$(TRAKT_ACCOUNT) -v $(HOME)/.flexget:/root/.flexget -v $(MEDIA_PATH):/root/Storage tokko/flexget:latest /root/auth.sh $(TRAKT_PIN)


runflexgeti: flexgetimage
	sudo docker run -ti --rm=true -e TRAKT_USERNAME=$(TRAKT_USERNAME) -e TRAKT_ACCOUNT=$(TRAKT_ACCOUNT) -v $(MEDIA_PATH):/root/Storage -v $(HOME)/.flexget:/root/.flexget tokko/flexget:latest /bin/bash

pushall: all
	sudo docker push tokko/flexget:latest
	sudo docker push tokko/transmission:latest
	sudo docker push tokko/fileserver:latest
	sudo docker push tokko/sonarr:latest

runpushfileserver: fileserverimage runfileserver pushfileserver

fileserverimage:
	sudo docker build --rm=true -t tokko/fileserver:latest -f fileserver/Dockerfile .

runfileserver: fileserverimage
	(sudo docker ps | grep fileserver && sudo docker start fileserver) || fileserver/start_fileserver.sh 


pushfileserver: fileserverimage
	sudo docker push tokko/fileserver:latest

sonarrimage: sonarr/*
	sudo docker build -t tokko/sonarr:latest -f sonarr/Dockerfile sonarr

pushsonarr: sonarrimage
	sudo docker push tokko/sonarr:latest

runsonarr: sonarrimage
	sudo docker run -p 8989:8989 --name=sonarr tokko/sonarr:latest &

install:
	sh install_host.sh

clean:
	rm -f docker-hypriot_1.9.1-1_armhf.deb
	rm -f Dockerfile
	rm -f Dockerfile.transmissiondev
	sudo rm -rf tmp

cleanall: clean
	rm -rf ../Flexget
