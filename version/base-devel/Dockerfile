FROM bachelorthesis/archlinux:base
MAINTAINER Tony Hesjevik <tony@hesjevik.no>

RUN pacman-install base-devel

COPY pacman-aur-install.sh /usr/local/bin/pacman-aur-install
COPY make-archlinux-rootfs.sh /usr/local/bin/make-archlinux-rootfs