#!/bin/sh

#Updating and installing some services on Server VM


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
echo "${GREEN} Configuring RSYNC conf ${BLACK}"
cat 12_HM_Config_RSYNC.txt > /etc/rsyncd.conf
systemctl start rsync


#Create the random file in dir

echo "${GREEN} Create random file ${BLACK}"

mkdir /home/vagrant/folder1

fallocate -l 100M /home/vagrant/folder1/test1.txt
fallocate -l 200M /home/vagrant/folder1/test2.txt
fallocate -l 1M /home/vagrant/folder1/test3.txt
fallocate -l 1M /home/vagrant/folder1/test4.txt
fallocate -l 1M /home/vagrant/folder1/test5.txt

#Check the correct work of installing services
echo "${GREEN} Checking the running service ${BLACK}"

if  service --status-all | grep ssh | grep "[+]"  
	then 
		echo  "${GREEN} SSH is running ${BLACK}" 
	else
		echo "${RED} SSH is not running ${BLACK}"

fi

if  service --status-all | grep rsync | grep "[+]" 
	then 
                echo  "${GREEN} RSYNC is running ${BLACK}" 
        else
                echo "${RED} RSYNC is not running ${BLACK}"

fi


