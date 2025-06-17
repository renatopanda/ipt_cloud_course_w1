#!/bin/bash
MSG_COLOR="\033[41m"

echo -e "$MSG_COLOR$(hostname): Creating mysql wordpress database and user.\033[0m"
mysql -u root << EOF
CREATE DATABASE wordpress;
CREATE USER 'wordpress'@'%' IDENTIFIED BY 'mei.ipt.pt.password';
GRANT SELECT,INSERT,UPDATE,DELETE,CREATE,DROP,ALTER ON wordpress.* TO 'wordpress'@'%';
FLUSH PRIVILEGES;
quit
EOF