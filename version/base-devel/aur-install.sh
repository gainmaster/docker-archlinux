#!/usr/bin/env bash

if [[ $EUID -ne 0 ]]; then
    sudo aur-install $@
    exit 0
fi

declare BUILD_DIRECTORY=${AUR_BUILD_DIRECTORY:-$PWD}

for package in ${@}; do
    cd $BUILD_DIRECTORY
    curl https://aur.archlinux.org/packages/${package:0:2}/$package/$package.tar.gz | tar xz
    cd $package
    makepkg --syncdeps --install --noconfirm $package 
    cd $BUILD_DIRECTORY && rm -Rf $package
done