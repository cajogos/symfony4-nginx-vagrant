#!/bin/bash

logInfoMsg() {
    echo "[INFO] --> $1..."
}

# System Preparation
logInfoMsg "Updating packages"
sudo apt-get -qq update

# NGINX Installation
logInfoMsg "Installing NGINX"
sudo apt-get -qq -y install -o=Dpkg::Use-Pty=0 nginx

# PHP Installation
logInfoMsg "Installing PHP FPM"
sudo apt-get -qq -y install -o=Dpkg::Use-Pty=0 php7.2-fpm

# PHP Extensions
logInfoMsg "Installing Required PHP extensions"
sudo apt-get -qq -y install -o=Dpkg::Use-Pty=0 php7.2-xml php7.2-zip php7.2-curl php7.2-intl php7.2-sqlite3

# Composer Installation
logInfoMsg "Installing Composer"
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
php composer-setup.php > /dev/null
php -r "unlink('composer-setup.php');"
sudo mv composer.phar /usr/local/bin/composer

# NGINX Configuration
logInfoMsg "Configuring NGINX"
cp /var/www/provision/nginx_vhost.conf /etc/nginx/sites-available/symfony-project
ln -s /etc/nginx/sites-available/symfony-project /etc/nginx/sites-enabled
rm -rf /etc/nginx/sites-enabled/default
logInfoMsg "Restarting NGINX"
sudo systemctl restart nginx


logInfoMsg "Done! Let's develop! You may use vagrant ssh to access this machine"
