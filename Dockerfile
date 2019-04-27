# Fetch base image
FROM debian:stretch as qemu

ENV QEMU_VERSION 4.0.0
# Install build dependencies
RUN apt-get update -qq && apt-get install -yqq \
    build-essential \
    ca-certificates \
    curl \
    xz-utils \
    git \
    libglib2.0-dev \
    libpixman-1-dev \
    pkg-config \
    python \
    --no-install-recommends

RUN curl "https://download.qemu.org/qemu-${QEMU_VERSION}.tar.xz" -o "qemu-${QEMU_VERSION}.tar.xz"
RUN mkdir qemu && tar xf "qemu-${QEMU_VERSION}.tar.xz" --strip-components=1 -C qemu
WORKDIR qemu

# Apply patch to fix issues with Go
# - patches the file "linux-user/signal.c"
RUN curl -sSL https://github.com/resin-io/qemu/commit/db186a3f83454268c43fc793a48bc28c41368a6c.patch | patch linux-user/signal.c

# Build qemu-*-static binaries for arm, aarch64, ppc64le
# - resulting binaries are located in "/usr/local/bin/qemu-*"
ARG TARGET_ARCH=arm-linux-user,aarch64-linux-user,ppc64le-linux-user
RUN mkdir build \
 && cd build \
 && ../configure --static --target-list=$TARGET_ARCH  \
 && make -j $(nproc) install

FROM busybox
COPY --from=qemu /usr/local/bin/qemu-arm /qemu-arm
COPY --from=qemu /usr/local/bin/qemu-aarch64 /qemu-aarch64
COPY --from=qemu /usr/local/bin/qemu-ppc64le /qemu-ppc64le
ADD register.sh /register.sh
CMD ["/register.sh", "--reset"]
