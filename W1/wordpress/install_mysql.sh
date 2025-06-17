#!/bin/bash
MSG_COLOR="\033[41m"

echo -e "$MSG_COLOR$(hostname): Updating the local package database / information.\033[0m"
apt update

echo -e "$MSG_COLOR$(hostname): Installing mysql.\033[0m"
apt install mysql-server -y

echo -e "$MSG_COLOR$(hostname): Changing bind-address to 0.0.0.0.\033[0m"
sed -i 's/bind-address\s*=\s*127.0.0.1/bind-address = 0.0.0.0/' /etc/mysql/mysql.conf.d/mysqld.cnf

echo -e "$MSG_COLOR$(hostname): Restarting mysql.\033[0m"
systemctl restart mysql