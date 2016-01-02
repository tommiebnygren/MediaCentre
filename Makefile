build:
	cat Dockerfile.rpi Dockerfile.base > Dockerfile
	sudo docker build -t tokko/flexget:latest .

runprod: build tmp
	sudo docker run -t -i -e TRAKT_USERNAME=tokko -e TRAKT_ACCOUNT=tokko -e DISK_NAME=Storage -e SUBFOLDER=flexget -v $(HOME)/Flexget/tmp:/media/Storage tokko/flexget:latest /bin/bash

rundev: dev tmp
	sudo docker run -t -i -e TRAKT_USERNAME=tokko -e TRAKT_ACCOUNT=tokko -e DISK_NAME=Storage -e SUBFOLDER=flexget -v $(HOME)/Flexget/tmp:/media/Storage -v $(HOME)/tmp/db-config.sqlite:/root/.flexget/db-config.sqlite tokko/flexget:latest /bin/bash

tmp:
	mkdir tmp

dev:	config.yml_template install.sh make_folders.sh settings.json Dockerfile.dev xbmc-upd.sh Dockerfile.base
	cat Dockerfile.dev Dockerfile.base > Dockerfile
	sudo docker build -t tokko/flexget:dev .

push:
	sudo docker push tokko/flexget:latest .

installdev: install
	sudo apt-get install -y make npm nodejs
	sudo ln -s `which nodejs` /usr/bin/node

install: docker crontab
	mkdir ~/.flexget	
	cp update_flexget.sh ~/.flexget
	crontab -l 2>/dev/null | grep update_flexget.sh && echo "Flexget crontab already present" || echo "45 23 * * * * ~/.flexget/update_flexget.sh" | crontab -
	~/.flexget/update_flexget.sh

crontab:
	sudo apt-get install -y crontab

docker:
	wget http://downloads.hypriot.com/docker-hypriot_1.9.1-1_armhf.deb
	sudo dpkg -i docker-hypriot_1.9.1-1_armhf.deb
clean:
	rm -f docker-hypriot_1.9.1-1_armhf.deb
	rm -f Dockerfile
	sudo rm -rf tmp

cleanall:
	rm -rf ../Flexget
