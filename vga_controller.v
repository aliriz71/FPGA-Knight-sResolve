/*
* Lab 4 ClockDivider module
*/
module ClockDivider (clk, clkOut);
	input clk; 
	output reg clkOut;
	
	//32-bit counter register as standard (powers of 2). 32'd0 == 32 bit, decimal, value = 0 
	reg[31:0] counter = 32'd0; 	
	parameter DIVIDER = 3000000; //use a slow clock to prevent multiple presses on the buttons
	
	always @(posedge clk)
	begin 
		
		if (counter == DIVIDER)
			begin
				counter <= 32'd0;		//reset counter, it has reached target 
			
				clkOut <= ~clkOut; 	//flip clkOut
			
			end
		else 								//incrementing counter on posedge of system clk
			begin
				
				counter <= counter + 32'd1;
				
			end
	end
endmodule


module state_machine_controller(input clkOut, input button_a, input button_b, output [4:0] out);    
    // State counter: start at state 0
    reg [4:0] presState;        
    reg [4:0] nextState;        // Next state
    //wire slowclk;
    reg [4:0] outval;           // State output
    
	
	
    // Define states
    parameter [4:0] 
			//Story States
			TITLE = 5'b00000,        // state 0
			CASTLE_EXIT = 5'b00001,  // state 1
			VILLAGE_PLAZA = 5'b00010, // state 2
			ELDER = 5'b00011,         // state 3
			SUSPICIOUS = 5'b00100,    // state 4
			FORKINROAD = 5'b00101,
			RIDDLE1 = 5'b00110,
			RIDDLE2 = 5'b00111,
			RIDDLE3 = 5'b01000,
			CAPE = 	 5'b01001,
			SAGEEND = 5'b01010,
			LABYRINTH = 5'b01011,
			//Maze States 			
			MSTART = 5'b01100,			
			M14 = 5'b01101,
			M15 = 5'b01110,
			M16 = 5'b01111,
			M17 = 5'b10000,
			M18 = 5'b10001,
			M19 = 5'b10010,
			M20 = 5'b10011,
			M21 = 5'b10100,
			M22 = 5'b10101,
			M23 = 5'b10110,
			M24 = 5'b10111,
			M25 = 5'b11000,
			M26 = 5'b11001,
			M27 = 5'b11010,
			M28 = 5'b11011,
			ARMOUR = 5'b11100,
			ARMOUREND = 5'b11101,
			//Maze outputs
			STARTPIC = 5'b01100,
			MSTRAIGHT = 5'b01101,
			MLEFT = 5'b01110,
			MRIGHT =5'b01111,
			MDOOR = 5'b10000,
			MPAINTRIGHT = 5'b10001,
			MBLOCK = 5'b10010,
			MPAINTLEFT = 5'b10011;								
	//initial state declaration
	initial 
	begin
		presState = TITLE;  // Set initial state to TITLE
   end

    // State transition logic based on detected button presses
    always @(posedge clkOut or negedge button_a or negedge button_b) begin
        case (presState)
				
            TITLE: 
                if (~button_a) nextState = CASTLE_EXIT;  // Button A pressed, transition to CASTLE_EXIT
                else if (~button_b) nextState = CASTLE_EXIT; // Button B pressed, transition to CASTLE_EXIT
                else nextState = TITLE;
            
            CASTLE_EXIT: 
                if (~button_a) nextState = VILLAGE_PLAZA;  // Button A pressed, transition to VILLAGE_PLAZA
                else if (~button_b) nextState = VILLAGE_PLAZA; // Button B pressed, transition to VILLAGE_PLAZA
                else nextState = CASTLE_EXIT;
            
            VILLAGE_PLAZA: 
                if (~button_a) nextState = SUSPICIOUS;  // Button A pressed, transition to SUSPICIOUS
                else if (~button_b) nextState = ELDER;  // Button B pressed, transition to ELDER
                else nextState = VILLAGE_PLAZA;
            
            ELDER: 
                if (~button_a) nextState = FORKINROAD;  
                else if (~button_b) nextState = VILLAGE_PLAZA; 
                else nextState = ELDER;
            
            SUSPICIOUS:  
                if (~button_a) nextState = FORKINROAD;  
                else if (~button_b) nextState = VILLAGE_PLAZA; 
                else nextState = SUSPICIOUS;
				FORKINROAD:
					if (~button_a) nextState = LABYRINTH;  
                else if (~button_b) nextState = RIDDLE1; 
                else nextState = FORKINROAD;
            RIDDLE1:
					if (~button_a) nextState = RIDDLE2;  
                else if (~button_b) nextState = FORKINROAD; 
                else nextState = RIDDLE1;
				RIDDLE2:
					if (~button_a) nextState = FORKINROAD;  
                else if (~button_b) nextState = RIDDLE3; 
                else nextState = RIDDLE2;
				RIDDLE3:
					if (~button_a) nextState = CAPE;  
                else if (~button_b) nextState = FORKINROAD; 
                else nextState = RIDDLE3;
				CAPE:
					if (~button_a) nextState = SAGEEND;  
                else if (~button_b) nextState = SAGEEND; 
                else nextState = CAPE;
				SAGEEND:
					if (~button_a) nextState = TITLE;  
                else if (~button_b) nextState = TITLE; 
                else nextState = SAGEEND;
					 
				LABYRINTH:
					if (~button_a) nextState = MSTART;  
                else if (~button_b) nextState = FORKINROAD; 
                else nextState = LABYRINTH;
				
				//Maze Logic
				MSTART:  
                if (~button_a) nextState = M25;  
                else if (~button_b) nextState = M14; 
                else nextState = MSTART;
				M14: 
					if (~button_a) nextState = M15;  
                else if (~button_b) nextState = M24; 
                else nextState = M14;
				M15:
					if (~button_a) nextState = M16;  
                else if (~button_b) nextState = M23; 
                else nextState = M15;
				M16:
					if (~button_a) nextState = M17;  
                else if (~button_b) nextState = M22; 
                else nextState = M16;
				M17:
					if (~button_a) nextState = M18;  
                else if (~button_b) nextState = M21; 
                else nextState = M17;
				M18:
					if (~button_a) nextState = M19;  
                else if (~button_b) nextState = M20; 
                else nextState = M18;
				M19:
					if (~button_a) nextState = ARMOUR;  			//////////////////////////TEMPORARY, NEED TO LINK TO ARMOUR SEQUENCE AFTER
                else if (~button_b) nextState = M20; 
                else nextState = M19;
				M20:
					if (~button_a) nextState = M21;  
                else if (~button_b) nextState = M18; 
                else nextState = M20;
				M21:
					if (~button_a) nextState = M22;  
                else if (~button_b) nextState = M17; 
                else nextState = M21;
				M22:
					if (~button_a) nextState = M23;  
                else if (~button_b) nextState = M16; 
                else nextState = M22;
				M23:
					if (~button_a) nextState = M24;  
                else if (~button_b) nextState = M15; 
                else nextState = M23;
				M24:
					if (~button_a) nextState = M25;  
                else if (~button_b) nextState = MSTART; 
                else nextState = M24;
				M25:
					if (~button_a) nextState = M26;  
                else if (~button_b) nextState = M28; 
                else nextState = M25;
				M26:
					if (~button_a) nextState = M27;  
                else if (~button_b) nextState = M27; 
                else nextState = M26;
				M27:
					if (~button_a) nextState = M28;  
                else if (~button_b) nextState = M26; 
                else nextState = M27;
				M28:
					if (~button_a) nextState = M14;  
                else if (~button_b) nextState = MSTART; 
                else nextState = M28;
				ARMOUR:
					if (~button_a) nextState = ARMOUREND;  
                else if (~button_b) nextState = ARMOUREND; 
                else nextState = ARMOUR;
				ARMOUREND:
					if (~button_a) nextState = TITLE;  
                else if (~button_b) nextState = TITLE; 
                else nextState = ARMOUREND;
					 
            default: nextState = TITLE;  // Default to TITLE state
        endcase
    end

    // Update the state on the rising edge of the clock
    always @(posedge clkOut) begin
        presState <= nextState;
    end
    
    // Output logic based on the current state
    always @(presState) begin
        case (presState)
            TITLE : outval = 5'b00000;        // State 0
            CASTLE_EXIT : outval = 5'b00001;  // State 1
            VILLAGE_PLAZA : outval = 5'b00010; // State 2
            ELDER : outval = 5'b00011;         // State 3
            SUSPICIOUS : outval = 5'b00100;    // State 4
				FORKINROAD : outval = 5'b00101;
				RIDDLE1 : outval = 5'b00110;
				RIDDLE2 : outval = 5'b00111;
				RIDDLE3 : outval = 5'b01000;
				CAPE : outval = 5'b01001;
				SAGEEND : outval = 5'b01010;
				LABYRINTH : outval = 5'b01011;
				//Maze states 
				MSTART: outval =  STARTPIC;
				M14:outval =  MSTRAIGHT;
				M15:outval =  MLEFT;
				M16:outval =  MSTRAIGHT;
				M17:outval =  MRIGHT;
				M18:outval =  MSTRAIGHT;
				M19:outval =  MDOOR;
				M20:outval =  MLEFT;
				M21:outval =  MSTRAIGHT;
				M22:outval =  MRIGHT;
				M23:outval =  MSTRAIGHT;
				M24:outval =  MPAINTRIGHT;
				M25:outval =  MRIGHT;
				M26:outval =  MBLOCK;
				M27:outval =  MLEFT;
				M28:outval =  MPAINTLEFT;
				ARMOUR : outval = 5'b11100;
				ARMOUREND: outval = 5'b11101;
            default : outval = 5'bxxxxx;       // Don't care
        endcase
    end
    
    assign out = outval;

