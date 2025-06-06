#!/bin/sh
Setting the chroot directory
CHROOT_DIR="/tmp/alpine"
ALPINE_TAR="alpine-minirootfs-3.21.3-armhf.tar.gz"
ALPINE_URL="https://dl-cdn.alpinelinux.org/alpine/latest-stable/releases/armhf/$ALPINE_TAR"
Check if the chroot folder exists, if not, create it
if [ ! -d "$CHROOT_DIR" ]; then
    echo "Creating directory $CHROOT_DIR..."
    mkdir -p "$CHROOT_DIR"
fi
Download Alpine if the file does not exist
if [ ! -f "$CHROOT_DIR/$ALPINE_TAR" ]; then
    echo "Downloading Alpine Linux..."
    wget -O "$CHROOT_DIR/$ALPINE_TAR" "$ALPINE_URL"
fi
extract Alpine if it is not already extracted
if [ ! -d "$CHROOT_DIR/bin" ]; then
    echo "Extracting Alpine Linux..."
    tar -xzf "$CHROOT_DIR/$ALPINE_TAR" -C "$CHROOT_DIR"
    Remove tar file after extraction
    echo "Removing file $ALPINE_TAR..."
    rm -f "$CHROOT_DIR/$ALPINE_TAR"
  
fi
Mount the necessary file systems
echo "Mounting filesystems..."
mount -t proc /proc "$CHROOT_DIR/proc"
mount --rbind /sys "$CHROOT_DIR/sys"
mount --rbind /dev "$CHROOT_DIR/dev"
Enter chroot
echo "Entering chroot..."
exec chroot "$CHROOT_DIR" /bin/sh
