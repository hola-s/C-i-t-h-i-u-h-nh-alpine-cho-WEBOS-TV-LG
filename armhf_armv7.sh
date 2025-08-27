#!/bin/sh

# Config
CHROOT_DIR="/tmp/alpine-armhf"
ALPINE_BASE_URL="https://dl-cdn.alpinelinux.org/alpine/latest-stable/releases/armhf"

# Lấy tên file mới nhất cho armhf (ARMv7)
echo "Fetching latest Alpine version for ARMv7 (armhf)..."
ALPINE_TAR=$(wget -qO- "$ALPINE_BASE_URL/" | grep -o 'alpine-minirootfs-[0-9.]\+-armhf\.tar\.gz' | sort -V | tail -n 1)

if [ -z "$ALPINE_TAR" ]; then
    echo "Error: Cannot fetch latest Alpine version for armhf."
    exit 1
fi

ALPINE_URL="$ALPINE_BASE_URL/$ALPINE_TAR"
echo "Latest Alpine image detected: $ALPINE_TAR"

# Tạo thư mục chứa Alpine nếu chưa có
if [ ! -d "$CHROOT_DIR" ]; then
    echo "Creating directory $CHROOT_DIR..."
    mkdir -p "$CHROOT_DIR"
fi

# Tải Alpine nếu chưa có
if [ ! -f "$CHROOT_DIR/$ALPINE_TAR" ]; then
    echo "Downloading Alpine Linux (armhf)..."
    wget -O "$CHROOT_DIR/$ALPINE_TAR" "$ALPINE_URL"
    if [ $? -ne 0 ]; then
        echo "Error: Cannot download Alpine (check URL or internet)"
        exit 1
    fi
fi

# Giải nén Alpine nếu chưa giải nén
if [ ! -d "$CHROOT_DIR/bin" ]; then
    echo "Extracting Alpine Linux..."
    tar -xzf "$CHROOT_DIR/$ALPINE_TAR" -C "$CHROOT_DIR" || {
        echo "Error: Failed to extract Alpine"
        exit 1
    }
    echo "Removing tar file..."
    rm -f "$CHROOT_DIR/$ALPINE_TAR"
fi

# Tạo mount point
mkdir -p "$CHROOT_DIR/proc" "$CHROOT_DIR/sys" "$CHROOT_DIR/dev"

# Mount file system
echo "Mounting filesystems..."
mount -t proc /proc "$CHROOT_DIR/proc"
mount --rbind /sys "$CHROOT_DIR/sys"
mount --rbind /dev "$CHROOT_DIR/dev"

# Kiểm tra chroot có tồn tại không
if command -v chroot >/dev/null 2>&1; then
    echo "Entering chroot..."
    exec chroot "$CHROOT_DIR" /bin/sh
else
    echo "chroot not found, using proot fallback..."
    if [ ! -f "./proot" ]; then
        echo "Downloading proot..."
        wget https://github.com/proot-me/proot/releases/latest/download/proot -O ./proot
        chmod +x ./proot
    fi
    exec ./proot -R "$CHROOT_DIR" /bin/sh
fi
