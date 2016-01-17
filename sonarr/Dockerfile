FROM hypriot/rpi-python

RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys FDA5DFFC
RUN echo "deb http://apt.sonarr.tv/ master main" | sudo tee /etc/apt/sources.list.d/sonarr.list
RUN apt-get update && apt-get install -y mono-devel nzbdrone

RUN mkdir -p /root/.config/NzbDrone 
WORKDIR /root

EXPOSE 8989

VOLUME /root/.config/NzbDrone
VOLUME /root/Storage

CMD mono /opt/NzbDrone/NzbDrone.exe
