#!/usr/bin/env bash

set -x              # Print command traces before executing command
trap 'exit 1' ERR   # Exit script with error if command fails

# Set working directory to project root
cd $(dirname "${BASH_SOURCE[0]}") && cd ../

declare ROOTFS_BUILDER_IMAGE_NAME="archlinux-builder"
declare ROOTFS_BUILDER_CONTAINER_NAME="archlinux-builder-container"
declare IMAGE_NAME="bachelorthesis/archlinux"

build_rootfs() {
    docker build -t "$ROOTFS_BUILDER_IMAGE_NAME" ./builder
    docker run --privileged --name "$ROOTFS_BUILDER_CONTAINER_NAME" "$ROOTFS_BUILDER_IMAGE_NAME"
    docker cp "$ROOTFS_BUILDER_CONTAINER_NAME":/opt/shared/arch-rootfs.tar.xz ./

    docker rm "$ROOTFS_BUILDER_CONTAINER_NAME"
    docker rmi "$ROOTFS_BUILDER_IMAGE_NAME"
}

build() {
    docker build -t "$IMAGE_NAME" .
}

if [[ -z $(which docker) ]]; then
    echo "Missing docker client which is required for building."
    exit 2
fi

build_rootfs && build