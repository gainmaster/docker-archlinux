#!/usr/bin/env bash

if [[ $EUID -ne 0 ]]; then
    sudo pacman -U --noconfirm "$@" && rm -Rf /var/cache/pacman/pkg/*
else
    pacman -U --noconfirm "$@" && rm -Rf /var/cache/pacman/pkg/*
fi