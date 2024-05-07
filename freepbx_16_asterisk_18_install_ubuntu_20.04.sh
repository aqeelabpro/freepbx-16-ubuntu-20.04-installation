apt update
apt -y full-upgrade
apt install git curl wget libnewt-dev libssl-dev libncurses5-dev subversion libsqlite3-dev build-essential libjansson-dev libxml2-dev  uuid-dev
add-apt-repository universe
apt update
apt install subversion
apt policy asterisk
cd /usr/src/
curl -O http://downloads.asterisk.org/pub/telephony/asterisk/asterisk-18-current.tar.gz
tar xvf asterisk-18-current.tar.gz
cd asterisk-18*/
contrib/scripts/get_mp3_source.sh
contrib/scripts/install_prereq install
./configure
make menuselect
make
make install
make samples
make config
ldconfig
cd
sudo groupadd asterisk
sudo useradd -r -d /var/lib/asterisk -g asterisk asterisk
sudo usermod -aG audio,dialout asterisk
sudo chown -R asterisk.asterisk /etc/asterisk
sudo chown -R asterisk.asterisk /var/{lib,log,spool}/asterisk
sudo chown -R asterisk.asterisk /usr/lib/asterisk
# nano /etc/default/asterisk
sed -i 's/#\(AST_USER="asterisk"\)/\1/g; s/#\(AST_GROUP="asterisk"\)/\1/g' /etc/default/asterisk
# nano /etc/asterisk/asterisk.conf
sed -i 's/;\(runuser = asterisk\)/\1/g; s/;\(rungroup = asterisk\)/\1/g' /etc/asterisk/asterisk.conf
systemctl restart asterisk
systemctl enable asterisk
systemctl status asterisk.service 
sed -i 's";\[radius\]"\[radius\]"g' /etc/asterisk/cdr.conf
sed -i 's";radiuscfg => /usr/local/etc/radiusclient-ng/radiusclient.conf"radiuscfg => /etc/radcli/radiusclient.conf"g' /etc/asterisk/cdr.conf
sed -i 's";radiuscfg => /usr/local/etc/radiusclient-ng/radiusclient.conf"radiuscfg => /etc/radcli/radiusclient.conf"g' /etc/asterisk/cel.conf
systemctl restart asterisk
systemctl status asterisk.service 
# asterisk -rvvvvvvvv
apt install mariadb-server
apt install apache2
cp /etc/apache2/apache2.conf /etc/apache2/apache2.conf_orig
sed -i 's/^\(User\|Group\).*/\1 asterisk/' /etc/apache2/apache2.conf
sed -i 's/AllowOverride None/AllowOverride All/' /etc/apache2/apache2.conf
rm -f /var/www/html/index.html
unlink  /etc/apache2/sites-enabled/000-default.conf
apt install -y lsb-release ca-certificates apt-transport-https software-properties-common gnupg2
echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" | sudo tee /etc/apt/sources.list.d/sury-php.list
wget -qO - https://packages.sury.org/php/apt.gpg | sudo apt-key add -
apt remove php*
# Added new lines
apt -y install software-properties-common
add-apt-repository ppa:ondrej/php
apt-get update
apt -y install php7.4
# END
apt install php7.4 php7.4-{mysql,cli,common,imap,ldap,xml,fpm,curl,mbstring,zip,gd,gettext,xml,json,snmp}
apt install libapache2-mod-php7.4
sudo sed -i 's/\(^upload_max_filesize = \).*/\120M/' /etc/php/7.4/apache2/php.ini
sudo sed -i 's/\(^upload_max_filesize = \).*/\120M/' /etc/php/7.4/cli/php.ini
sed -i 's/\(^memory_limit = \).*/\1256M/' /etc/php/7.4/apache2/php.ini
cd ~/
wget http://mirror.freepbx.org/modules/packages/freepbx/7.4/freepbx-16.0-latest.tgz
tar xfz freepbx-16.0-latest.tgz
rm -f freepbx-16.0-latest.tgz
cd freepbx
systemctl stop asterisk
./start_asterisk start
apt install nodejs npm
#use only if got this error "Error! Unable to read /etc/asterisk/asterisk.conf or it was missing a directories section"
#sudo cp /etc/asterisk/asterisk.conf.old /etc/asterisk/asterisk.conf
./install -n
fwconsole ma disablerepo commercial
fwconsole ma installall
fwconsole ma delete firewall
fwconsole reload
fwconsole restarta2enmod rewrite
systemctl restart apache2
a2enmod rewrite
systemctl restart apache2
fwconsole
