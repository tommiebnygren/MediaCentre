FROM resin/raspberrypi2-buildpack-deps:jessie

WORKDIR /root

VOLUME /root/.flexget

CMD /root/flexget.sh

RUN apt-get update && apt-get install -y \
		python \
		python-dev \
		python-dbus \
		python-pip \
		python-virtualenv \
		python-setuptools  && \
		rm -rf /var/lib/apt/lists/* && \
		pip install transmissionrpc flexget subliminal==1.0.1

COPY flexget/config.yml_template flexget/flexget.sh /root/

