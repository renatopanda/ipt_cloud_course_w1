#!/bin/bash
MSG_COLOR="\033[41m"

echo -e "$MSG_COLOR$(hostname): Removing mysql wordpress database and user.\033[0m"
mysql -u root << EOF
DROP DATABASE IF EXISTS wordpress;
DROP USER IF EXISTS 'wordpress'@'%';
FLUSH PRIVILEGES;
quit
EOF