FROM centos:7
MAINTAINER Christian Graefe <tmp131127-docker@graefe.net>
ENV container docker

RUN yum -y swap -- remove fakesystemd -- install systemd systemd-libs

RUN yum -y update; yum clean all; \
(cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i == systemd-tmpfiles-setup.service ] || rm -f $i; done); \
rm -f /lib/systemd/system/multi-user.target.wants/*;\
rm -f /etc/systemd/system/*.wants/*;\
rm -f /lib/systemd/system/local-fs.target.wants/*; \
rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
rm -f /lib/systemd/system/basic.target.wants/*;\
rm -f /lib/systemd/system/anaconda.target.wants/*;

# CentOS7 EOL, migrate soon
RUN sed -i.bak 's/mirrorlist/#mirrorlist/g' /etc/yum.repos.d/CentOS-* ;\
    sed -i.bak 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-*
    
VOLUME [ "/sys/fs/cgroup" ]
CMD ["/usr/sbin/init"]

