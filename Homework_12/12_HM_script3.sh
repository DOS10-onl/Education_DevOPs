#!/bin/bash

#Generating SSH keys and connect to Server VM on SSH key

spawn ssh-keygen
expect "Enter file in which to save the key (/root/.ssh/id_rsa):"
send "\r"

expect "Enter passphrase (empty for no passphrase):"
send "\r"

expect "Enter same passphrase again:"
send "\r"

sleep 2

expect "The key's randomart image is:"

sleep 5

spawn ssh-copy-id vagrant@192.168.53.3
expect "Are you sure you want to continue connecting"
send "yes\r"

expect "password:"
send "vagrant\r"

expect eof 

