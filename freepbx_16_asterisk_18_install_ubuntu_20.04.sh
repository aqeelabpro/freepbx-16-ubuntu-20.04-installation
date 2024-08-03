#!/bin/bash

# Update system packages
sudo apt update
sudo apt -y upgrade

# Install dependencies
sudo apt -y install git curl wget libnewt-dev libssl-dev libncurses5-dev subversion libsqlite3-dev build-essential libjansson-dev libxml2-dev uuid-dev libedit-dev

# Add the universe repository
sudo add-apt-repository universe

# Update package lists again
sudo apt update

# Install subversion
sudo apt install -y subversion

# Check the Asterisk package policy
sudo apt policy asterisk

# Change to the /usr/src directory
cd /usr/src/

# Download and extract Asterisk
sudo curl -O https://downloads.asterisk.org/pub/telephony/asterisk/asterisk-18-current.tar.gz
sudo tar xvf asterisk-18-current.tar.gz

# Change to the Asterisk source directory
cd asterisk-18*/

# Run the mp3 source script and install prerequisites
sudo contrib/scripts/get_mp3_source.sh
sudo contrib/scripts/install_prereq install

# Configure, compile, and install Asterisk
sudo ./configure
sudo make menuselect
sudo make
sudo make install
sudo make samples
sudo make config

# Refresh shared library cache
sudo ldconfig

# Return to the home directory
cd ~

# Create Asterisk group and user
sudo groupadd asterisk
sudo useradd -r -d /var/lib/asterisk -g asterisk asterisk
sudo usermod -aG audio,dialout asterisk

# Set ownership of Asterisk directories
sudo chown -R asterisk.asterisk /etc/asterisk
sudo chown -R asterisk.asterisk /var/{lib,log,spool}/asterisk
sudo chown -R asterisk.asterisk /usr/lib/asterisk

# Update Asterisk default configuration
sudo sed -i 's/#\(AST_USER="asterisk"\)/\1/g; s/#\(AST_GROUP="asterisk"\)/\1/g' /etc/default/asterisk

# Update Asterisk main configuration
sudo sed -i 's/;\(runuser = asterisk\)/\1/g; s/;\(rungroup = asterisk\)/\1/g' /etc/asterisk/asterisk.conf

# Restart and enable Asterisk service
sudo systemctl restart asterisk
sudo systemctl enable asterisk
sudo systemctl status asterisk.service 

# Update radius configuration in Asterisk
sudo sed -i 's";\[radius\]"\[radius\]"g' /etc/asterisk/cdr.conf
sudo sed -i 's";radiuscfg => /usr/local/etc/radiusclient-ng/radiusclient.conf"radiuscfg => /etc/radcli/radiusclient.conf"g' /etc/asterisk/cdr.conf
sudo sed -i 's";radiuscfg => /usr/local/etc/radiusclient-ng/radiusclient.conf"radiuscfg => /etc/radcli/radiusclient.conf"g' /etc/asterisk/cel.conf

# Restart and check Asterisk service again
sudo systemctl restart asterisk
sudo systemctl status asterisk.service 

# Install MariaDB and Apache2
sudo apt install -y mariadb-server apache2

# Backup and modify Apache2 configuration
sudo cp /etc/apache2/apache2.conf /etc/apache2/apache2.conf_orig
sudo sed -i 's/^\(User\|Group\).*/\1 asterisk/' /etc/apache2/apache2.conf
sudo sed -i 's/AllowOverride None/AllowOverride All/' /etc/apache2/apache2.conf

# Remove default Apache index page and disable default site
sudo rm -f /var/www/html/index.html
sudo unlink /etc/apache2/sites-enabled/000-default.conf

# Install additional packages for PHP
sudo apt install -y lsb-release ca-certificates apt-transport-https software-properties-common gnupg2
echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" | sudo tee /etc/apt/sources.list.d/sury-php.list
wget -qO - https://packages.sury.org/php/apt.gpg | sudo apt-key add -

# Remove existing PHP packages and add new repository for PHP 7.4
sudo apt remove -y php*
sudo apt -y install software-properties-common
sudo add-apt-repository ppa:ondrej/php
sudo apt-get update
sudo apt -y install php7.4

# Install PHP 7.4 and related modules
sudo apt install -y php7.4 php7.4-{mysql,cli,common,imap,ldap,xml,fpm,curl,mbstring,zip,gd,gettext,xml,json,snmp}
sudo apt install -y libapache2-mod-php7.4

# Modify PHP configuration
sudo sed -i 's/\(^upload_max_filesize = \).*/\120M/' /etc/php/7.4/apache2/php.ini
sudo sed -i 's/\(^upload_max_filesize = \).*/\120M/' /etc/php/7.4/cli/php.ini
sudo sed -i 's/\(^memory_limit = \).*/\1256M/' /etc/php/7.4/apache2/php.ini

# Download and extract FreePBX
cd ~/
wget http://mirror.freepbx.org/modules/packages/freepbx/7.4/freepbx-16.0-latest.tgz
tar xfz freepbx-16.0-latest.tgz
rm -f freepbx-16.0-latest.tgz
cd freepbx

# Stop Asterisk and start FreePBX installation
sudo systemctl stop asterisk
sudo ./start_asterisk start

# Install Node.js and npm
sudo apt install -y nodejs npm

# Run FreePBX installation
sudo ./install -n

# Disable commercial repository and install all modules
sudo fwconsole ma disablerepo commercial
sudo fwconsole ma installall
sudo fwconsole ma delete firewall

# Reload and restart FreePBX
sudo fwconsole reload
sudo fwconsole restart

# Enable Apache mod_rewrite and restart Apache
sudo a2enmod rewrite
sudo systemctl restart apache2

# Final FreePBX command
sudo fwconsole
