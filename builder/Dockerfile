FROM bachelorthesis/archlinux
MAINTAINER Tony Hesjevik <tony@hesjevik.no>

COPY scripts/mkimage-arch.sh   /usr/bin/mkimage-arch.sh
COPY scripts/pacman-install.sh /tmp/pacman-install
COPY scripts/add-sudo-user.sh  /tmp/add-sudo-user
COPY configs/pacman-mirrorlist /tmp/pacman-mirrorlist
COPY configs/pacman.conf       /tmp/pacman.conf

ENTRYPOINT ["/usr/bin/mkimage-arch.sh"]