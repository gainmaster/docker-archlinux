#!/usr/bin/env bash
set -x              # Print command traces before executing command
WORKING_DIRECTORY=$(pwd)
PROJECT_DIRECTORY=$(cd "$( dirname "${BASH_SOURCE[0]}" )/../" && pwd)

if [[ ${WORKING_DIRECTORY} != ${PROJECT_DIRECTORY}* ]]; then
    echo "ArchLinux rootfs builder must be executed from within the docker-archlinux project folder."
    exit 1
fi

DOCKER_WORKING_DIRECTORY=${WORKING_DIRECTORY#"$PROJECT_DIRECTORY"}
[[ ! -z "$PS1" ]] && DOCKER_RUN_OPTIONS="-i -t"

docker run $DOCKER_RUN_OPTIONS --rm \
  -v $PROJECT_DIRECTORY:/project \
  -w="/project${DOCKER_WORKING_DIRECTORY}/" \
  --privileged \
  --entrypoint build-archlinux-rootfs \
  bachelorthesis/archlinux:base-devel