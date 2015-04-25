#!/usr/bin/env bash

SCRIPT_DIRECTORY=$(cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd)
BUILD_DIRECTORY=${AUR_BUILD_DIRECTORY:-/tmp}

if [[ $EUID -eq 0 ]]; then
	runuser -l admin -c "$SCRIPT_DIRECTORY/aur-install $@"
    exit 0
fi

for package in ${@}; do
    cd $BUILD_DIRECTORY
    curl https://aur.archlinux.org/packages/${package:0:2}/$package/$package.tar.gz | tar xz
    cd $package
    makepkg --syncdeps --skippgpcheck --install --noconfirm $package 
    cd $BUILD_DIRECTORY && rm -Rf $package
done