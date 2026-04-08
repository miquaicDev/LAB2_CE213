import cv2
import numpy as np

# 1. Đọc file txt (hex, mỗi dòng 1 pixel)
data = []

with open('pic_output.txt', 'r') as f:
    for line in f:
        line = line.strip()
        if line:  # bỏ dòng rỗng
            # chuyển hex -> int
            pixel = int(line, 16)
            data.append(pixel)

# 2. Kiểm tra dữ liệu
if len(data) == 0:
    print("File rỗng hoặc sai format!")
else:
    # ⚠️ PHẢI biết kích thước ảnh
    # 👉 sửa tay hoặc truyền từ file nếu có
    rows = 554   # chỉnh lại cho đúng
    cols = 430   # chỉnh lại cho đúng

    if len(data) != rows * cols:
        print("Sai kích thước ảnh! Số pixel không khớp.")
    else:
        # 3. reshape về ảnh 2D
        img = np.array(data, dtype=np.uint8).reshape((rows, cols))

        # 4. lưu ảnh
        cv2.imwrite('output.png', img)

        print(f"Đã khôi phục ảnh {cols}x{rows} thành công!")
