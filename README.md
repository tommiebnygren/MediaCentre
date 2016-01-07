To install:
edit export.sh and fill in your variables
make install to provision host and install the docker containers
make runflexgetauth to start interactive flexget container
run the command /root/flexget.sh -d
browse to www.trakt.tv/pin/346 (make sure you are logged in to trakt.tv)
run the command flexget trakt auth <your accountname (usually your username)> <the pinconde from the browser>
exit the container
All done.

To change disk:
edit ~/.flexget/export.sh and update MEDIA_PATH to its new value
run the command sudo docker restart $(sudo docker ps -q)
