Make the usual preparations for the pi.

Then run install_host.sh as sudo.
Then browse to www.trakt.tv and sign up. Create a list named "following" and make sure that you have a list named "watchlist".

If you have an NTFS-formatted disk find the disk UUID and configure the permissions with fstab.

set permission 777 on your media folders (chmod -R +x 777 <path>

Browse to www.trakt.tv/pin/346

run update.sh <media_path> <trakt pin>
This may take some while as it is downloading multiple docker containers.

Sometimes the flexget authorization token times out prematurely, aquire a new pin and run the update command again.

Now you should have a transmission client on localhost:9091 and a sickrage server on localhost:8081.

To install couch potato container
docker run --link transmission -p 5050:5050 -v /media/Elements:/root/Storage --name=couchpotato -d tokko/couchpotato:latest
