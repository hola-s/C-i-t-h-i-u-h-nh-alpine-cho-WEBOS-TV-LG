# Alpine Linux Chroot for LG webOS TV

Bộ script hỗ trợ cài đặt và chạy môi trường Alpine Linux trên LG TV đã root.  
Hỗ trợ đầy đủ các kiến trúc CPU phổ biến trên webOS.

---

## ⚖️ License

Tập lệnh này được phát hành dưới bản quyền MIT License.

---

## ⚠️ Lưu ý quan trọng (Đọc kỹ)

### 🔐 Root Access
Đảm bảo TV đã được root.  
Tham khảo hướng dẫn tại: https://webosbrew.org/rooting

### 🧠 Kiến trúc CPU
Kiểm tra bằng lệnh sau trên TV:
uname -m
Nếu hiện aarch64 → Sử dụng file aarch64.sh
Nếu hiện armv7l hoặc armhf → Sử dụng file armhf_armv7.sh
### 💾 Bộ nhớ USB (Pendrive)
Khuyến nghị:
Nên edit script để tải rootfs vào /tmp/usb
Tham khảo: https://rootmy.tv/warning⁠
🛠 Hướng dẫn cài đặt
🚀 Cài đặt nhanh (Quick Install)
Mở Terminal (SSH) trên TV và chạy lệnh tương ứng:
👉 Đối với kiến trúc aarch64
``` Bash
curl -L -o /tmp/aarch64.sh "https://raw.githubusercontent.com/hola-s/C-i-t-h-i-u-h-nh-alpine-cho-WEBOS-TV-LG/main/aarch64.sh" && sh /tmp/aarch64.sh

👉 Đối với kiến trúc armhf / armv7
``` Bash
curl -L -o /tmp/armhf_armv7.sh "https://raw.githubusercontent.com/hola-s/C-i-t-h-i-u-h-nh-alpine-cho-WEBOS-TV-LG/main/armhf_armv7.sh" && sh /tmp/armhf_armv7.sh

🙂 Ghi chú
Đảm bảo kết nối mạng ổn định khi chạy script
Nên backup trước khi thực hiện
### :)
