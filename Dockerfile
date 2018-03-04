FROM busybox
ADD register.sh /register.sh
ADD bins/qemu-arm /qemu-arm
ADD bins/qemu-aarch64 /qemu-aarch64
ADD bins/qemu-ppc64le /qemu-ppc64le
CMD ["/register.sh", "--reset"]
