FROM centos:7
LABEL version="0.2" description="OwnTracks Recorder with MySQL Storage Backend"
LABEL authors="Christian Graefe <tmp131127-docker@graefe.net>"

ARG LUAROCKS_VERSION=2.4.2

ENV container docker

ADD http://download.opensuse.org/repositories/home:/oojah:/mqtt/CentOS_CentOS-7/home:oojah:mqtt.repo /etc/yum.repos.d/mosquitto.repo
ADD http://repo.owntracks.org/centos/owntracks.repo /etc/yum.repos.d/owntracks.repo
RUN yum -y update; \
  yum -y install ot-recorder; \
  yum -y install lua-devel unzip make gcc mysql-devel git; \
  yum clean all

# data volume
VOLUME /owntracks

COPY ot-recorder.default /etc/default/ot-recorder
COPY launcher.sh /usr/local/sbin/launcher.sh
COPY recorder-health.sh /usr/local/sbin/recorder-health.sh
COPY mysql.lua /usr/local/libexec/mysql.lua

# LuaRocks
ADD http://luarocks.github.io/luarocks/releases/luarocks-${LUAROCKS_VERSION}.tar.gz /usr/local/src/
RUN cd /usr/local/src && tar -xzf luarocks-${LUAROCKS_VERSION}.tar.gz && cd luarocks-${LUAROCKS_VERSION} && ./configure && make build && make install
RUN luarocks install luasql-mysql MYSQL_INCDIR=/usr/include/mysql MYSQL_LIBDIR=/usr/lib64/mysql && \
    luarocks install dkjson

RUN mkdir -p -m 775 /owntracks/recorder/store && \
	chown -R owntracks:owntracks /owntracks && \
	chmod 755 /usr/local/sbin/launcher.sh /usr/local/sbin/recorder-health.sh

HEALTHCHECK CMD /usr/local/sbin/recorder-health.sh

EXPOSE 8083
CMD ["/usr/local/sbin/launcher.sh"]
