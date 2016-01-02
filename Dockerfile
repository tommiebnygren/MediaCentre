FROM hypriot/rpi-python:latest

RUN apt-get update 
RUN apt-get install -y python transmission-daemon curl && apt-get remove -y python-pip

RUN curl https://bootstrap.pypa.io/get-pip.py | python
RUN pip install -U pip

COPY requirements.txt /root/requirements.txt
RUN pip install -r /root/requirements.txt --ignore-installed

COPY config.yml_template /root/config.yml_template
COPY make_folders.sh /root/make_folders.sh
COPY install.sh /root/install.sh
COPY settings.json /root/settings.json
COPY xbmc-upd.sh /root/xbmc-upd.sh
COPY export.sh /root/export.sh

CMD /root/install.sh
