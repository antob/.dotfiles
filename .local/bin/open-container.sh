#!/bin/bash

FILENAME="private.img"
FILESIZE="100M"

# Create encrypted volume if it doesn't exist
if [ ! -f $FILENAME ]; then

    echo "Creating image file..."
    dd if=/dev/urandom of=$FILENAME bs=$FILESIZE count=1 iflag=fullblock

    echo "Setting permissions..."
    chmod 600 $FILENAME;

    echo "Mounting image file..."
    sudo losetup -D
    sudo losetup /dev/loop0 $FILENAME

    echo "Encrypting image file..."
    sudo cryptsetup -q -y luksFormat /dev/loop0

    echo "Opening encrypted volume..."
    sudo cryptsetup open /dev/loop0 encrypted

    echo "Formatting encrypted volume..."
    sudo mkfs.ext4 -L "encrypted" /dev/mapper/encrypted

    echo "Closing encrypted volume..."
    sudo cryptsetup close /dev/mapper/encrypted
    sudo losetup -D

fi

echo "Mounting image file..."
sudo losetup -D
sudo losetup /dev/loop0 $FILENAME

echo "Decrypting image file..."
sudo cryptsetup open /dev/loop0 encrypted

echo "Mounting encrypted volume..."
sudo mount /dev/mapper/encrypted -o rw,x-mount.mkdir /mnt/encrypted

