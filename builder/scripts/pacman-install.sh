#!/usr/bin/env bash

pacman Sy --noconfirm "$@" && pacman -Scc