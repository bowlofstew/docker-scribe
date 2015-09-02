FROM ubuntu:12.04
MAINTAINER Stewart Henderson<henderson.geoffrey@gmail.com>
USER root
RUN apt-get -y update
RUN apt-get -y upgrade
RUN apt-get -y install curl
RUN apt-get -y install build-essential automake autoconf flex libtool bison libevent-dev libssl-dev git python-dev libbz2-dev libboost-all-dev mono-gac
RUN apt-get -y install git
RUN apt-get -y install php5-dev 
RUN curl -L "https://archive.apache.org/dist/incubator/thrift/0.5.0-incubating/thrift-0.5.0.tar.gz" | tar zxv
RUN cd thrift-0.5.0 && \
	./configure --prefix=/opt/thrift --with-libevent=/usr/local/lib && \
    make install
RUN cd thrift-0.5.0 && \
	cd contrib/fb303 && \
	./bootstrap.sh && \
	./configure --prefix=/opt/fb303 --with-thriftpath=/opt/thrift && \
	make install
RUN git clone https://github.com/facebookarchive/scribe.git
RUN cd scribe && \
	./bootstrap.sh && \
	./configure --prefix=/opt/scribe --with-thriftpath=/opt/thrift --with-fb303path=/opt/fb303 --with-boost=/usr/ && \
	make install	
ENTRYPOINT ["/bin/bash"]