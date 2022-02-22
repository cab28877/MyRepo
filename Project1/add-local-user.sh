#!/bin/bash
# This script adds a username and its password to Linux system.
# Credits www.cyberciti.biz under GPL v2.0+
#---------------------------------------------------------------
clear
hostname=$(hostid)
# Check for Root user
if [ $(id -u) -eq 0 ]; then
# Get username  & password
	read -p "Enter Full Name :" cname
	read -p "Enter username :" username
	read -s -p "Enter password :" password
# Make sure user doesn't exist
	egrep "^$username" /etc/passwd >/dev/null
	if [ $? -eq 0 ]; then
		echo "$username exists!"
		exit 1
	else
# gets the password encrypted
	    pass=$(perl -e 'print crypt($ARGV[0], "password")' $password)
# adds username and password
	    useradd -c "$cname" -m -p "$pass" "$username" 
            passwd -e "$username" >/dev/null
	    [ $? -eq 0 ] && echo "User $username has been created successfully on system $hostname !" || echo "Failed to add user!"
	fi
else
   echo "Only root may add user to the system."
   exit 2
fi 
