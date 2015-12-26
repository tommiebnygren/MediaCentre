FROM hypriot/rpi-python:latest

COPY config.yml config.yml
#COPY export.sh export.sh
COPY make_folders.sh make_folders.sh
COPY install.sh install.sh
#COPY provision.sh provision.sh
COPY settings.json settings.json
COPY xbmc-upd.sh xbmc-upd.sh

RUN apt-get update
#RUN apt-get -y dist-upgrade
#RUN apt-get update
#RUN apt-get -y upgrade
RUN apt-get remove -y python-pip
RUN apt-get install -y transmission-daemon
RUN apt-get install -yq curl python-dev && apt-get clean
RUN curl https://bootstrap.pypa.io/get-pip.py | python
RUN pip install -U pip
#RUN pip install pip --upgrade
RUN pip install flexget
RUN pip install transmissionrpc

CMD install.sh
