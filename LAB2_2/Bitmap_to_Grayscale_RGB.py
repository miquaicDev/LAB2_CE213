from PIL import Image

def hex_to_rgb_image(hex_path, output_image_path, size):
    width, height = size
    img = Image.new('RGB', (width, height))
    pixels = img.load()

    try:
        with open(hex_path, 'r') as f:
            lines = f.readlines()
        
        if len(lines) < width * height:
            print("Cảnh báo: Dữ liệu trong file hex ít hơn kích thước ảnh. Một phần ảnh sẽ bị đen!")

        line_idx = 0
        # ĐIỂM THAY ĐỔI: Ráp lại theo chiều dọc (cột x) trước
        for x in range(width):
            for y in range(height):
                if line_idx < len(lines):
                    hex_str = lines[line_idx].strip() 
                    
                    if len(hex_str) >= 6:
                        r = int(hex_str[0:2], 16)
                        g = int(hex_str[2:4], 16)
                        b = int(hex_str[4:6], 16)
                        pixels[x, y] = (r, g, b)
                    line_idx += 1
                    
        img.save(output_image_path)
        print(f"[RGB] Thành công! Đã dựng lại ảnh {width}x{height} và lưu tại: {output_image_path}")

    except Exception as e:
        print(f"[RGB] Lỗi: {e}")


def hex_to_grayscale_image(hex_path, output_image_path, size):
    width, height = size
    img = Image.new('L', (width, height))
    pixels = img.load()

    try:
        with open(hex_path, 'r') as f:
            lines = f.readlines()

        line_idx = 0
        # ĐIỂM THAY ĐỔI: Ráp lại theo chiều dọc (cột x) trước
        for x in range(width):
            for y in range(height):
                if line_idx < len(lines):
                    hex_str = lines[line_idx].strip()
                    
                    if len(hex_str) >= 2:
                        gray_val = int(hex_str[0:2], 16)
                        pixels[x, y] = gray_val
                    line_idx += 1
                    
        img.save(output_image_path)
        print(f"[GRAY] Thành công! Đã dựng lại ảnh Grayscale và lưu tại: {output_image_path}")

    except Exception as e:
        print(f"[GRAY] Lỗi: {e}")

# --- Chạy thực thi ---
IMAGE_SIZE = (2048, 1365) 

# Lưu ý nhỏ: Bạn kiểm tra lại tên file đầu vào nhé. 
# Ở Testbench Verilog, output của bạn xuất ra file "bitmap_output.hex" là dạng 8-bit (Grayscale).
# Nếu bạn đưa nó vào hàm RGB (24-bit) nó sẽ báo lỗi chuỗi Hex không đủ dài.

# Test dựng lại ảnh RGB gốc từ dữ liệu Python vừa tạo:
#hex_to_rgb_image("image_data.hex", "reconstructed_rgb.jpg", IMAGE_SIZE)

# Test dựng lại ảnh Grayscale từ dữ liệu Verilog xuất ra:
hex_to_grayscale_image("bitmap_output.hex", "result_grayscale.jpg", IMAGE_SIZE)