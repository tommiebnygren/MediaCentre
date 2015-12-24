FROM hypriot/rpi-python

COPY config.yml config.yml
COPY export.sh export.sh
COPY make_folders.sh make_folders.sh
COPY install.sh install.sh
COPY provision.sh provision.sh
COPY settings.json settings.json
COPY xbmc-upd.sh xbmc-upd.sh

RUN sh provision.sh
RUN sh source export.sh

CMD install.sh
