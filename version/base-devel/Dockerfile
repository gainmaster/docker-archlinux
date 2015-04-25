FROM gainmaster/archlinux:base
MAINTAINER Tony Hesjevik <tony@hesjevik.no>

RUN pacman-install base-devel

COPY aur-install.sh             /usr/local/bin/aur-install
COPY aur-build-tar.sh           /usr/local/bin/aur-build-tar
COPY build-archlinux-rootfs.sh  /usr/local/bin/build-archlinux-rootfs