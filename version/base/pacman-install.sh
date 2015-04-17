#!/usr/bin/env bash

pacman -Sy --noconfirm "$@" && rm -Rf /var/cache/pacman/pkg/*