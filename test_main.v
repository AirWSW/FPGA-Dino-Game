`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   00:33:18 11/22/2018
// Design Name:   main
// Module Name:   C:/Users/Shiwei/Documents/XILINX/Dino-Run-master/Dino/test_main.v
// Project Name:  Dino
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: main
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module test_main;

	// Inputs
	reg clk;
	reg clr;
	reg restart;
	reg key;
	reg jump;

	// Outputs
	wire [7:0] seg;
	wire [3:0] an;
	wire dp;
	wire [2:0] red;
	wire [2:0] green;
	wire [1:0] blue;
	wire hsync;
	wire vsync;

	// Instantiate the Unit Under Test (UUT)
	main uut (
		.clk(clk), 
		.clr(clr), 
		.restart(restart), 
		.key(key), 
		.jump(jump), 
		.seg(seg), 
		.an(an), 
		.dp(dp), 
		.red(red), 
		.green(green), 
		.blue(blue), 
		.hsync(hsync), 
		.vsync(vsync)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		clr = 0;
		restart = 0;
		key = 0;
		jump = 0;

		// Wait 100 ns for global reset to finish
		#100;
		
		// Add stimulus here
		clr = 0;#100;
		clr = 1;#20000000;
		clr = 0;#200000000;
		jump = 1;#20000000;
		jump = 0;#200000000;
		jump = 1;#20000000;
		jump = 0;#200000000;
		jump = 1;#20000000;
		jump = 0;
		
	end
	
	always#10 clk = ~clk;
      
endmodule

