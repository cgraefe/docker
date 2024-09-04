FROM docker.io/almalinux/8-init:latest

RUN dnf -y update
RUN dnf -y install https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm https://rpms.remirepo.net/enterprise/remi-release-8.rpm; \
    dnf -y install dnf-utils; \
    dnf config-manager --set-enabled remi
RUN dnf -y install httpd php56 php56-syspaths php56-mod_php php56-php-gd php56-php-mbstring php56-php-mcrypt php56-php-mysqlnd php56-php-pdo php56-php-xml php56-php-intl; \
    dnf -y install cronie logrotate; \
    dnf -y remove php56-php-fpm; \
    dnf clean all; \
    systemctl enable httpd.service

COPY 00-mpm.conf /etc/httpd/conf.modules.d/

VOLUME [ "/var/www", "/var/log/httpd" ]
EXPOSE 80
CMD ["/usr/sbin/init"]

