#!/bin/bash

#take username input
read -p "Enter your EC2 instance username: " username
#prompt user to re-enter username if it's empty
while [ ${#username} -eq 0 ]; do
	read -p "Username should not be empty, re-enter username: " username
done

#let user see username entered
echo "username entered is : $username"

#take key name from user
read -p "Enter key name, add the extemsion(.pem): " key
#prompt user to re-enter key if it's wrong
while [ -z "$key" ]; do
	read -p "key not in downloads/aws or invalid key, enter key again, with extemsion(.pem): " key
	instance_key=$(find /c/Users/Teo/Downloads/aws -iname "$key" 2>/dev/null)
	if [[ $instance_key != *.pem ]]; then
		key=""
	fi
done
#show user key entered
echo "key is : $key"

#get ip_address from user
read -p "Enter ip address for your instance: " public_ip
while [ -z "$public_ip" ]; do
	read -p "invalid public_ip address, re-enter ip address"
done
echo "ip is : $public_ip"

chmod 400 $key

ssh -i $key $username@$public_ip

if [ $? -eq 0 ]; then
	echo "connection successful..."
else
	echo "connection failed try again. "
fi