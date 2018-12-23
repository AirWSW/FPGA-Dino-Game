`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:05:35 11/21/2018 
// Design Name: 
// Module Name:    main 
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
module main(
	// set master clock
	input wire clk, // master clock = 50MHz
	
	// set input keys
	input wire clr, // clear and reset all
	input wire restart, // restart game
	input wire key, // DEBUG ONLY or KEY
	input wire jump, // jump control button
	
	// set 7-segment display
	output wire [7:0] seg, // 7-segment display LEDs
	output wire [3:0] an, // 7-segment display anode
	output wire dp, // 7-segment display colon
	
	// set VGA display
	output wire [2:0] red, // red vga output - 3 bits
	output wire [2:0] green, // green vga output - 3 bits
	output wire [1:0] blue, // blue vga output - 2 bits
	output wire hsync, // horizontal sync output
	output wire vsync  // vertical sync output
	);

// scores interconnect
wire [1:0] level;

wire [3:0] num3_reg;
wire [3:0] num2_reg;
wire [3:0] num1_reg;
wire [3:0] num0_reg;

wire [3:0] dino_pos;
wire [2:0] dino_state;
wire [8:0] tree_pos;
wire is_alive;

wire [2:0] game_state;

// 7-segment clock interconnect
wire segclk;
// wire blinkclk;

// VGA display clock interconnect
wire vgaclk;

// clock or frequency divider
clockdiv CoF_Divider(
	.clk(clk),
	.clr(clr),
	.vgaclk(vgaclk),
	.segclk(segclk)
	);
	
// game logic
game_cont Game_Controller(clk,vgaclk,clr,restart,key,jump,is_alive,
	num3_reg,num2_reg,num1_reg,num0_reg,
	dino_pos,dino_state,tree_pos,level,game_state);

// 7-segment display controller
seg_disp SSD_Controller(
	.segclk(segclk),
	.num3_disp(num3_reg),
	.num2_disp(num2_reg),
	.num1_disp(num1_reg),
	.num0_disp(num0_reg),
	.seg(seg),
	.an(an),
	.dp(dp)
	);

// VGA display controller
vga_disp_dino VGA_Controller(
	.vgaclk(vgaclk),
	.clr(clr),
	.dino_pos(dino_pos),
	.dino_state(dino_state),
	.tree_pos(tree_pos),
	.game_state(game_state),
	.num3_disp(num3_reg),
	.num2_disp(num2_reg),
	.num1_disp(num1_reg),
	.num0_disp(num0_reg),
	.is_alive(is_alive),
	.level(level),
	.red(red),
	.green(green),
	.blue(blue),
	.hsync(hsync),
	.vsync(vsync)
	);

endmodule
