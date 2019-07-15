#!/bin/bash

# This script is used to add user accounts 

# Make sure the script is being executed with superuser privileges
if [[ "${UID}" -ne 0 ]]
then
	echo 'Please run with root priviledges.'
	exit 1
fi
# Get the username (Login)
read -p 'Enter the username to create: ' USER_NAME

# Get the real name of the person this account is for
read -p 'Enter the full name of the person this account is for: ' REAL_NAME

# Get the password
read -p 'Enter a temporary account password: ' PASSWORD

# Create the user with the password
useradd -c "${REAL_NAME}" -m ${USER_NAME}

# Check to see if the useradd command succeeded.
if [[ "${?}" -ne 0  ]]
then 
	echo 'User creation failed.'
	exit 1
fi

#Print user id

# Set the password
echo ${PASSWORD} | passwd --stdin ${USER_NAME}

# Check to see if the passwd command succeeded.
if [[ "${?}" != 0 ]] 
then
	echo 'Password creation failed.'
	exit 1
fi

# Force password change on first time login.
passwd -e ${USER_NAME}

# Display the username, passwd, and the host where the user was created.
echo
echo 'username:'
echo "${USER_NAME}"
echo
echo 'password:'
echo "${PASSWORD}"
echo
echo 'host:'
echo "${HOSTNAME}"
exit 0






