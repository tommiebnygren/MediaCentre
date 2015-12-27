build:
	cat Dockerfile.rpi Dockerfile.base > Dockerfile
	sudo docker build -t tokko/flexget:latest .

dev:
	cat Dockerfile.dev Dockerfile.base > Dockerfile
	sudo docker build -t tokko/flexget:latest .

push:
	sudo docker push tokko/flexget:latest .

install: 
	wget http://downloads.hypriot.com/docker-hypriot_1.9.1-1_armhf.deb
	sudo dpkg -i docker-hypriot_1.9.1-1_armhf.deb
	sudo apt-get install -y make npm nodejs
	sudo ln -s `which nodejs` /usr/bin/node

clean:
	rm -f docker-hypriot_1.9.1-1_armhf.deb
	rm -f Dockerfile
