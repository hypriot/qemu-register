#!/bin/bash
set -e
set -x

# Build Qemu binaries if neccessary
if [ ! -d "./bins" ]; then
	pushd ./qemu-compile
	./build.sh
	popd
fi

# Build Docker image
docker build -t hypriot/qemu-register .
