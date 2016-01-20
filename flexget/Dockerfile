FROM resin/rpi-raspbian:jessie

VOLUME /root/Storage

WORKDIR /root

CMD /root/flexget.sh

RUN 	apt-get update && \
	apt-get install -y curl python && apt-get purge -y python-pip && apt-get clean

RUN curl -k https://bootstrap.pypa.io/get-pip.py | python
RUN pip install -U pip

#COPY flexget/requirements.txt /root/requirements.txt
RUN pip install flexget transmissionrpc #-r /root/requirements.txt --ignore-installed


COPY flexget/config.yml_template flexget/flexget.sh /root/

