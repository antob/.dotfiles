#!/bin/bash

echo "Unmounting encrypted volume..."
sudo umount /mnt/encrypted

echo "Closing encrypted volume..."
sudo cryptsetup close /dev/mapper/encrypted

echo "Unmounting image file..."
sudo losetup -D

