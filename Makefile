all: build transmission

alldev: dev transmissiondev

build: tmp
	cat Dockerfile.rpi Dockerfile.base > Dockerfile
	sudo docker build -t tokko/flexget:latest .

transmission: tmp
	sudo docker build -t tokko/transmission:latest -f Dockerfile.transmission .

runtransmissiondevi: transmissiondev
	docker run -p -ti  9091:9091 -v $(PWD)/tmp/.transmissionetc:/root/.config/transmission-daemon -v $(PWD)/tmp/flexget:/root/Storage tokko/transmission:dev bash

runtransmissiondev: transmissiondev
	docker run --name transmission -p  9091:9091 -v $(PWD)/tmp/.transmissionetc:/root/.config/transmission-daemon -v $(PWD)/tmp/flexget:/root/Storage tokko/transmission:dev &

transmissiondev: tmp
	cp Dockerfile.dev Dockerfile.transmissiondev && tail -n +2 < Dockerfile.transmission >> Dockerfile.transmissiondev 
	sudo docker build -t tokko/transmission:dev -f Dockerfile.transmissiondev .

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

dev: tmp	
	cat Dockerfile.dev Dockerfile.base > Dockerfile
	sudo docker build -t tokko/flexget:dev .

push:
	sudo docker push tokko/flexget:latest .

installdev: install
	sudo apt-get install -y make npm nodejs
	sudo ln -s `which nodejs` /usr/bin/node


clean:
	rm -f docker-hypriot_1.9.1-1_armhf.deb
	rm -f Dockerfile
	rm -f Dockerfile.transmissiondev
	sudo rm -rf tmp
cleanall: clean
	rm -rf ../Flexget
