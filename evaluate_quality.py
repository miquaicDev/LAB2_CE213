import cv2
import numpy as np
from skimage.metrics import structural_similarity as ssim
from skimage.metrics import peak_signal_noise_ratio as psnr

def calculate_metrics(original_path, reconstructed_path):
    """
    Đọc hai ảnh và tính toán PSNR và SSIM.
    """
    # 1. Đọc ảnh gốc và ảnh đã tái tạo dưới dạng ảnh xám
    img_original = cv2.imread(original_path, cv2.IMREAD_GRAYSCALE)
    img_reconstructed = cv2.imread(reconstructed_path, cv2.IMREAD_GRAYSCALE)

    if img_original is None:
        print(f"Lỗi: Không thể đọc ảnh gốc tại '{original_path}'")
        return
    if img_reconstructed is None:
        print(f"Lỗi: Không thể đọc ảnh tái tạo tại '{reconstructed_path}'")
        return

    # 2. Đảm bảo hai ảnh có cùng kích thước
    if img_original.shape != img_reconstructed.shape:
        print("Lỗi: Hai ảnh phải có cùng kích thước.")
        # Tùy chọn: Thay đổi kích thước ảnh tái tạo cho khớp với ảnh gốc
        # height, width = img_original.shape
        # img_reconstructed = cv2.resize(img_reconstructed, (width, height))
        # print("Đã resize ảnh tái tạo để khớp với ảnh gốc.")
        return

    # 3. Tính toán PSNR
    # data_range là giá trị pixel tối đa (255 cho ảnh 8-bit)
    psnr_value = psnr(img_original, img_reconstructed, data_range=255)

    # 4. Tính toán SSIM
    # data_range tương tự như trên
    ssim_value, _ = ssim(img_original, img_reconstructed, data_range=255, full=True)

    # 5. In kết quả
    print("--- Kết quả đánh giá chất lượng ảnh ---")
    print(f"Ảnh gốc:        {original_path}")
    print(f"Ảnh tái tạo:     {reconstructed_path}")
    print("-----------------------------------------")
    print(f"PSNR: {psnr_value:.2f} dB")
    print(f"SSIM: {ssim_value:.4f}")
    print("-----------------------------------------")
    print("Ghi chú:")
    print("- PSNR càng cao càng tốt (thường > 30 dB là tốt).")
    print("- SSIM càng gần 1 càng tốt.")


if __name__ == "__main__":
    # --- THAY ĐỔI TÊN FILE TẠI ĐÂY ---
    original_image_file = 'baitap1_anhgoc.jpg'  # Ảnh gốc có nhiễu
    reconstructed_image_file = 'output.png'     # Ảnh đã qua bộ lọc trung vị
    # ---------------------------------

    calculate_metrics(original_image_file, reconstructed_image_file)
