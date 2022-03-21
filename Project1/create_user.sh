!/bin/bash
#This bash script creates a user in the Linux system
clear
hostname=$(hostid)
# Check for Root user
#if [ $(id -u) -eq 0 ]; then
# Get username  & password
	read -p "Enter Full Name :" cname
	read -p "Enter username :" username
	read -p "Enter password :" password
  pass_length='echo ${#password}'
  if [[ $count -ne 8 ]]; then
    echo "Password should be at least 8 characters long"
    exit 1
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
