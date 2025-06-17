#!/bin/bash
DB_SERVER="192.168.33.20"
DB_PWD="mei.ipt.pt.password"
MSG_COLOR="\033[41m"

echo -e "$MSG_COLOR$(hostname): Updating the local package database / information.\033[0m"
apt update -y

echo -e "$MSG_COLOR$(hostname): Installing apache2, php and ghostscript.\033[0m"
apt install -y apache2 \
                 ghostscript \
                 libapache2-mod-php \
                 php \
                 php-bcmath \
                 php-curl \
                 php-imagick \
                 php-intl \
                 php-json \
                 php-mbstring \
                 php-mysql \
                 php-xml \
                 php-zip

echo -e "$MSG_COLOR$(hostname): Creating wordpress folder and downloading the file from WordPress.org:.\033[0m"
mkdir -p /srv/www
chown www-data: /srv/www
curl https://wordpress.org/latest.tar.gz | sudo -u www-data tar zx -C /srv/www --overwrite

echo -e "$MSG_COLOR$(hostname): Copying wordpress.conf to /etc/apache2/sites-available/wordpress.conf.\033[0m"
cp /vagrant/wordpress.conf /etc/apache2/sites-available/wordpress.conf
chmod 644 /etc/apache2/sites-available/wordpress.wp-conf

echo -e "$MSG_COLOR$(hostname): Enabling the site.\033[0m"
a2ensite wordpress

echo -e "$MSG_COLOR$(hostname): Enable URL rewriting.\033[0m"
sudo a2enmod rewrite

echo -e "$MSG_COLOR$(hostname): Disabling the default apache2 “It Works” site.\033[0m"
a2dissite 000-default

echo -e "$MSG_COLOR$(hostname): Reloading apache2.\033[0m"
sudo service apache2 reload

echo -e "$MSG_COLOR$(hostname): Changing default WordPress config to use db server $DB_SERVER.\033[0m"
sudo -u www-data cp /srv/www/wordpress/wp-config-sample.php /srv/www/wordpress/wp-config.php
sudo -u www-data sed -i 's/database_name_here/wordpress/' /srv/www/wordpress/wp-config.php
sudo -u www-data sed -i 's/username_here/wordpress/' /srv/www/wordpress/wp-config.php
sudo -u www-data sed -i "s/password_here/$DB_PWD/" /srv/www/wordpress/wp-config.php
sudo -u www-data sed -i "s/define( 'DB_HOST', 'localhost' )/define( 'DB_HOST', '$DB_SERVER' )/" /srv/www/wordpress/wp-config.php

for ip in $(hostname -I); do
    echo -e "\033[42m$(hostname): You can now open http://$ip\033[0m"
done