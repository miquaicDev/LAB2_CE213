import cv2
import numpy as np

# 1. Đọc ảnh vào dưới dạng Grayscale (ảnh xám)
# cv2.IMREAD_GRAYSCALE đảm bảo ảnh chỉ có 1 kênh màu (0-255)
img = cv2.imread('baitap1_anhgoc.jpg', cv2.IMREAD_GRAYSCALE)

if img is None:
    print("Không tìm thấy file ảnh!")
else:
    # 2. Lấy kích thước ảnh (Chiều cao - rows, Chiều rộng - cols)
    rows, cols = img.shape
    
    # 3. Mở file text để ghi
    with open('pic_input.txt', 'w') as f:
        # 4. Quét qua từng hàng, từng cột pixel
        for i in range(rows):
            for j in range(cols):
                # Lấy giá trị pixel tại tọa độ (i, j)
                pixel_value = img[i, j]
                
                # Chuyển giá trị hệ thập phân (0-255) sang dạng Hexa (00-FF)
                # {:02X} đảm bảo luôn có 2 chữ số, ví dụ 10 -> 0A
                hex_value = "{:02X}".format(pixel_value)
                
                # Ghi vào file text, mỗi giá trị một dòng
                f.write(hex_value + '\n')
                
    print(f"Đã chuyển đổi xong ảnh {cols}x{rows} thành file pic_input.txt")
