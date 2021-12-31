#CentOS Linux release 7.9.2009 (Core)
FROM anti1346/centos7

ENV www_conf /etc/php-fpm.d/www.conf
ENV php_conf /etc/php.ini
ENV fpm_conf /etc/php-fpm.conf
ENV confdir nginx1.20-php7.4

RUN yum install -q -y epel-release \
  && yum update -q -y \
  && yum install -q -y \
    yum-utils \
    curl \
    gcc \
    gcc-c++ \
    make \
    glibc-common \
    automake \
    autoconf \
    wget \
    unzip

#####Python 3.x
# RUN yum install -q -y python3-pip

#####NGINX, PHP, PHP-FPM, PHP Extension Module 
RUN yum install -q -y nginx \
  nginx-all-modules \
  && yum-config-manager --disable remi-php54 \
  && yum install -q -y http://rpms.remirepo.net/enterprise/remi-release-7.rpm \
  && yum-config-manager --enable remi-php74 \
  && yum install -q -y \
    php \
    php-cli \
    php-fpm \
    php-common \
    php-json

RUN yum install -q -y \
  php-bcmath \
  php-devel \
  php-opcache \
  php-mbstring \
  php-gd \
  php-mysqlnd \
  php-xml \
  php-pear \
  php-pecl-mcrypt \
  php-pecl-mysql \
&& yes '' | pecl install -f igbinary redis \
&& echo "extension=redis.so" > /etc/php.d/ext-redis.ini

# RUN yum install -q -y ImageMagick ImageMagick-devel \
# && yes '' | pecl install -f imagick
# && echo "extension=imagick.so" > /etc/php.d/ext-imagick.ini

#####supervisor 
RUN yum install -q -y supervisor
COPY ./supervisord.conf /etc/supervisord.conf

RUN yum clean all

# RUN sed -i -e "s/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/g" ${php_conf} \
#   && sed -i -e "s/memory_limit\s*=\s*.*/memory_limit = 256M/g" ${php_conf} \
#   && sed -i -e "s/upload_max_filesize\s*=\s*2M/upload_max_filesize = 100M/g" ${php_conf} \
#   && sed -i -e "s/post_max_size\s*=\s*8M/post_max_size = 100M/g" ${php_conf} \
#   && sed -i -e "s/variables_order = \"GPCS\"/variables_order = \"EGPCS\"/g" ${php_conf} \
#   && sed -i -e 's/user = apache */user = nginx/' ${www_conf} \
#   && sed -i -e 's/group = apache */group = nginx/' ${www_conf} \
#   && sed -i -e 's/;listen.owner = nobody */listen.owner = nginx/' ${www_conf} \
#   && sed -i -e 's/;listen.group = nobody */listen.group = nginx/' ${www_conf} \
#   && sed -i -e 's/listen = 127.0.0.1:9000 */listen = \/var\/run\/php-fpm\/php-fpm.sock/' ${www_conf} \
#   && sed -i -e "s/;daemonize\s*=\s*yes/daemonize = no/g" ${www_conf} \
#   && sed -i -e "s/;catch_workers_output\s*=\s*yes/catch_workers_output = yes/g" ${www_conf} \
#   && sed -i -e "s/pm.max_children = 50/pm.max_children = 50/g" ${www_conf} \
#   && sed -i -e "s/pm.start_servers = 5/pm.start_servers = 5/g" ${www_conf} \
#   && sed -i -e "s/pm.min_spare_servers = 5/pm.min_spare_servers = 5/g" ${www_conf} \
#   && sed -i -e "s/pm.max_spare_servers = 35/pm.max_spare_servers = 35/g" ${www_conf} \
#   && sed -i -e "s/pm.max_requests = 500/pm.max_requests = 200/g" ${www_conf} \
#   && sed -i -e "s/www-data/nginx/g" ${www_conf} \
#   && sed -i -e "s/^;clear_env = no$/clear_env = no/" ${www_conf}

#####composer
RUN curl -Ssf https://getcomposer.org/installer -o /tmp/composer-setup.php \
  && php /tmp/composer-setup.php --no-ansi --install-dir=/usr/local/bin --filename=composer --snapshot \
  #&& php /tmp/composer-setup.php --install-dir=/usr/local/bin --filename=composer \
  && rm -f /tmp/composer-setup.php \
  && cd /usr/share/nginx/html \
  && composer require nesbot/carbon

# Nginx
COPY ./${confdir}/nginx.conf /etc/nginx/nginx.conf
COPY ./${confdir}/default.conf /etc/nginx/conf.d/default.conf
# COPY ./${confdir}/html /usr/share/nginx/html
RUN curl -s ifconfig.io > /usr/share/nginx/html/test.html
COPY ./${confdir}/test.php /usr/share/nginx/html/test.php

# PHP
COPY ./${confdir}/php.ini /etc/php.ini
COPY ./${confdir}/php-fpm.conf /etc/php-fpm.conf
COPY ./${confdir}/www.conf /etc/php-fpm.d/www.conf

COPY ./start.sh /start.sh
RUN chmod +x /start.sh

EXPOSE 80

CMD ["/start.sh"]