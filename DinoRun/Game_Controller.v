`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:35:35 12/23/2018 
// Design Name: 
// Module Name:    Game_Controller 
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
module Game_Controller(
	input wire clk, // master clock = 50MHz
	
	// set input keys
	input wire clr, // clear and reset all
	input wire restart, // restart game
	input wire key, // DEBUG ONLY or KEY
	input wire jump, // jump control button
	
	output wire [3:0] num3_disp,
	output wire [3:0] num2_disp,
	output wire [3:0] num1_disp,
	output wire [3:0] num0_disp,
	
	output wire [3:0] dino_pos,
	output wire [2:0] dino_state,
	output wire [3:0] tree_pos
	
	);


endmodule
