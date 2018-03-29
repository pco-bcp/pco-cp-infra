#!/bin/bash

apt-get update
apt-get upgrade -y

# install nginx and utils
apt-get -y install nginx
apt-get -y install python-software-properties curl git

# install php repository
add-apt-repository ppa:ondrej/php
apt-get update

# install php stuff
apt-get -y install php7.1-cgi php7.1-fpm php7.1-curl php7.1-mbstring php7.1-cli php7.1-zip php7.1-mysql php7.1-xml php7.1-gd mysql-client

# install composer
curl -sS https://getcomposer.org/installer | php
mv composer.phar /usr/local/bin/composer

# copy in nginx config
cp /tmp/nginx.conf /etc/nginx/sites-available/default

# copy in php config
cp /tmp/php.ini /etc/php/7.1/cli/php.ini
cp /tmp/php.ini /etc/php/7.1/fpm/php.ini
cp /tmp/www.conf /etc/php/7.1/fpm/pool.d/www.conf

apt-get autoremove -qy