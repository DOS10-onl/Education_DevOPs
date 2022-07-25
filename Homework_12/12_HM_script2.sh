#!/bin/sh

#Updating and installing some services on Client VM


GREEN='\033[0;32m'
RED='\033[0;31m'
BLACK='\e[0m'
echo "${GREEN} Updating system ${BLACK}"
apt  -y update
echo "${GREEN} Installing SSH server ${BLACK}"
apt install -y openssh-server
systemctl enable sshd
apt install -y expect
echo "${GREEN} Installing RSYNC ${BLACK}"
apt install -y rsync



#Check the correct work of installing services
echo "${GREEN} Checking the running service ${BLACK}"

if  service --status-all | grep ssh | grep "[+]"
        then
                echo  "${GREEN} SSH is running ${BLACK}"
        else
                echo "${RED} SSH is not running ${BLACK}"

fi


