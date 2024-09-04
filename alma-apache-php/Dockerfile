FROM docker.io/almalinux/9-init:latest

RUN dnf -y install dnf-utils; dnf -y update
RUN dnf -y install logrotate httpd php
RUN dnf clean all
RUN systemctl enable httpd.service

VOLUME [ "/var/www", "/var/log/httpd" ]
EXPOSE 80
CMD ["/usr/sbin/init"]

