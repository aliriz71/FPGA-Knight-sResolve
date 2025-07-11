# FPGA Game - Knight's Resolve
Wifi Access Point on Raspberry Pi Pico 2W to encrypt a 10 digit phone number with AES-128 on the DE10-lite board via SPI connection. 
Consider the attatched [report](https://github.com/aliriz71/FPGA-Knight-sResolve/blob/main/Knights-Resolve-Project-Description.pdf) for a 
deeper understanding of this project.
# To run this project
**For the DE10-Lite**
<pre>
Utilizing Quartus Prime 
Open a new project with Verilog settings
Make sure that under files Proj.sv and aes_128.sv are included in the Project.
vga_controller  needs to be set to Top-level entity.
If you want to use the hex files provided in the PixelArtHexFileCode folder, make sure to change the code in vga_controller.v at lines 388-415 to 
determine which directory you are using the load the hex files.

Consider the [DE10-lite manual](https://ftp.intel.com/Public/Pub/fpgaup/pub/Intel_Material/Boards/DE10-Lite/DE10_Lite_User_Manual.pdf) for the 
next steps of assiging the VGA pins.
After having compiled the design go through the following steps:
Menu -> Assignments, and then -> Pin Planner and ensure the assignments match up to the code.
Then click Program Device under task, and make sure you have selected USB-blaster before you click start.
</pre>

# To use the Python Script for your own images
<pre>
Ensure that the PNG is sized to the dimensions of 64x48 pixels.
I used pixelart.com to make the images and utilized the 4-bit VGA colour depth pallete to ensure a swift colour mapping process with the script.
</pre>
Find the SSID Pico2W and enter the password "password". 
Once connected, go into any browser and enter the IP in the URL, this will take you to the HTTP server hosted on the Pico.
 Enjoy! 

