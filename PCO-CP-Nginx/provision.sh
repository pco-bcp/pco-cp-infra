#!/bin/bash

apt-get update
apt-get upgrade -y

apt-get -y install nginx

apt-get install software-properties-common
add-apt-repository ppa:certbot/certbot
apt-get update
apt-get install python-certbot-nginx

# @TODO: this should moved to a deploy script (ie, cloud-init) - also make sure we can automate?
mkdir /var/www/html/.well-known
certbot certonly --webroot -w /var/www/html/ -d impact.canada.ca -d pco-cp.canadaeast.cloudapp.azure.com

