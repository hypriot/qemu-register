# Fetch base image
FROM debian:jessie

# Install build dependencies
RUN apt-get update && apt-get install -y \
 	build-essential \
 	ca-certificates \
 	curl \
 	git-core \
 	libfdt-dev \
 	libghc-zlib-dev \
 	libglib2.0-dev \
 	libpixman-1-dev \
 	pkg-config \
 	python \
 	unzip \
    --no-install-recommends \
 && rm -rf /var/lib/apt/lists/*

# Download upstream Qemu v2.7.0 sources
RUN curl -sSLO https://github.com/qemu/qemu/archive/v2.7.0.zip \
 && unzip v2.7.0.zip
WORKDIR qemu-2.7.0

# Apply patch to fix issues with Go
# - patches the file "linux-user/signal.c"
RUN curl -sSL https://github.com/resin-io/qemu/commit/db186a3f83454268c43fc793a48bc28c41368a6c.patch | patch linux-user/signal.c

# Build qemu-*-static binaries for arm and aarch64
# - resulting binaries are located in "/usr/local/bin/qemu-*"
ARG TARGET_ARCH=arm-linux-user,aarch64-linux-user
RUN mkdir build \
 && cd build \
 && ../configure --static --target-list=$TARGET_ARCH  \
 && make -j 8 install
