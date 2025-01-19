from PIL import Image

# Color mapping based on the given 4-bit codes
color_map = {
    (0, 0, 0): 0x0,         # Black
    (0, 0, 255): 0x1,       # Blue
    (0, 255, 0): 0x2,       # Green
    (0, 255, 255): 0x3,     # Cyan
    (255, 0, 0): 0x4,       # Red
    (255, 0, 255): 0x5,     # Magenta
    (255, 255, 0): 0x6,     # Yellow
    (255, 255, 255): 0x7,   # White
    (128, 128, 128): 0x8,   # Gray
    (0, 0, 128): 0x9,       # Dark Blue
    (0, 128, 0): 0xA,       # Dark Green
    (0, 128, 128): 0xB,     # Dark Cyan
    (128, 0, 0): 0xC,       # Dark Red
    (128, 0, 128): 0xD,     # Dark Magenta
    (128, 128, 0): 0xE,     # Dark Yellow
    (192, 192, 192): 0xF    # Light Gray
}

# Open and resize the image to 64x48
img = Image.open("labyrinth.png").resize((64, 48)).convert("RGB")

# Prepare the .hex data
hex_data = []
pixels = list(img.getdata())  # Get RGB values of all pixels

for pixel in pixels:  # Process each pixel individually
    pixel_code = color_map.get(pixel, 0x0)  # Get 4-bit code for each pixel
    hex_data.append(f"{pixel_code:01X}")  # Format as a single hexadecimal character

# Write the .hex file
with open("labyrinth.hex", "w") as f:
    f.write("\n".join(hex_data))  # Write each pixel code on a new line

print("Conversion complete!. Output saved to titlepage-pixilart.hex")
