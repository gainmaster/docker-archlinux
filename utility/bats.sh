#!/usr/bin/env bash

WORKING_DIRECTORY=$(pwd)
PROJECT_DIRECTORY=$(cd "$( dirname "${BASH_SOURCE[0]}" )/../" && pwd)

if [[ ${WORKING_DIRECTORY} != ${PROJECT_DIRECTORY}* ]]; then
    echo "Make root fs must be executed from within docker-archlinux project folder."
    exit 1
fi

DOCKER_WORKING_DIRECTORY=${WORKING_DIRECTORY#"$PROJECT_DIRECTORY"}

[[ -z "$PS1" ]] && DOCKER_RUN_OPTIONS="-i -t"

echo $DOCKER_RUN_OPTIONS

#docker run -it --rm \
#  -v $PROJECT_DIRECTORY:/project \
#  -w="/project${DOCKER_WORKING_DIRECTORY}/" \
#  --privileged \
#  --entrypoint make-archlinux-rootfs \
#  bachelorthesis/archlinux:base-devel