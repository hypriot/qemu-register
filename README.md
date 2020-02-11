# qemu-register

[![Build Status](https://circleci.com/gh/hypriot/qemu-register.svg?style=svg)](https://circleci.com/gh/hypriot/qemu-register)

qemu-register – is the docker-image providing `qemu-static` binaries for your cross-platform projects.

A simple way to register `qemu` usermode emulation binaries for your kernel:

```docker
FROM hypriot/qemu-register as qemu

# Fetching your base image (you can select another one)
FROM alpine

# Coping compiled binaries to your image
COPY --from=qemu /qemu-aarch64 /qemu-arm
COPY --from=qemu /qemu-aarch64 /qemu-aarch64
COPY --from=qemu /qemu-aarch64 /qemu-ppc64le
COPY --from=qemu /qemu-aarch64 /qemu-riscv64

# Coping & executing script for registering qemu in the kernel
COPY --from=qemu /register.sh /register.sh
RUN /register.sh --reset

# PUT HERE YOUR INSTRUCTIONS!!!

```

## How this works

Starting with the Linux kernel 4.8, there's a mechanism in the kernel to load the interpreter specified in your `binfmt_misc` ahead of time (and make sure it stays in memory even if the interpreter file is deleted or moved). This is described in better detail in [this blog post by npmccallum](https://npmccallum.gitlab.io/post/foreign-architecture-docker/), [nmpccallum`s github](https://github.com/npmccallum/qemu-register) and in the [kernel binfmt_misc docs](https://www.kernel.org/doc/Documentation/admin-guide/binfmt-misc.rst).

### Build Docker image

If you wanna build your own qemu-register using next instruction:

```bash
git clone https://github.com/hypriot/qemu-register.git
cd qemu-register
docker build -t hypriot/qemu-register:local .
```

### Check Qemu binaries and versions

```bash
$ docker run --rm hypriot/qemu-register sh -c 'ls -al /qemu*'
-rwxr-xr-x    1 root     root       6192520 Apr 27 11:25 /qemu-aarch64
-rwxr-xr-x    1 root     root       5606984 Apr 27 11:25 /qemu-arm
-rwxr-xr-x    1 root     root       5987464 Apr 27 11:25 /qemu-ppc64le

$ docker run --rm hypriot/qemu-register /qemu-arm --version
qemu-arm version 4.2.0
Copyright (c) 2003-2019 Fabrice Bellard and the QEMU Project developers

$ docker run --rm hypriot/qemu-register /qemu-aarch64 --version
qemu-aarch64 version 4.2.0
Copyright (c) 2003-2019 Fabrice Bellard and the QEMU Project developers

$ docker run --rm hypriot/qemu-register /qemu-ppc64le --version
qemu-ppc64le version 4.2.0
Copyright (c) 2003-2019 Fabrice Bellard and the QEMU Project developers

$ docker run --rm hypriot/qemu-register /qemu-riscv64 --version
qemu-riscv64 version 4.2.0
Copyright (c) 2003-2019 Fabrice Bellard and the QEMU Project developers
```

### Run the resulting Docker image to register the Qemu interpreters

```
docker run --rm --privileged hypriot/qemu-register
```

### Buy us a beer!

This FLOSS software is funded by donations only. Please support us to maintain and further improve it!

<a href="https://liberapay.com/Hypriot/donate"><img alt="Donate using Liberapay" src="https://liberapay.com/assets/widgets/donate.svg"></a>
