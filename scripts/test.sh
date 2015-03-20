#!/usr/bin/env bash

declare IMAGE_NAME="bachelorthesis/archlinux"

set -e

test() {
	docker run --rm "$IMAGE_NAME" echo "Success!"
}

if [[ -z $(which docker) ]]; then
    echo "Missing docker client which is required for testing."
    exit 2
fi

test