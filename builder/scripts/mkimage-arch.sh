#!/usr/bin/env bash

# Generate a minimal filesystem for archlinux.
#
# This mkimage-arch.sh is a modified version from:
# https://github.com/docker/docker/blob/master/contrib/mkimage-arch.sh.
#
# Changes were inspired by work done by John Regan (jprjr):
# https://github.com/jprjr/docker-archlinux/blob/master/script/mkimage-arch.sh

set -e 

echo "[mkimage-arch.sh]: Building Arch Linux rootfs."

cd $(dirname "${BASH_SOURCE[0]}")

#mkdir -p /run/shm

#if ! mountpoint -q /sys/fs/cgroup; then
#  mount -t tmpfs -o uid=0,gid=0,mode=0755 cgroup /sys/fs/cgroup
#fi

#(
#cd /sys/fs/cgroup
#for sys in $(awk '!/^#/ { if ($4 == 1) print $1 }' /proc/cgroups); do
#  mkdir -p $sys
#  if ! mountpoint -q $sys; then
#    if ! mount -n -t cgroup -o $sys cgroup $sys; then
#      rmdir $sys || true
#    fi
#  fi
#done
#)

# Update pacman and install required packages
rm -f /var/lib/pacman/db.lck
sed -i 's/^CheckSpace/#CheckSpace/g' /etc/pacman.conf
pacman -Syy && pacman -Syu --noconfirm && pacman-db-upgrade
pacman -S --noconfirm --needed arch-install-scripts expect tar base-devel

ROOTFS=$(mktemp -d /rootfs-archlinux-XXXXXXXXXX)
chmod 755 $ROOTFS

# packages to ignore for space savings
PKGIGNORE=linux,jfsutils,lvm2,cryptsetup,groff,man-db,man-pages,mdadm,pciutils,pcmciautils,reiserfsprogs,s-nail,xfsprogs,vi

echo "point 1"

# Populate rootfs with pacstrap
expect << EOF
  set timeout 600
  set send_slow {1 1}
  spawn pacstrap -C /tmp/pacman.conf -c -d -G -i $ROOTFS base bash haveged --ignore $PKGIGNORE
  expect {
    "Install anyway?" { sleep 1; send n\r; exp_continue }
    "(default=all)" { sleep 1; send \r; exp_continue }
    "Proceed with installation?" {sleep 1; send "\r"; exp_continue }
    "skip the above package" {sleep 1; send "y\r"; exp_continue }
    "checking" { exp_continue }
    "loading" { exp_continue }
    "installing" { exp_continue }
  }
EOF

touch $ROOTFS/etc/resolv.conf

echo "point 2"

# Cleanup after pacstrap
arch-chroot $ROOTFS sh -c "haveged -w 1024; pacman-key --init; pkill haveged; pacman -Rs --noconfirm haveged; pacman-key --populate archlinux; pkill gpg-agent"

# Configure system
arch-chroot $ROOTFS /bin/sh -c "ln -s /usr/share/zoneinfo/UTC /etc/localtime"
echo 'en_US.UTF-8 UTF-8' > $ROOTFS/etc/locale.gen
arch-chroot $ROOTFS locale-gen
cat /tmp/pacman-mirrorlist > $ROOTFS/etc/pacman.d/mirrorlist
mv /tmp/pacman-install $ROOTFS/usr/bin/pacman-install

# Rebuild dev (udev doesn't work in containers)
DEV=$ROOTFS/dev
rm -rf $DEV
mkdir -p $DEV
mknod -m 666 $DEV/null c 1 3
mknod -m 666 $DEV/zero c 1 5
mknod -m 666 $DEV/random c 1 8
mknod -m 666 $DEV/urandom c 1 9
mkdir -m 755 $DEV/pts
mkdir -m 1777 $DEV/shm
mknod -m 666 $DEV/tty c 5 0
mknod -m 600 $DEV/console c 5 1
mknod -m 666 $DEV/tty0 c 4 0
mknod -m 666 $DEV/full c 1 7
mknod -m 600 $DEV/initctl p
mknod -m 666 $DEV/ptmx c 5 2
ln -sf /proc/self/fd $DEV/fd

# Compress rootfs
rm -rf /opt/shared/arch-rootfs.tar.xz
mkdir -p /opt/shared
tar --xz -f /opt/shared/arch-rootfs.tar.xz --numeric-owner -C $ROOTFS -c . 
rm -rf $ROOTFS

echo "[mkimage-arch.sh]: Image build completed."