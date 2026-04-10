from PIL import Image

def rgb_to_hex_file(image_path, hex_path, target_size=(128, 128)):
    try:
        # Mở ảnh và ép kiểu về RGB
        img = Image.open(image_path).convert('RGB')
        
        # Resize ảnh
        img = img.resize(target_size)
        width, height = img.size
        
        # Mở file hex để ghi dữ liệu
        with open(hex_path, 'w') as f:
            # ĐIỂM THAY ĐỔI: Chạy vòng lặp x (cột) bên ngoài, y (hàng) bên trong
            for x in range(width):
                for y in range(height):
                    # Lấy giá trị pixel
                    r, g, b = img.getpixel((x, y))
                    
                    # Ghi định dạng Hex
                    hex_string = f"{r:02X}{g:02X}{b:02X}\n"
                    f.write(hex_string)
                    
        print(f"Thành công! Đã chuyển đổi ảnh {width}x{height} ({width*height} pixels).")
        print(f"Dữ liệu được sắp xếp theo CỘT và lưu tại: {hex_path}")
        
    except Exception as e:
        print(f"Đã xảy ra lỗi: {e}")

# --- Chạy thực thi ---
rgb_to_hex_file("baitap2_anhgoc.jpg", "image_data.hex", target_size=(2048, 1365))