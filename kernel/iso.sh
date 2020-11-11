#!/bin/sh
set -e
 
mkdir -p isodir
mkdir -p isodir/boot
mkdir -p isodir/boot/grub
 
cp myos.kernel isodir/boot/myos.kernel
cat > isodir/boot/grub/grub.cfg << EOF
menuentry "myos" {
	multiboot /boot/myos.kernel
}
EOF
grub2-mkrescue -o myos.iso isodir