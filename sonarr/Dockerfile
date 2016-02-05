FROM hypriot/rpi-alpine-scratch

EXPOSE 8989 9898 

#ENV LANG='en_US.UTF-8' \
#    LANGUAGE='en_US.UTF-8' \
#    TERM='xterm'

#RUN echo http://dl-4.alpinelinux.org/alpine/edge/testing >> /etc/apk/repositories && \
#  apk -U upgrade && \
#  apk -U add \
#    libmediainfo \
#    ca-certificates \
#    mono \
#    && \
#  apk del make gcc g++ && \
#  rm -rf /tmp/src && \
#  rm -rf /var/cache/apk/*

RUN apk add --update wget ca-certificates bash tar xz && \
    cd /tmp && \
    wget "https://circle-artifacts.com/gh/andyshinn/alpine-pkg-glibc/6/artifacts/0/home/ubuntu/alpine-pkg-glibc/packages/x86_64/glibc-2.21-r2.apk" \
         "https://circle-artifacts.com/gh/andyshinn/alpine-pkg-glibc/6/artifacts/0/home/ubuntu/alpine-pkg-glibc/packages/x86_64/glibc-bin-2.21-r2.apk" && \
    apk add --allow-untrusted glibc-2.21-r2.apk glibc-bin-2.21-r2.apk && \
    /usr/glibc/usr/bin/ldconfig /lib /usr/glibc/usr/lib && \
    echo 'hosts: files mdns4_minimal [NOTFOUND=return] dns mdns4' >> /etc/nsswitch.conf && \
    wget "https://www.archlinux.org/packages/extra/x86_64/mono/download/" -O mono.pkg.tar.xz && \
    cd / && \
    tar xJf /tmp/mono.pkg.tar.xz && \
    mozroots --import --ask-remove && \
    apk del wget ca-certificates tar xz && \
    rm /tmp/* /var/cache/apk/*



RUN wget http://download.sonarr.tv/v2/master/mono/NzbDrone.master.2.0.0.3645.mono.tar.gz -O NzbDrone.tgz && \
  tar xzvf NzbDrone.tgz && \
  rm NzbDrone.tgz

VOLUME /config/nszbdrone

CMD mono /NzbDrone/NzbDrone.exe -data=/config/nzbdrone
