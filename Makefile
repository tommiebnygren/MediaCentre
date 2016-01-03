build: tmp
	cat Dockerfile.rpi Dockerfile.base > Dockerfile
	sudo docker build -t tokko/flexget:latest .
transmission: tmp
	sudo docker build -t tokko/transmission:latest -f Dockerfile.transmission .

runprod: build tmp
	sudo docker run -t -i -e TRAKT_USERNAME=tokko -e TRAKT_ACCOUNT=tokko -e DISK_NAME=Storage -e SUBFOLDER=flexget -v $(HOME)/Flexget/tmp:/media/Storage tokko/flexget:latest /bin/bash

rundev: dev tmp
	sudo docker run -t -i -e TRAKT_USERNAME=tokko -e TRAKT_ACCOUNT=tokko -e DISK_NAME=Storage -e SUBFOLDER=flexget -v $(HOME)/Flexget/tmp:/media/Storage -v $(HOME)/tmp/db-config.sqlite:/root/.flexget/db-config.sqlite tokko/flexget:latest /bin/bash

tmp:
	mkdir -p tmp/.flexget
	mkdir -p tmp/.transmissionetc
	mkdir -p tmp/flexget

dev:	config.yml_template install.sh make_folders.sh settings.json Dockerfile.dev xbmc-upd.sh Dockerfile.base
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
	sudo rm -rf tmp

cleanall: clean
	rm -rf ../Flexget
