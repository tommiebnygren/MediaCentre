FROM hypriot/rpi-python:latest

COPY requirements.txt /root/requirements.txt

RUN apt-get update
RUN apt-get install -y python transmission-daemon 
#RUN pip install -U pip
#RUN pip install -r /root/requirements.txt

COPY config.yml_template /root/config.yml_template
COPY make_folders.sh /root/make_folders.sh
COPY install.sh /root/install.sh
COPY settings.json /root/settings.json
COPY xbmc-upd.sh /root/xbmc-upd.sh
COPY export.sh /root/export.sh
CMD /root/install.sh
