install: deb
	sudo dpkg -i docker-hypriot_1.9.1-1_armhf.deb

deb: docker-hypriot_1.9.1-1_armhf.deb
	wget http://downloads.hypriot.com/docker-hypriot_1.9.1-1_armhf.deb

clean:
	rm docker-hypriot_1.9.1-1_armhf.deb
