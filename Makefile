all: build transmissionimage fileserverimage

alldev: dev transmissiondev

build: flexget/Dockerfile.base Dockerfile.rpi flexget/config.yml_template flexget/install.sh make_folders.sh flexget/requirements.txt
	cat Dockerfile.rpi flexget/Dockerfile.base > Dockerfile
	sudo docker build --rm -t tokko/flexget:latest .

transmissionimage: 
	sudo docker build --rm -t tokko/transmission:latest -f transmission/Dockerfile.transmission .

runtransmissiondevi: transmissiondev tmp
	docker run -ti -p  9091:9091 -v $(PWD)/tmp/.transmissionetc:/root/.config/transmission-daemon -v $(PWD)/tmp/flexget:/root/Storage tokko/transmission:dev bash

runtransmissiondev: transmissiondev tmp
	docker run --name transmission -p  9091:9091 -v $(PWD)/tmp/.transmissionetc:/root/.config/transmission-daemon -v $(PWD)/tmp/flexget:/root/Storage tokko/transmission:dev &

transmissiondev: tmp transmission/Dockerfile.transmission make_folders.sh transmission/settings.json transmission/xbmc-upd.sh
	cp Dockerfile.dev Dockerfile.transmissiondev && tail -n +2 < transmission/Dockerfile.transmission >> Dockerfile.transmissiondev 
	sudo docker build --rm -t tokko/transmission:dev -f Dockerfile.transmissiondev .

runprod: build tmp
	sudoudocker run -ti -e TRAKT_USERNAME=tokko -e TRAKT_ACCOUNT=tokko -v $(HOME)/Flexget/tmp:/root/Storage tokko/flexget:latest /bin/bash

rundevi: dev tmp runtransmissiondev
	sudo docker run -ti --link transmission:transmission -e TRAKT_USERNAME=grishnuk -e TRAKT_ACCOUNT=grishnuk -v $(HOME)/Flexget/tmp:/root/Storage -v $(HOME)/tmp/.flexget:/root/.flexget/ tokko/flexget:dev /bin/bash

rundev: dev tmp runtransmissiondev
	sudo docker run --name flexget --link transmission:transmission -e TRAKT_USERNAME=grishnuk -e TRAKT_ACCOUNT=grishnuk -v $(HOME)/Flexget/tmp:/root/Storage -v $(HOME)/tmp/.flexget:/root/.flexget/ tokko/flexget:dev


tmp:
	mkdir -p tmp/.flexget
	mkdir -p tmp/.transmissionetc
	mkdir -p tmp/flexget/Downloads/incomplete
	mkdir -p tmp/flexget/Downloads/torrents
	mkdir -p tmp/flexget/Movies
	mkdir -p tmp/flexget/TV\ Shows

dev: tmp flexget/Dockerfile.base Dockerfile.dev flexget/config.yml_template flexget/install.sh make_folders.sh flexget/requirements.txt
	cat Dockerfile.dev flexget/Dockerfile.base > Dockerfile
	sudo docker build -rm -t tokko/flexget:dev .

pushall: all
	sudo docker push tokko/flexget:latest
	sudo docker push tokko/transmission:latest
	sudo docker push tokko/fileserver:latest

runpushfileserver: fileserverimage runfileserver pushfileserver

fileserverimage:
	sudo docker build -t tokko/fileserver:latest -f fileserver/Dockerfile .

runfileserver: fileserverimage
	(sudo docker ps | grep fileserver && sudo docker start fileserver) || sudo docker run --restart=always --name fileserver -p $(UPDATE_PORT):7070 tokko/fileserver:latest &


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
