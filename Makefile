all: flexgetimage transmissionimage fileserverimage

flexgetimage: flexget/Dockerfile.base Dockerfile.rpi flexget/config.yml_template flexget/flexget.sh make_folders.sh flexget/requirements.txt
	cat Dockerfile.rpi flexget/Dockerfile.base > Dockerfile
	sudo docker build --rm=true -t tokko/flexget:latest .

pushflexget: flexgetimage
	sudo docker push tokko/flexget:latest

transmissionimage: 
	sudo docker build --rm=true -t tokko/transmission:latest -f transmission/Dockerfile.transmission .

runtransmission: transmissionimage
	(sudo docker ps --all | grep "transmission") && sudo docker rm -f transmission || echo "no need to remove"
	sudo docker run --restart=always -p 9091:9091 --name transmission -v $MEDIA_PATH:/root/Storage -v $(HOME)/.transmission:/root/.config/transmission-daemon tokko/transmission:latest &

runflexget: flexgetimage
	sudo docker rm -f flexget ; ./start_flexget.sh

runflexgetauth:
	sudo docker pull tokko/flexget:latest
	sudo docker run -ti --rm=true -e TRAKT_USERNAME=$(TRAKT_USERNAME) -e TRAKT_ACCOUNT=$(TRAKT_ACCOUNT) -v $(HOME)/.flexget:/root/.flexget -v $(MEDIA_PATH):/root/Storage tokko/flexget:latest bash

runtransmissioni: transmissionimage
	docker run -ti --rm=true -p 9092:9091 -v $(HOME)/.transmission:/root/.config/transmission-daemon -v $(MEDIA_PATH):/root/Storage tokko/transmission:latest bash

runprodi: flexgetimage
	sudo docker run -ti -rm=true -e TRAKT_USERNAME=$(TRAKT_USERNAME) -e TRAKT_ACCOUNT=$(TRAKT_ACCOUNT) -v $(MEDIA_PATH):/root/Storage -v $(HOME)/.flexget:/root/.flexget tokko/flexget:latest /bin/bash

pushall: all
	sudo docker push tokko/flexget:latest
	sudo docker push tokko/transmission:latest
	sudo docker push tokko/fileserver:latest

runpushfileserver: fileserverimage runfileserver pushfileserver

fileserverimage:
	sudo docker build --rm=true -t tokko/fileserver:latest -f fileserver/Dockerfile .

runfileserver: fileserverimage
	(sudo docker ps | grep fileserver && sudo docker start fileserver) || ./start_fileserver.sh 


pushfileserver: fileserverimage
	sudo docker push tokko/fileserver:latest

install:
	sh install_host.sh

clean:
	rm -f docker-hypriot_1.9.1-1_armhf.deb
	rm -f Dockerfile
	rm -f Dockerfile.transmissiondev
	sudo rm -rf tmp

cleanall: clean
	rm -rf ../Flexget
