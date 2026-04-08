import cv2

def prepare_input_pixels(image_path, output_txt):
    img = cv2.imread(image_path)
    img = cv2.cvtColor(img, cv2.COLOR_BGR2RGB)
    img = cv2.resize(img, (2048, 1365))

    with open(output_txt, 'w') as f:
        for row in img:
            for p in row:
                pixel_hex = f"{p[0]:02X}{p[1]:02X}{p[2]:02X}"
                f.write(pixel_hex + "\n")

prepare_input_pixels('baitap2_anhgoc.jpg', 'input.txt')