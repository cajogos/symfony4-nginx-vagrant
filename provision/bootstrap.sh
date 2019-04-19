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
logInfoMsg "Installing PHP FPM (Extensions: XML & ZIP)"
sudo apt-get -qq -y install -o=Dpkg::Use-Pty=0 php7.2-fpm php7.2-xml php7.2-zip

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
