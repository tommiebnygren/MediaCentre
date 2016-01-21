FROM ubuntu

#VOLUME /root/Storage

WORKDIR /root

CMD /root/flexget.sh

RUN 	apt-get update && \
	apt-get install -y gcc curl python && apt-get purge -y python-pip && apt-get clean

RUN 	apt-get install -y build-essential autoconf libtool pkg-config python-opengl python-imaging python-pyrex python-pyside.qtopengl idle-python2.7 qt4-dev-tools qt4-designer libqtgui4 libqtcore4 libqt4-xml libqt4-test libqt4-script libqt4-network libqt4-dbus python-qt4 python-qt4-gl libgle3 python-dev


RUN curl -k https://bootstrap.pypa.io/get-pip.py | python
RUN pip install -U pip

RUN pip install green gevent flexget transmissionrpc 


COPY flexget/config.yml_template flexget/flexget.sh /root/

