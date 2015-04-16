#!/usr/bin/env bash

if [[ -z $(which sudo) ]]; then
    echo "Installing sudo"
    pacman-install sudo
    echo "%wheel ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
fi

for username in "$@"; do
    useradd -G wheel -s /usr/bin/bash -U $username && passwd -d $username
    mkdir /home/$username
    chown $username:$username /home/$username 
    chmod 755 /home/$username
done
