[![Build Status](https://travis-ci.org/hypriot/qemu-register.svg?branch=master)](https://travis-ci.org/hypriot/qemu-register)

### Build Docker image
```
./build.sh
```


### Check Qemu binaries and versions
```
docker run --rm hypriot/qemu-register sh -c 'ls -al /qemu*'
-rwxr-xr-x    1 root     root       6192520 Apr 27 11:25 /qemu-aarch64
-rwxr-xr-x    1 root     root       5606984 Apr 27 11:25 /qemu-arm
-rwxr-xr-x    1 root     root       5987464 Apr 27 11:25 /qemu-ppc64le

docker run --rm hypriot/qemu-register /qemu-arm --version
qemu-arm version 4.2.0
Copyright (c) 2003-2019 Fabrice Bellard and the QEMU Project developers

docker run --rm hypriot/qemu-register /qemu-aarch64 --version
qemu-aarch64 version 4.2.0
Copyright (c) 2003-2019 Fabrice Bellard and the QEMU Project developers

docker run --rm hypriot/qemu-register /qemu-ppc64le --version
qemu-ppc64le version 4.2.0
Copyright (c) 2003-2019 Fabrice Bellard and the QEMU Project developers

docker run --rm hypriot/qemu-register /qemu-riscv64 --version
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
