To install:
edit export.sh and fill in your variables
run the command source export.sh
make install to provision host and install the docker containers, this may take quite some time.
when the promt enters a docker container (root@something)
run the command /root/flexget.sh -d
browse to www.trakt.tv/pin/346 (make sure you are logged in to trakt.tv)
run the command flexget trakt auth $TRAKT_ACCOUNT <the pinconde from the browser>
exit the container
Wait for installation to finish.

To change disk:
edit ~/.flexget/export.sh and update MEDIA_PATH to its new value
run the command sudo docker restart $(sudo docker ps -q)
