FROM bachelorthesis/archlinux
MAINTAINER Tony Hesjevik <tony@hesjevik.no>

USER root

COPY scripts/mkimage-arch.sh   /usr/bin/mkimage-arch.sh
COPY scripts/pacman-install.sh /tmp/pacman-install
COPY configs/pacman-mirrorlist /tmp/pacman-mirrorlist
COPY configs/pacman.conf       /tmp/pacman.conf

WORKDIR /root

ENTRYPOINT ["/usr/bin/mkimage-arch.sh"]