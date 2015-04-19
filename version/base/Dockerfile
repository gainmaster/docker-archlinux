FROM scratch
MAINTAINER Tony Hesjevik <tony@hesjevik.no>

ADD archlinux-rootfs.tar.xz /

COPY add-sudo-user.sh      /usr/local/bin/add-sudo-user
COPY pacman-install.sh     /usr/local/bin/pacman-install
COPY pacman-install-tar.sh /usr/local/bin/pacman-install-tar

RUN add-sudo-user admin