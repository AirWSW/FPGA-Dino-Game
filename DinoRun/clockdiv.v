`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:24:15 11/21/2018 
// Design Name: 
// Module Name:    clockdiv 
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
module clockdiv(

	input wire clk, // master clock: 50MHz
	
	input wire clr, // asynchronous reset

	output wire vgaclk, // pixel clock: 25MHz
	output wire segclk // 7-segment clock: 381.47Hz
	);

	reg [26:0] q;
	reg [30:0] p;

	// Clock divider
	always @(posedge clk or posedge clr) begin
		if (clr == 1) begin
			q <= 0;
			p <= 0;
		end
		else begin
			q <= q + 1;
			p <= p + 1;
		end
	end
	
	// 50Mhz / 2^1 = 25MHz
	assign vgaclk = q[0];
	
	// 50Mhz / 2^15 = 381.47Hz
	assign segclk = q[14];

endmodule
