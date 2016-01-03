FROM hypriot/rpi-python:latest

RUN apt-get update 
RUN apt-get install -y curl && apt-get remove -y python-pip && apt-get clean

RUN curl https://bootstrap.pypa.io/get-pip.py | python
RUN pip install -U pip

COPY requirements.txt /root/requirements.txt
RUN pip install -r /root/requirements.txt --ignore-installed

VOLUME /root/Storage

COPY xbmc-upd.sh /root/xbmc-upd.sh
COPY make_folders.sh /root/make_folders.sh
COPY settings.json /root/settings.json
COPY config.yml_template /root/config.yml_template
COPY install.sh /root/install.sh

CMD /root/install.sh
