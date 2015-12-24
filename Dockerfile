FROM hypriot/rpi-gogs-alpine

COPY config.yml config.yml
COPY export.sh export.sh
COPY make_folders.sh
COPY install.sh install.sh
COPY provision.sh provision.sh
COPY settings.json settings.json
COPY xbmc-upd.sh xbmc-upd.sh

RUN provision
RUN source export.sh
CMD install.sh
