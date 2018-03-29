# PCO Challenge Platform Infrastructure Overview

This repository contains architecture documentation and build scripts for the various Virtual Machines that make up the
PCO Challenge Platform Infrastructure

- [Infrastructure Diagram](PCO%20Challenge%20Platform%20Infrastructure.pdf)
- [Detailed VM Descriptions](challenge-platform-server-architecture.md)

## PCO-CP-Jumpbox
Publicly-accessible jumpbox for connecting to other VMs
- no scripts - standard minimal Azure Ubuntu 16.04 image

## PCO-CP-VM
Application server - contains drupal application files
- PHP7.1-fpm
- Nginx
- Based on a Base Image which is built with packer and cloud-init scripts included here

## PCO-CP-Nginx
Reverse Proxy, Static Cache, SSL Termination
- Nginx (configured as a Reverse Proxy and static cache)
- Let's Encrypt certbot
- Basic Azure Ubuntu 16.04 image, provisioning script included here