#!/bin/bash

set -x

# Set variables
IMAGE_SIZE="1024M"  # Size of the raw disk image
IMAGE_NAME="disk_image.img"
ESP_SIZE="100M"     # Size of the EFI System Partition

# Create a raw disk image
echo "Creating a raw disk image of size ${IMAGE_SIZE}..."
dd if=/dev/zero of=${IMAGE_NAME} bs=1 count=0 seek=${IMAGE_SIZE}

# Create the GPT partition table
echo "Creating GPT partition table..."
parted ${IMAGE_NAME} mklabel gpt

# Create the ESP partition
echo "Creating ESP partition of size ${ESP_SIZE}..."
parted ${IMAGE_NAME} mkpart ESP fat32 1MiB ${ESP_SIZE}

# Create the live partition
echo "Creating live partition..."
parted ${IMAGE_NAME} mkpart live ext4 ${ESP_SIZE} "100%"

# Get loop device
LOOP_DEVICE=$(losetup -f --show ${IMAGE_NAME})
partprobe ${LOOP_DEVICE}

ls /dev/loop*

# Create file systems
echo "Creating file system on ESP..."
mkfs.fat -F32 ${LOOP_DEVICE}p1

echo "Creating file system on live partition..."
dd if=${1} of=${LOOP_DEVICE}p2 bs=1M

# Detach loop device
losetup -d ${LOOP_DEVICE}

echo "Raw disk image created: ${IMAGE_NAME}"

