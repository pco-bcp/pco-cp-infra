## The following is old config info holding onto for reference, but will probably just delete
### OLD SERVER - KEEPING FOR db INFO
- Name: PCO-Challenge-Platform-VM
- Resource Group: PCO-CP-VM
- IP: 52.235.41.181
- User: pcocp
- Storage: /pco-cp-storage
- MYSQL Connection: mysql -u pco-user@pco-cp-db -p -h pco-cp-db.mysql.database.azure.com
- Firewall:
  - Allow 80,443
- Aliases:
  - db # (connect to db)

### OLD SERVER Configuration/Commands
- `sudo apt-get install mysql-client`
- `sudo adduser pcocp`
- `sudo usermod -aG sudo pcocp`
- install composer
- install certbot (then after website configured, install cert and setup autorenewal)

Nginx
- `sudo apt-get install nginx`
- configure site for http/2 and "Avoid old Ciphers" (see https://www.digitalocean.com/community/tutorials/how-to-set-up-nginx-with-http-2-support-on-ubuntu-16-04)
- enable gzip compression: https://www.digitalocean.com/community/tutorials/how-to-add-the-gzip-module-to-nginx-on-ubuntu-14-04

PHP-FPM (7.1)
- `sudo apt-get install python-software-properties`
- `sudo add-apt-repository ppa:ondrej/php`
- `sudo apt-get update`
- `sudo apt-get install php7.1-cgi php7.1-fpm`
- config: set cgi.fix_pathinfo=0 in php.ini
- configure nginx to use php-fpm: https://www.digitalocean.com/community/tutorials/how-to-install-linux-nginx-mysql-php-lemp-stack-in-ubuntu-16-04
- https://wildlyinaccurate.com/solving-502-bad-gateway-with-nginx-php-fpm/

To mount storage drive:
- `sudo apt-get install lsscsi`
- `lsscsi # (get list of drives, in this case /dev/sdc)`
- `sudo fdisk /dev/sdc1 # (then follow typical disk init instructions)`
- `sudo mkfs -t ext4 /dev/sdc1`
- `sudo mkdir /pco-cp-storage`
- `sudo mount /dev/sdc1 /pco-cp-storage`
- `sudo -i blkid # (get UUID for storage mount)`
- `sudo nano /etc/fstab # (add mount to fstab to remount on boot)`
- `sudo apt-get install util-linux`
- `sudo fstrim /pco-cp-storage # (TRIM/UNMAP support for Linux in Azure see: https://docs.microsoft.com/en-us/azure/virtual-machines/linux/add-disk)`

To mount Azure Files share:
- https://docs.microsoft.com/en-us/azure/storage/files/storage-how-to-create-file-share 
- https://docs.microsoft.com/en-us/azure/storage/files/storage-how-to-use-files-linux
- https://docs.microsoft.com/en-us/azure/storage/common/storage-create-storage-account?toc=%2fazure%2fstorage%2ffiles%2ftoc.json
- after following the instructions to create a share, a sidebar will open with instructions to connect from Windows or Linux!
- when mounting the file share, make sure to specify uid/gid for www-data (33/33) (ex: `//pcocpfiles.file.core.windows.net/pcocpstorage /mnt/pco-cp-storage cifs vers=2.1,uid=33,gid=33,username=pcocpfiles...`)
- mount sites directory in fstab with `/mnt/pco-cp-storage/drupal-sites /home/pcocp/challenge-platform/html/sites none bind`

//pcocpfiles.file.core.windows.net/pcocpstorage /mnt/pco-cp-storage cifs vers=2.1,uid=33,gid=33,username=pcocpfiles,password=uAiAxVvI8W+7Ni6pVMNnZE1A+nX5nWXhn/0HG/Bywg40hY9L4B/l$
/mnt/pco-cp-storage/drupal-sites /home/pcocp/challenge-platform/html/sites      none    bind

## OLD Mysql Database
- Name: pco-cp-db
- Resource Group: PCO-CP-VM
- Connections: 
  - Allow from: 69.157.112.229 (local)
  - Allow from: 52.235.43.39 (PCO-Challenge-Platform-VM)
- Admin: samojled@pco-cp-db
- User: pco-user@pco-cp-db

## OLD Storage
- Name: PCO-CP-STORAGE
- Resource Group: PCO-CP-VM
- Size: 1TB
- Type: HDD