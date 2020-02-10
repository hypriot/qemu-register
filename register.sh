#!/bin/sh
set -e

# Mount if neccessary
if [ ! -d /proc/sys/fs/binfmt_misc ]; then
	echo "No binfmt support in the kernel."
	echo "  Try: '/sbin/modprobe binfmt_misc' from the host"
	exit 1
fi
if [ ! -f /proc/sys/fs/binfmt_misc/register ]; then
	mount binfmt_misc -t binfmt_misc /proc/sys/fs/binfmt_misc
fi

# Reset all pre-registered interpreters, if requested
if [ "$1" = "--reset" ]; then
	(
	cd /proc/sys/fs/binfmt_misc
	for file in *; do
		case "${file}" in
		status|register)
			;;
		*)
			echo -1 > "${file}"
			;;
		esac
	done
    )
fi

# Register new interpreters
# - important: using flags 'C' and 'F'
echo ':qemu-arm:M::\x7fELF\x01\x01\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x02\x00\x28\x00:\xff\xff\xff\xff\xff\xff\xff\x00\xff\xff\xff\xff\xff\xff\xff\xff\xfe\xff\xff\xff:/qemu-arm:CF' > /proc/sys/fs/binfmt_misc/register
echo ':qemu-aarch64:M::\x7fELF\x02\x01\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x02\x00\xb7\x00:\xff\xff\xff\xff\xff\xff\xff\x00\xff\xff\xff\xff\xff\xff\xff\xff\xfe\xff\xff\xff:/qemu-aarch64:CF' > /proc/sys/fs/binfmt_misc/register
echo ':qemu-ppc64le:M::\x7fELF\x02\x01\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x02\x00\x15\x00:\xff\xff\xff\xff\xff\xff\xff\x00\xff\xff\xff\xff\xff\xff\xff\xff\xfe\xff\xff\x00:/qemu-ppc64le:CF' > /proc/sys/fs/binfmt_misc/register
echo ':qemu-riscv64:M::\x7f\x45\x4c\x46\x02\x01\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x02\x00\xf3\x00:\xff\xff\xff\xff\xff\xff\xff\x00\xff\xff\xff\xff\xff\xff\xff\xff\xfe\xff\xff\xff:/qemu-riscv64:CF' > /proc/sys/fs/binfmt_misc/register

# Show results
echo "---"
echo "Installed interpreter binaries:"
ls -al /qemu-*
echo "---"
cd /proc/sys/fs/binfmt_misc
for file in *; do
    case "${file}" in
	status|register)
		;;
	*)
		echo "Registered interpreter=${file}"
		cat ${file}
		echo "---"
		;;
    esac
done