endmodule

//////////////////////////////////////////	
// controls the output of pixel information
//////////////////////////////////////////
//Modified from https://github.com/dominic-meads/Quartus-Projects/blob/main/VGA_face/smiley_test.v
module vga_controller(
    input clk,           // 50 MHz input clock
	 input button_a,	//button a 
	 input button_b,	//button b
    output o_hsync,      // horizontal sync
    output o_vsync,      // vertical sync
    output [3:0] o_red,  // red color output
    output [3:0] o_blue, // blue color output
    output [3:0] o_green // green color output
);
	//internal regs
    reg [9:0] counter_x = 0;  // horizontal counter
    reg [9:0] counter_y = 0;  // vertical counter
    reg [3:0] r_red = 0;
    reg [3:0] r_blue = 0;
    reg [3:0] r_green = 0;
    
   reg reset = 0;  // for PLL
	wire clkout;
	
	//Define Maze outputs
	parameter [4:0] 
		
		STARTPIC = 5'b01100,
		MSTRAIGHT = 5'b01101,
		MLEFT = 5'b01110,
		MRIGHT =5'b01111,
		MDOOR = 5'b10000,
		MPAINTRIGHT = 5'b10001,
		MBLOCK = 5'b10010,
		MPAINTLEFT = 5'b10011;
		
		

    // Clock divider 50 MHz to 25.175 MHz
    pllVGA pll(
        .areset(reset),   // Connect to your system reset
        .inclk0(clk),     // Connect to the 50 MHz system clock
        .c0(clkout),      // Output 25.175 MHz clock
        .locked()
    );

    // Horizontal counter
    always @(posedge clkout) begin 
        if (counter_x < 799)
            counter_x <= counter_x + 1;  // horizontal counter (800 total pixels)
        else
            counter_x <= 0;              
    end
    
    // Vertical counter
    always @(posedge clkout) begin 
        if (counter_x == 799) begin  // only counts up after horizontal finishes
            if (counter_y < 525)    // vertical counter (525 total pixels)
                counter_y <= counter_y + 1;
            else
                counter_y <= 0;             
        end
    end

    // HSync and VSync output assignments
    assign o_hsync = (counter_x >= 0 && counter_x < 96) ? 1 : 0;  // hsync high for 96 counts
    assign o_vsync = (counter_y >= 0 && counter_y < 2) ? 1 : 0;   // vsync high for 2 counts
	
	
		
	// Memory to store the image data (64x48 pixels = 3072 pixels)
	
	//Main story image data
	reg [3:0] titlepage [0:3071];
	reg [3:0] castleexit [0:3071];
	reg [3:0] plaza[0:3071];
	reg [3:0] elder[0:3071];
	reg [3:0] susman[0:3071];
	reg [3:0] forkinroad[0:3071];
	reg [3:0] riddle1[0:3071];
	reg [3:0] riddle2[0:3071];
	reg [3:0] riddle3[0:3071];
	reg [3:0] cape[0:3071];
	reg [3:0] sageend[0:3071];
	reg [3:0] labyrinth[0:3071];
	//continue after door state
	reg [3:0] ArmourEquip[0:3071];  
	reg [3:0] ArmourEnd[0:3071];
	//Maze image data 
	reg [3:0] MStart [0:3071];
	reg [3:0] MPaintLeft [0:3071];
	reg [3:0] MPaintRight [0:3071];
	reg [3:0] MRight [0:3071];
	reg [3:0] MLeft [0:3071];
	reg [3:0] MStraight [0:3071];
	reg [3:0] MBlock [0:3071];
	reg [3:0] MDoor [0:3071];
	
	wire [4:0] MachineOut;
	wire state_clock;
	
	ClockDivider slow_clock(
        .clk(clk),     // Connect to the 50 MHz system clock
        .clkOut(state_clock),      // Output state clock
    );
	//Get the state output
	state_machine_controller callState(
		.clkOut(state_clock),
		.button_a(button_a), 
		.button_b(button_b), 
		.out(MachineOut)
	);
	
	
	// Load the images data
	initial begin
		 //Main story images
		 $readmemh("C:/Users/flixa/Python/New folder/titlepage-pixilart.hex", titlepage);	//state 00000
		 $readmemh("C:/Users/flixa/Python/New folder/castleexit-pixilart.hex", castleexit);	//state 00001
 		 $readmemh("C:/Users/flixa/Python/New folder/plaza.hex", plaza);							//state 00010
		 $readmemh("C:/Users/flixa/Python/New folder/elder.hex", elder);							//state 00011
		 $readmemh("C:/Users/flixa/Python/New folder/suspicious.hex", susman);					//state 00100
		 $readmemh("C:/Users/flixa/Python/New folder/forkinroad.hex", forkinroad);				//state 00101
		 $readmemh("C:/Users/flixa/Python/New folder/sagepixil-frame-4.hex", riddle1);		//state 00110
		 $readmemh("C:/Users/flixa/Python/New folder/sagepixil-frame-5.hex", riddle2);		//state 00111
		 $readmemh("C:/Users/flixa/Python/New folder/sagepixil-frame-6.hex", riddle3);		//state 01000
		 $readmemh("C:/Users/flixa/Python/New folder/cape.hex", cape);								//state 01001
		 $readmemh("C:/Users/flixa/Python/New folder/sageend.hex", sageend);						//state 01010
		 $readmemh("C:/Users/flixa/Python/New folder/labyrinth.hex", labyrinth);						//state 01011  waaaaaaaaaaar

		 //Maze image data load
		 //start from state 5'b01100																			outputs:
		 $readmemh("C:/Users/flixa/Python/New folder/MStart.hex", MStart);						//01100
		 $readmemh("C:/Users/flixa/Python/New folder/MStraight.hex", MStraight);				//01101
		 $readmemh("C:/Users/flixa/Python/New folder/MLeft.hex", MLeft);							//01110
		 $readmemh("C:/Users/flixa/Python/New folder/MRight.hex", MRight);						//01111
		 $readmemh("C:/Users/flixa/Python/New folder/MDoor.hex", MDoor);							//10000
		 $readmemh("C:/Users/flixa/Python/New folder/MPaintRight.hex", MPaintRight);			//10001
		 $readmemh("C:/Users/flixa/Python/New folder/MBlock.hex", MBlock);						//10010
		 $readmemh("C:/Users/flixa/Python/New folder/MPaintLeft.hex", MPaintLeft);				//10011
		 $readmemh("C:/Users/flixa/Python/New folder/ArmourEquip.hex", ArmourEquip);	
		 $readmemh("C:/Users/flixa/Python/New folder/ArmourEnd.hex", ArmourEnd);
	end
	


	
	//after storing we need to output image depending on state's output
	// Function to map 4-bit color to 12-bit RGB value
   function [11:0] get_rgb;
		input [3:0] pixel_color;  // 4-bit pixel color
        begin
            case (pixel_color)
                4'b0000: get_rgb = 12'h000; // Black
                4'b0001: get_rgb = 12'h00F; // Blue
                4'b0010: get_rgb = 12'h0F0; // Green
                4'b0011: get_rgb = 12'h0FF; // Cyan
                4'b0100: get_rgb = 12'hF00; // Red
                4'b0101: get_rgb = 12'hF0F; // Magenta
                4'b0110: get_rgb = 12'hFF0; // Yellow
                4'b0111: get_rgb = 12'hFFF; // White
                4'b1000: get_rgb = 12'h888; // Gray
                4'b1001: get_rgb = 12'h008; // Dark Blue
                4'b1010: get_rgb = 12'h080; // Dark Green
                4'b1011: get_rgb = 12'h088; // Dark Cyan
                4'b1100: get_rgb = 12'h800; // Dark Red
                4'b1101: get_rgb = 12'h808; // Dark Magenta
                4'b1110: get_rgb = 12'h880; // Dark Yellow
                4'b1111: get_rgb = 12'hCCC; // Light Gray
                default: get_rgb = 12'h000; // Default to black
            endcase
        end
    endfunction

	// Memory index and pixel extraction
	reg [11:0] mem_index;  // 2^12 = 4096. Max pixels in one image is 3072. This addresses image's memory
	reg [3:0] pixel_val;

	
	//////////////////////////////////////////
	// Start State output logic
	//////////////////////////////////////////
	
	always @(posedge clkout) begin
		if (MachineOut == 5'b00000)
		begin
		//	
			if ((counter_x > 144 && counter_x < 784) && (counter_y > 35 && counter_y < 515)) 
			begin
				// Calculate the memory index based on scaled coordinates (10x scaling for each pixel)
				// Each pixel is mapped to a 10x10 block, so scale accordingly
				mem_index <= (((counter_y - 35) / 10) * 64) + ((counter_x - 144) / 10);
				
				// Fetch the 4bits from memory 
				pixel_val <= titlepage[mem_index];
				{r_red, r_green, r_blue} <= get_rgb(pixel_val);  // Set RGB values for pixel
					
			end
		//
		end
		if (MachineOut == 5'b00001)
		begin
		//	
			if ((counter_x > 144 && counter_x < 784) && (counter_y > 35 && counter_y < 515)) 
			begin
				// Calculate the memory index based on scaled coordinates (10x scaling for each pixel)
				// Each pixel is mapped to a 10x10 block, so scale accordingly
				mem_index <= (((counter_y - 35) / 10) * 64) + ((counter_x - 144) / 10);
				
				// Fetch the 4bits from memory 
				pixel_val <= castleexit[mem_index];
				{r_red, r_green, r_blue} <= get_rgb(pixel_val);  // Set RGB values for pixel
					
			end
		//
		end
		if (MachineOut == 5'b00010)
		begin
		//	
			if ((counter_x > 144 && counter_x < 784) && (counter_y > 35 && counter_y < 515)) 
			begin
				// Calculate the memory index based on scaled coordinates (10x scaling for each pixel)
				// Each pixel is mapped to a 10x10 block, so scale accordingly
				mem_index <= (((counter_y - 35) / 10) * 64) + ((counter_x - 144) / 10);
				
				// Fetch the 4bits from memory 
				pixel_val <= plaza[mem_index];
				{r_red, r_green, r_blue} <= get_rgb(pixel_val);  // Set RGB values for pixel
					
			end
		//
		end
		if (MachineOut == 5'b00011)
		begin
		//	
			if ((counter_x > 144 && counter_x < 784) && (counter_y > 35 && counter_y < 515)) 
			begin
				// Calculate the memory index based on scaled coordinates (10x scaling for each pixel)
				// Each pixel is mapped to a 10x10 block, so scale accordingly
				mem_index <= (((counter_y - 35) / 10) * 64) + ((counter_x - 144) / 10);
				
				// Fetch the 4bits from memory 
				pixel_val <= elder[mem_index];
				{r_red, r_green, r_blue} <= get_rgb(pixel_val);  // Set RGB values for pixel
					
			end
		//
		end
		if (MachineOut == 5'b00100)
		begin
		//	
			if ((counter_x > 144 && counter_x < 784) && (counter_y > 35 && counter_y < 515)) 
			begin
				// Calculate the memory index based on scaled coordinates (10x scaling for each pixel)
				// Each pixel is mapped to a 10x10 block, so scale accordingly
				mem_index <= (((counter_y - 35) / 10) * 64) + ((counter_x - 144) / 10);
				
				// Fetch the 4bits from memory 
				pixel_val <= susman[mem_index];
				{r_red, r_green, r_blue} <= get_rgb(pixel_val);  // Set RGB values for pixel
					
			end
		//
		end
		if (MachineOut == 5'b00101)
		begin
		//	
			if ((counter_x > 144 && counter_x < 784) && (counter_y > 35 && counter_y < 515)) 
			begin
				// Calculate the memory index based on scaled coordinates (10x scaling for each pixel)
				// Each pixel is mapped to a 10x10 block, so scale accordingly
				mem_index <= (((counter_y - 35) / 10) * 64) + ((counter_x - 144) / 10);
				
				// Fetch the 4bits from memory 
				pixel_val <= forkinroad[mem_index];
				{r_red, r_green, r_blue} <= get_rgb(pixel_val);  // Set RGB values for pixel
					
			end
		//
		end
		if (MachineOut == 5'b00110)
		begin
		//	
			if ((counter_x > 144 && counter_x < 784) && (counter_y > 35 && counter_y < 515)) 
			begin
				// Calculate the memory index based on scaled coordinates (10x scaling for each pixel)
				// Each pixel is mapped to a 10x10 block, so scale accordingly
				mem_index <= (((counter_y - 35) / 10) * 64) + ((counter_x - 144) / 10);
				
				// Fetch the 4bits from memory 
				pixel_val <= riddle1[mem_index];
				{r_red, r_green, r_blue} <= get_rgb(pixel_val);  // Set RGB values for pixel
					
			end
		//
		end
		if (MachineOut == 5'b00111)
		begin
		//	
			if ((counter_x > 144 && counter_x < 784) && (counter_y > 35 && counter_y < 515)) 
			begin
				// Calculate the memory index based on scaled coordinates (10x scaling for each pixel)
				// Each pixel is mapped to a 10x10 block, so scale accordingly
				mem_index <= (((counter_y - 35) / 10) * 64) + ((counter_x - 144) / 10);
				
				// Fetch the 4bits from memory 
				pixel_val <= riddle2[mem_index];
				{r_red, r_green, r_blue} <= get_rgb(pixel_val);  // Set RGB values for pixel
					
			end
		//
		end
		if (MachineOut == 5'b01000)
		begin
		//	
			if ((counter_x > 144 && counter_x < 784) && (counter_y > 35 && counter_y < 515)) 
			begin
				// Calculate the memory index based on scaled coordinates (10x scaling for each pixel)
				// Each pixel is mapped to a 10x10 block, so scale accordingly
				mem_index <= (((counter_y - 35) / 10) * 64) + ((counter_x - 144) / 10);
				
				// Fetch the 4bits from memory 
				pixel_val <= riddle3[mem_index];
				{r_red, r_green, r_blue} <= get_rgb(pixel_val);  // Set RGB values for pixel
					
			end
		//
		end
		if (MachineOut == 5'b01001)
		begin
		//	
			if ((counter_x > 144 && counter_x < 784) && (counter_y > 35 && counter_y < 515)) 
			begin
				// Calculate the memory index based on scaled coordinates (10x scaling for each pixel)
				// Each pixel is mapped to a 10x10 block, so scale accordingly
				mem_index <= (((counter_y - 35) / 10) * 64) + ((counter_x - 144) / 10);
				
				// Fetch the 4bits from memory 
				pixel_val <= cape[mem_index];
				{r_red, r_green, r_blue} <= get_rgb(pixel_val);  // Set RGB values for pixel
					
			end
		//
		end
		if (MachineOut == 5'b01010)
		begin
		//	
			if ((counter_x > 144 && counter_x < 784) && (counter_y > 35 && counter_y < 515)) 
			begin
				// Calculate the memory index based on scaled coordinates (10x scaling for each pixel)
				// Each pixel is mapped to a 10x10 block, so scale accordingly
				mem_index <= (((counter_y - 35) / 10) * 64) + ((counter_x - 144) / 10);
				
				// Fetch the 4bits from memory 
				pixel_val <= sageend[mem_index];
				{r_red, r_green, r_blue} <= get_rgb(pixel_val);  // Set RGB values for pixel
					
			end
		//
		end
		if (MachineOut == 5'b01011)
		begin
		//	
			if ((counter_x > 144 && counter_x < 784) && (counter_y > 35 && counter_y < 515)) 
			begin
				// Calculate the memory index based on scaled coordinates (10x scaling for each pixel)
				// Each pixel is mapped to a 10x10 block, so scale accordingly
				mem_index <= (((counter_y - 35) / 10) * 64) + ((counter_x - 144) / 10);
				
				// Fetch the 4bits from memory 
				pixel_val <= labyrinth[mem_index];
				{r_red, r_green, r_blue} <= get_rgb(pixel_val);  // Set RGB values for pixel
					
			end
		//
		end
		///////////////////////////////// labyrinth prints
		// Ensure we are within the display region (scale 64x48 image to 640x480)
		else if (MachineOut == STARTPIC)
		begin
		//	
			if ((counter_x > 144 && counter_x < 784) && (counter_y > 35 && counter_y < 515)) 
			begin
				// Calculate the memory index based on scaled coordinates (10x scaling for each pixel)
				// Each pixel is mapped to a 10x10 block, so scale accordingly
				mem_index <= (((counter_y - 35) / 10) * 64) + ((counter_x - 144) / 10);
				
				// Fetch the 4bits from memory 
				pixel_val <= MStart[mem_index];
				{r_red, r_green, r_blue} <= get_rgb(pixel_val);  // Set RGB values for pixel
					
			end
		//
		end
		else if (MachineOut == MSTRAIGHT)
		begin
		//	
			if ((counter_x > 144 && counter_x < 784) && (counter_y > 35 && counter_y < 515)) 
			begin
				// Calculate the memory index based on scaled coordinates (10x scaling for each pixel)
				// Each pixel is mapped to a 10x10 block, so scale accordingly
				mem_index <= (((counter_y - 35) / 10) * 64) + ((counter_x - 144) / 10);
				
				// Fetch the 4bits from memory 
				pixel_val <= MStraight[mem_index];
				{r_red, r_green, r_blue} <= get_rgb(pixel_val);  // Set RGB values for pixel
					
			end
		//
		end
		else if (MachineOut == MLEFT)
		begin
		//	
			if ((counter_x > 144 && counter_x < 784) && (counter_y > 35 && counter_y < 515)) 
			begin
				// Calculate the memory index based on scaled coordinates (10x scaling for each pixel)
				// Each pixel is mapped to a 10x10 block, so scale accordingly
				mem_index <= (((counter_y - 35) / 10) * 64) + ((counter_x - 144) / 10);
				
				// Fetch the 4bits from memory 
				pixel_val <= MLeft[mem_index];
				{r_red, r_green, r_blue} <= get_rgb(pixel_val);  // Set RGB values for pixel
					
			end
		//
		end
		else if (MachineOut == MRIGHT)
		begin
		//	
			if ((counter_x > 144 && counter_x < 784) && (counter_y > 35 && counter_y < 515)) 
			begin
				// Calculate the memory index based on scaled coordinates (10x scaling for each pixel)
				// Each pixel is mapped to a 10x10 block, so scale accordingly
				mem_index <= (((counter_y - 35) / 10) * 64) + ((counter_x - 144) / 10);
				
				// Fetch the 4bits from memory 
				pixel_val <= MRight[mem_index];
				{r_red, r_green, r_blue} <= get_rgb(pixel_val);  // Set RGB values for pixel
					
			end
		//
		end
		else if (MachineOut == MDOOR)
		begin
		//	
			if ((counter_x > 144 && counter_x < 784) && (counter_y > 35 && counter_y < 515)) 
			begin
				// Calculate the memory index based on scaled coordinates (10x scaling for each pixel)
				// Each pixel is mapped to a 10x10 block, so scale accordingly
				mem_index <= (((counter_y - 35) / 10) * 64) + ((counter_x - 144) / 10);
				
				// Fetch the 4bits from memory 
				pixel_val <= MDoor[mem_index];
				{r_red, r_green, r_blue} <= get_rgb(pixel_val);  // Set RGB values for pixel
					
			end
		//
		end
		else if (MachineOut == MPAINTRIGHT)
		begin
		//	
			if ((counter_x > 144 && counter_x < 784) && (counter_y > 35 && counter_y < 515)) 
			begin
				// Calculate the memory index based on scaled coordinates (10x scaling for each pixel)
				// Each pixel is mapped to a 10x10 block, so scale accordingly
				mem_index <= (((counter_y - 35) / 10) * 64) + ((counter_x - 144) / 10);
				
				// Fetch the 4bits from memory 
				pixel_val <= MPaintRight[mem_index];
				{r_red, r_green, r_blue} <= get_rgb(pixel_val);  // Set RGB values for pixel
					
			end
		//
		end
		else if (MachineOut == MBLOCK)
		begin
		//	
			if ((counter_x > 144 && counter_x < 784) && (counter_y > 35 && counter_y < 515)) 
			begin
				// Calculate the memory index based on scaled coordinates (10x scaling for each pixel)
				// Each pixel is mapped to a 10x10 block, so scale accordingly
				mem_index <= (((counter_y - 35) / 10) * 64) + ((counter_x - 144) / 10);
				
				// Fetch the 4bits from memory 
				pixel_val <= MBlock[mem_index];
				{r_red, r_green, r_blue} <= get_rgb(pixel_val);  // Set RGB values for pixel
					
			end
		//
		end
		
		else if (MachineOut == MPAINTLEFT)
		begin
		//	
			if ((counter_x > 144 && counter_x < 784) && (counter_y > 35 && counter_y < 515)) 
			begin
				// Calculate the memory index based on scaled coordinates (10x scaling for each pixel)
				// Each pixel is mapped to a 10x10 block, so scale accordingly
				mem_index <= (((counter_y - 35) / 10) * 64) + ((counter_x - 144) / 10);
				
				// Fetch the 4bits from memory 
				pixel_val <= MPaintLeft[mem_index];
				{r_red, r_green, r_blue} <= get_rgb(pixel_val);  // Set RGB values for pixel
					
			end
		//
		end
		if (MachineOut == 5'b11100)
		begin
		//	
			if ((counter_x > 144 && counter_x < 784) && (counter_y > 35 && counter_y < 515)) 
			begin
				// Calculate the memory index based on scaled coordinates (10x scaling for each pixel)
				// Each pixel is mapped to a 10x10 block, so scale accordingly
				mem_index <= (((counter_y - 35) / 10) * 64) + ((counter_x - 144) / 10);
				
				// Fetch the 4bits from memory 
				pixel_val <= ArmourEquip[mem_index];
				{r_red, r_green, r_blue} <= get_rgb(pixel_val);  // Set RGB values for pixel
					
			end
		//
		end
		if (MachineOut == 5'b11101)
		begin
		//	
			if ((counter_x > 144 && counter_x < 784) && (counter_y > 35 && counter_y < 515)) 
			begin
				// Calculate the memory index based on scaled coordinates (10x scaling for each pixel)
				// Each pixel is mapped to a 10x10 block, so scale accordingly
				mem_index <= (((counter_y - 35) / 10) * 64) + ((counter_x - 144) / 10);
				
				// Fetch the 4bits from memory 
				pixel_val <= ArmourEnd[mem_index];
				{r_red, r_green, r_blue} <= get_rgb(pixel_val);  // Set RGB values for pixel
					
			end
		//
		end
		
		
	end
	
	//////////////////////////////////////////
	// End State output logic
	//////////////////////////////////////////
	
	
	
///////////////////////////////////////////////////////////////


    // Color output assignments
    assign o_red = (counter_x > 144 && counter_x <= 783 && counter_y > 35 && counter_y <= 514) ? r_red : 4'h0;
    assign o_blue = (counter_x > 144 && counter_x <= 783 && counter_y > 35 && counter_y <= 514) ? r_blue : 4'h0;
    assign o_green = (counter_x > 144 && counter_x <= 783 && counter_y > 35 && counter_y <= 514) ? r_green : 4'h0;
    
endmodule