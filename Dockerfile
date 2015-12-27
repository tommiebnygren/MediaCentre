FROM google/python:latest

COPY config.yml config.yml
COPY export.sh export.sh
COPY make_folders.sh make_folders.sh
COPY install.sh install.sh
COPY provision.sh provision.sh
COPY settings.json settings.json
COPY xbmc-upd.sh xbmc-upd.sh

RUN apt-get update
RUN apt-get -y dist-upgrade
RUN apt-get update
RUN apt-get -y upgrade
RUN apt-get install -y python transmission-daemon vim
RUN easy_install pip
RUN pip install pip --upgrade
RUN pip install flexget transmissionrpc
RUN pip install flexget transmissionrpc --upgrade
#RUN sh source export.sh

CMD install.sh
