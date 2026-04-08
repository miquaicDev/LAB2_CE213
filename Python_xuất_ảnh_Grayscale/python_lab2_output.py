import cv2
import numpy as np

def txt_to_image(input_txt, output_jpg, width=2048, height=1365):
    pixels = []

    with open(input_txt, 'r') as f:
        for line in f:
            line = line.strip()
            if not line:
                continue
            try:
                value = int(line, 16)
            except ValueError:
                continue
            pixels.append(value)

    pixels = np.array(pixels, dtype=np.uint8)

    if len(pixels) < width * height:
        pixels = np.pad(pixels, (0, width * height - len(pixels)), 'constant')

    pixels = pixels[:width * height]
    image = pixels.reshape((height, width))

    cv2.imwrite(output_jpg, image)

txt_to_image('output.txt', 'ketqua_cuoicung.jpg', 2048, 1365)