#!/usr/bin/env bash

if [[ -z $(which sudo) ]]; then
    echo "Installing sudo"
    pacman-install sudo
fi

if [ -z "$1" ]; then 
    echo "No username given"
    exit 1
fi

USERNAME=$1
SHELL=${2:-"/usr/bin/bash"}

echo $USERNAME
echo $SHELL

#useradd -s $SHELL -U $USERNAME
#mkdir /home/$USERNAME
#chown $USERNAME:$USERNAME /home/$USERNAME 
#chmod 755 /home/$USERNAME

#echo "$USERNAME ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers