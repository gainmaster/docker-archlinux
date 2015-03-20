#!/usr/bin/env bash

declare IMAGE_NAME="bachelorthesis/archlinux"

set -e

deploy() {
	docker login -e $DOCKER_EMAIL -u $DOCKER_USER -p $DOCKER_PASSWORD
	docker push "$IMAGE_NAME"
}

if [[ -z $(which docker) ]]; then
    echo "Missing docker client which is required for deployment."
    exit 2
fi

deploy