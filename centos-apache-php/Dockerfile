FROM cgraefe/centos-systemd

RUN yum -y install https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm http://rpms.remirepo.net/enterprise/remi-release-7.rpm; \
    yum -y install yum-utils; \
    yum-config-manager --enable remi-php56
RUN yum -y install httpd php php-gd php-mbstring php-mcrypt php-mysqlnd php-pdo php-xml php-intl; \
    yum -y install cronie logrotate; \
    yum clean all; \
    systemctl enable httpd.service

VOLUME [ "/var/www", "/var/log/httpd" ]
EXPOSE 80
CMD ["/usr/sbin/init"]

