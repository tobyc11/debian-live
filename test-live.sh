#!/bin/bash

qemu-system-aarch64 \
    -M virt \
    -cpu cortex-a53 \
    -m 1024 \
    -kernel vmlinuz-6.1.0-25-arm64 \
    -initrd initrd.img-6.1.0-25-arm64 \
    -append "console=ttyAMA0 boot=live" \
    -nographic \
    -drive file=./disk_image.img,if=none,id=drive0,format=raw \
    -device virtio-blk-pci,drive=drive0
