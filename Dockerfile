FROM bowlofstew/thrift:0.0.1
MAINTAINER Stewart Henderson<henderson.geoffrey@gmail.com>
RUN apt-get -y update
RUN apt-get -y upgrade
RUN git clone https://github.com/facebookarchive/scribe.git /tmp/scribe
RUN cd /tmp/scribe && \
	./bootstrap.sh && \
	./configure --enable-hdfs && \
	make
