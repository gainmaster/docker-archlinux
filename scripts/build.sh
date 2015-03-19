#!/usr/bin/env bash

declare ROOTFS_BUILDER_IMAGE_NAME="archlinux-builder"
declare ROOTFS_BUILDER_CONTAINER_NAME="archlinux-builder-container"
declare IMAGE_NAME="bachelorthesis/archlinux"
declare CONTAINER_NAME="archlinux-container"

set -e

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

test() {
	docker run --rm "$IMAGE_NAME" echo "Success!"
}

deploy() {
	docker login -e $DOCKER_EMAIL -u $DOCKER_USER -p $DOCKER_PASSWORD
	docker push "$IMAGE_NAME"
}

cleanup() {
	docker rmi "$IMAGE_NAME"
	rm -Rf arch-rootfs.tar.xz
}

if [[ -z $(which docker) ]]; then
    echo "Missing docker client which is required for building"
    exit 2
fi

build_rootfs && build && test && deploy && cleanup