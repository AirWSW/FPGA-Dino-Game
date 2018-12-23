`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:53:13 11/21/2018 
// Design Name: 
// Module Name:    vga_disp 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module vga_disp(

	input wire vgaclk, // pixel clock: 25MHz
	
	input wire clr, // asynchronous reset
	
	// input [9:0] dino_h,
	// input [9:0] dino_v,
	// input [9:0] obstacle_h,
	// input [9:0] obstacle_v,
	// input [9:0] cloud_v,
	// input [9:0] cloud_h,
	// input [9:0] enemy_h,
	// input [9:0] enemy_v,
	// input [7:0] obstacle_height,
	// input [7:0] obstacle_width,
	// input [7:0] enemy_height,
	// input [7:0] enemy_width,
	// input [3:0] score3, // add ons start here
	// input [3:0] score2,
	// input [3:0] score1,
	// input [3:0] score0,
	// input alive, // add ons end here

	output reg [2:0] red, // red vga output - 3 bits
	output reg [2:0] green, // green vga output - 3 bits
	output reg [1:0] blue, // blue vga output - 2 bits
	output wire hsync, // horizontal sync output
	output wire vsync  // vertical sync output
	);

// video structure constants // parameters for Synchro module
parameter PAL = 640; // Pixels/Active Line
parameter LAF = 480; //

parameter PLD = 800; //hpixels = 800; // horizontal pixels per line
parameter LFD = 525; //vlines = 521; // vertical lines per frame

parameter HPW = 96; //hpulse = 96; // hsync pulse length
parameter VPW = 20; //vpulse = 2; // vsync pulse length

parameter HBP = HPW; //hbp = 144; // end of horizontal back porch
parameter HFP = HPW + PAL; //hfp = 784; // beginning of horizontal front porch

parameter VBP = VPW; //vbp = 31; // end of vertical back porch
parameter VFP = VPW + LAF; //vfp = 511; // beginning of vertical front porch
// active horizontal video is therefore: 784 - 144 = 640
// active vertical video is therefore: 511 - 31 = 480

// regs for VGA Demo
reg [9:0] intHcnt;
reg [9:0] intVcnt;

always@(posedge vgaclk or posedge clr) begin
	// reset condition
	if(clr == 1) begin
		intHcnt <= 0;
		intVcnt <= 0;
	end
	else begin
		// keep counting until the end of the line
		if (intHcnt < PLD - 1)
			intHcnt <= intHcnt + 1;
		else begin
		// When we hit the end of the line, reset the horizontal
		// counter and increment the vertical counter.
		// If vertical counter is at the end of the frame, then
		// reset that one too.
			intHcnt <= 0;
			if (intVcnt < LFD - 1)
				intVcnt <= intVcnt + 1;
			else
				intVcnt <= 0;
		end
	end
end

// generate sync pulses (active low)
// ----------------
// "assign" statements are a quick way to
// give values to variables of type: wire
assign hsync = (intHcnt < HPW) ? 0:1;
assign vsync = (intVcnt < VPW) ? 0:1;

always@(*) begin
	if(intHcnt>=HBP && intHcnt<HFP && intVcnt>=VBP+10 && intVcnt<VFP-440) begin
		if(intHcnt[1]==1) begin
			red <= 3'b111;
			green <= 3'b000;
			blue <= 2'b00;
		end
		if (intVcnt >= VFP - 40 && intVcnt < VFP && intHcnt >= HFP && intHcnt < HFP) begin
			red = 3'b111;
			green = 3'b111;
			blue = 2'b11;
		end
		
		if (intVcnt >= VFP - 40 && intVcnt < VFP && intHcnt >= HFP && intHcnt < HFP) begin
			red = 3'b111;
			green = 3'b111;
			blue = 2'b11;
		end
	end
//	else begin
//		red <= 3'b000;
//		green <= 3'b000;
//		blue <= 2'b00;
//	end
end

endmodule
