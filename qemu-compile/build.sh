#!/bin/bash
set -e
set -x

# Cleanup first
BUILD_DEST="../bins"
rm -fr $BUILD_DEST
mkdir -p $BUILD_DEST

# Run build within a Docker images
docker build -t qemu-compile .

# Extract Qemu binaries from Docker container
DOCKER_CONTAINER=$(docker create qemu-compile)
docker cp $DOCKER_CONTAINER:/usr/local/bin/qemu-arm $BUILD_DEST/
docker cp $DOCKER_CONTAINER:/usr/local/bin/qemu-aarch64 $BUILD_DEST/
docker cp $DOCKER_CONTAINER:/usr/local/bin/qemu-ppc64le $BUILD_DEST/
docker rm -f $DOCKER_CONTAINER

# Show results
ls -al $BUILD_DEST/qemu-*
file $BUILD_DEST/qemu-*
