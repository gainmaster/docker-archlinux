#!/usr/bin/env bash

trap 'exit 1' ERR   # Exit script with error if command fails

if [[ -z $(which docker) ]]; then
    echo "Missing docker client which is required for building, testing and pushing"
    exit 3
fi

declare SCRIPT_DIRECTORY=$(cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd)
declare IMAGE_NAME="bachelorthesis/archlinux"
declare VERSION_DIRECTORY="${SCRIPT_DIRECTORY}/version"

cd $SCRIPT_DIRECTORY

function build {
	version="${1}"
	directory="${VERSION_DIRECTORY}/${version}"

    if [ ! -d "$directory" ]; then
        echo "Cant build image ${IMAGE_NAME}:${version}, the verision does not exist"
        exit 1
    fi

    if [ "$version" == "base" ]; then
        rm -Rf $directory/archlinux-rootfs.tar.xz
        cd $directory
        $SCRIPT_DIRECTORY/utility/archlinux-rootfs-builder.sh
        cd $SCRIPT_DIRECTORY
    fi

    while read tag; do
        docker build -t "${IMAGE_NAME}:${tag}" "${directory}"
    done < "${directory}/tags"
}


function test {
    version="${1}"
    directory="${VERSION_DIRECTORY}/${version}"

    if [ ! -d "$directory" ]; then
        echo "Cant test image ${IMAGE_NAME}:${version}, the verision does not exist"
        exit 1
    fi

	docker history "${IMAGE_NAME}:${version}" 2> /dev/null

    if [ $? -eq 1 ]; then
        echo "Cant test ${IMAGE_NAME}:${version}, the image is not built"
        exit 2
    fi

    $SCRIPT_DIRECTORY/utility/bats.sh test/archlinux-base.bats
}

function run {
    version="${1}"
    directory="${VERSION_DIRECTORY}/${version}"

    if [ ! -d "$directory" ]; then
        echo "Cant test image ${IMAGE_NAME}:${version}, the verision does not exist"
        exit 1
    fi

    docker history "${IMAGE_NAME}:${version}" 2> /dev/null

    if [ $? -eq 1 ]; then
        echo "Cant run ${IMAGE_NAME}:${version}, the image is not built"
        exit 2
    fi

    docker run --rm -it "${IMAGE_NAME}:${version}" bash
}


function push {
    version="${1}"
    directory="${VERSION_DIRECTORY}/${version}"

    if [ ! -d "$directory" ]; then
        echo "Cant push image ${IMAGE_NAME}:${version}, the verision does not exist"
        exit 1
    fi

    docker history "${IMAGE_NAME}:${version}" 2> /dev/null

    if [ $? -eq 1 ]; then
        echo "Cant push ${IMAGE_NAME}:${version}, the image is not built."
        exit 3
    fi

    [ -z "$DOCKER_EMAIL" ]    && { echo "Need to set DOCKER_EMAIL";    exit 4; }
    [ -z "$DOCKER_USER" ]     && { echo "Need to set DOCKER_USER";     exit 4; }
    [ -z "$DOCKER_PASSWORD" ] && { echo "Need to set DOCKER_PASSWORD"; exit 4; }

    if [[ $EUID -ne 0 ]]; then
        if [[ -z $(which sudo) ]]; then
            echo "Missing sudo client which is required for pushing when not root"
            exit 2
        fi

        sudo docker login -e $DOCKER_EMAIL -u $DOCKER_USER -p $DOCKER_PASSWORD
        sudo docker push $IMAGE_NAME
    else
        docker login -e $DOCKER_EMAIL -u $DOCKER_USER -p $DOCKER_PASSWORD
        docker push $IMAGE_NAME
    fi
}


#
# Handle input
#
versions=()
actions=("$@")

while getopts ":v:" opt; do
  case $opt in
    v)
      versions+=("$OPTARG")
      ;;
    \?)
      echo "Invalid option: -$OPTARG"
      ;;
  esac
done

if [ ${#actions[@]} -eq 0 ]; then
    actions=(build test push)
fi

if [ ${#versions[@]} -eq 0 ]; then
    for version in ${VERSION_DIRECTORY}/*; do
        versions+=($(basename $(echo $version)))
    done
fi

for action in "${actions[@]}"; do 
    case "$action" in
        build)
            for version in "${versions[@]}"; do
               build $version
            done
            ;;
         
        test)
            for version in "${versions[@]}"; do
               test $version
            done
            ;;

        run)
            for version in "${versions[@]}"; do
               run $version
            done
            ;;

        push)
            for version in "${versions[@]}"; do
               push $version
            done
            ;;
    esac
done
