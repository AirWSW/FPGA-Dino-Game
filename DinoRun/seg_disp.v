`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:53:34 11/21/2018 
// Design Name: 
// Module Name:    seg_disp 
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
module seg_disp(

	input wire segclk,
	
	input wire [3:0] num3_disp,
	input wire [3:0] num2_disp,
	input wire [3:0] num1_disp,
	input wire [3:0] num0_disp,
	
	// set 7-segment display
	output reg [7:0] seg, // 7-segment display LEDs
	output reg [3:0] an, // 7-segment display anode
	output reg dp // 7-segment display colon
    );

reg [1:0] select = 2'b00;
reg [3:0] digit;

initial begin
	dp = 1'b1;
end

always@(posedge segclk) begin
	an = 4'b1111;
	select <= select + 1;
	an[select] = 0;
	case(select)
		2'b00:digit = num0_disp[3:0];
		2'b01:digit = num1_disp[3:0];
		2'b10:digit = num2_disp[3:0];
		2'b11:digit = num3_disp[3:0];
		default:digit = num3_disp[3:0];
	endcase
	case(digit)
		'h0:seg = 7'b0000001; // disp 0
		'h1:seg = 7'b1001111; // disp 1
		'h2:seg = 7'b0010010; // disp 2
		'h3:seg = 7'b0000110; // disp 3
		'h4:seg = 7'b1001100; // disp 4
		'h5:seg = 7'b0100100; // disp 5
		'h6:seg = 7'b0100000; // disp 6
		'h7:seg = 7'b0001111; // disp 7
		'h8:seg = 7'b0000000; // disp 8
		'h9:seg = 7'b0000100; // disp 9
		'hA:seg = 7'b0001000; // disp A
		'hB:seg = 7'b1100000; // disp b
		'hC:seg = 7'b0110001; // disp C
		'hD:seg = 7'b1000010; // disp d
		'hE:seg = 7'b0110000; // disp E
		'hF:seg = 7'b0111000; // disp F
		default:seg = 7'b0000001; // default disp 0
	endcase
end

endmodule
