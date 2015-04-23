#!/usr/bin/env bash

SCRIPT_DIRECTORY=$(cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd)

export AUR_BUILD_DIRECTORY=${AUR_BUILD_DIRECTORY:-$PWD}

if [[ $EUID -eq 0 ]]; then
	runuser -l admin -c "AUR_BUILD_DIRECTORY=$AUR_BUILD_DIRECTORY $SCRIPT_DIRECTORY/aur-build-tar $@"
    exit 0
fi

for package in ${@}; do
    cd $AUR_BUILD_DIRECTORY
    curl https://aur.archlinux.org/packages/${package:0:2}/$package/$package.tar.gz | tar xz
    cd $package
    makepkg $package --skippgpcheck
    mv ${package}*.pkg.tar.xz ../${package}.pkg.tar.xz
    cd $AUR_BUILD_DIRECTORY && rm -Rf $package
done