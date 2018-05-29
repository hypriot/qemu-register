# qemu-register
[![Build Status](https://travis-ci.org/hypriot/qemu-register.svg?branch=master)](https://travis-ci.org/hypriot/qemu-register)

### Build Qemu binaries and Docker image
```
./build.sh
```
```
ls -al bins/qemu-*
-rwxr-xr-x  1 dieter  staff  3287144 Dec  3 19:12 bins/qemu-aarch64
-rwxr-xr-x  1 dieter  staff  3208360 Dec  3 19:12 bins/qemu-arm

docker images | grep qemu-register
hypriot/qemu-register   latest                        32118e70108b        3 minutes ago       7.59 MB
```


### Check Qemu binaries and versions
```
docker run --rm hypriot/qemu-register sh -c 'ls -al /qemu*'
-rwxr-xr-x    1 root     root       3287144 Dec  3 18:12 /qemu-aarch64
-rwxr-xr-x    1 root     root       3208360 Dec  3 18:12 /qemu-arm

docker run --rm hypriot/qemu-register /qemu-arm --version
qemu-arm version 2.7.0, Copyright (c) 2003-2016 Fabrice Bellard and the QEMU Project developers

docker run --rm hypriot/qemu-register /qemu-aarch64 --version
qemu-aarch64 version 2.7.0, Copyright (c) 2003-2016 Fabrice Bellard and the QEMU Project developers
```


### Run the resulting Docker image to register the Qemu interpreters
```
docker run --rm --privileged hypriot/qemu-register
```


### Buy us a beer!

This FLOSS software is funded by donations only. Please support us to maintain and further improve it!

<a href="https://liberapay.com/Hypriot/donate"><img alt="Donate using Liberapay" src="https://liberapay.com/assets/widgets/donate.svg"></a>
