`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:51:01 12/23/2018 
// Design Name: 
// Module Name:    game_cont 
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
module game_cont(
	input wire clk, // master clock = 50MHz
	input wire vgaclk, // master clock = 50MHz
	
	// set input keys
	input wire clr, // clear and reset all
	input wire restart, // restart game
	input wire key, // DEBUG ONLY or KEY
	input wire jump, // jump control button

	input wire is_alive,

	output wire [3:0] num3_disp,
	output wire [3:0] num2_disp,
	output wire [3:0] num1_disp,
	output wire [3:0] num0_disp,
	
	output wire [3:0] dino_pos,
	output wire [2:0] dino_state,
	output wire [8:0] tree_pos,
	
	output reg [1:0] level,
	output reg [2:0] game_state
	);

// reg [1:0] game_state;
reg [3:0] dino_pos_reg;
reg [2:0] dino_state_reg;
reg [8:0] tree_pos_reg;

reg [20:0] aaa_delay_count;
reg [20:0] bbb_delay_count;
reg [20:0] ccc_delay_count;
reg [20:0] ddd_delay_count;

reg [3:0] num3_disp_reg;
reg [3:0] num2_disp_reg;
reg [3:0] num1_disp_reg;
reg [3:0] num0_disp_reg;

reg [7:0] alex;
wire [7:0] alex_wire;

assign alex_wire = alex;

// Temp Clock divider
reg [40:0] p;
reg [30:0] q;

initial begin
	num3_disp_reg = 'b0000;
	num2_disp_reg = 'b0000;
	num1_disp_reg = 'b0000;
	num0_disp_reg = 'b0000;
	alex = 8'b00000000;
	p = 0;
	q = 0;
	game_state = 2'b00;
	level = 2'b00;
end

// always @(posedge clk or posedge clr) begin
always @(posedge clk) begin
	if(clr) aaa_delay_count <= aaa_delay_count + 1; else aaa_delay_count <= 0;
	if(clr & aaa_delay_count=='b1111010000100100000) begin alex[0] <= 1; end // 10ms
	if(clr==0) alex[0] <= 0;
	alex[1] <= alex_wire[0]; // clear and reset all
	
	if(restart) bbb_delay_count <= bbb_delay_count + 1; else bbb_delay_count <= 0;
	if(restart & bbb_delay_count=='b1111010000100100000) begin alex[2] <= 1; end // 10ms
	if(restart==0) alex[2] <= 0;
	alex[3] <= alex_wire[0]; // restart game
	
	if(key) ccc_delay_count <= ccc_delay_count + 1; else ccc_delay_count <= 0;
	if(key & ccc_delay_count=='b1111010000100100000) begin alex[4] <= 1; end // 10ms
	if(key==0) alex[4] <= 0;
	alex[5] <= alex_wire[0]; // DEBUG ONLY or KEY
	
	if(jump) ddd_delay_count <= ddd_delay_count + 1; else ddd_delay_count <= 0;
	if(jump & ddd_delay_count=='b1111010000100100000) begin alex[6] <= 1; end // 10ms
	if(jump==0) alex[6] <= 0;
	alex[7] <= alex_wire[6]; // jump control button
	
	if (alex_wire[1:0] == 2'b01 | alex_wire[3:2] == 2'b01) begin
		p <= 0;
		q <= 0;
		game_state <= 'b000;
		num3_disp_reg <= 'b0000;
		num2_disp_reg <= 'b0000;
		num1_disp_reg <= 'b0000;
		num0_disp_reg <= 'b0000;
	end
	// else begin
		// p <= p + 'b1;
		// q <= q + 'b1;
	// end
	
	case({alex_wire[7:6],game_state[1:0]})
		// welcome game
		'b0000,'b1000,'b1100:begin dino_state_reg <= 'b100; dino_pos_reg <= 'b0000; tree_pos_reg <= 'b000000000; 
		num3_disp_reg <= 'b0000; num2_disp_reg <= 'b0000; num1_disp_reg <= 'b0000; num0_disp_reg <= 'b0000; end
		'b0100:begin game_state[1:0] <= 2'b01; p <= 0; q <= 0; end
		
		// start game
		'b0001,'b1001,'b1101:begin dino_state_reg[2] <= 0; dino_state_reg[1] <= p[26]; p <= p + 'b1000 + level * 2; dino_pos_reg <= 0; tree_pos_reg <= p[28:20];
			if(tree_pos_reg > 400 && tree_pos_reg < 470) begin game_state[1:0] <= 2'b10; end
			end
		'b0101:begin game_state[1:0] <= 2'b11; end
		
		// jump action
		'b0011,'b1011,'b1111:begin dino_state_reg <= 'b100; p <= p + 'b1000 + level * 2; q <= q + 'b100000; dino_pos_reg <= q[29] ? ~q[28:25] : q[28:25]; tree_pos_reg <= p[28:20];
			if(q[30]) begin game_state[1:0] <= 2'b01; q <= 0; end
			if(tree_pos_reg > 400 && tree_pos_reg < 470 && dino_pos_reg < 8) begin game_state[1:0] <= 2'b10; end
			end
		'b0111:begin game_state[1:0] <= 2'b11; end

		// game over
		'b0010,'b1010,'b1110:begin dino_state_reg[0] <= 'b1; end
		'b0110:begin p <= 0; q <= 0; game_state[1:0] <= 2'b00; end
	endcase
	
	game_state[2] <= p[32];
	if (level != 2'b11) level <= p[34:33];

	// if(p[28]) begin
	// 	num0_disp_reg <= num0_disp_reg + 1;
	// end
	
	if(q[30]) begin
		num1_disp_reg <= num1_disp_reg + 1 * (level + 1);
	end
	
	if(num0_disp_reg >= 'b1010) begin
		num0_disp_reg <= num0_disp_reg - 'b1010;
		num1_disp_reg <= num1_disp_reg + 1;
	end
	if(num1_disp_reg >= 'b1010) begin
		num1_disp_reg <= num1_disp_reg - 'b1010;
		num2_disp_reg <= num2_disp_reg + 1;
	end
	if(num2_disp_reg >= 'b1010) begin
		num2_disp_reg <= num2_disp_reg - 'b1010;
		num3_disp_reg <= num3_disp_reg + 1;
	end
	if(num3_disp_reg >= 'b1010) begin
		num3_disp_reg <= num3_disp_reg - 'b1010;
	end
	
end

// assign dino_state = {0,q[24],q[26]};
assign dino_state = dino_state_reg;
assign dino_pos = dino_pos_reg;
assign tree_pos = tree_pos_reg;

assign num3_disp = num3_disp_reg;
assign num2_disp = num2_disp_reg;
assign num1_disp = num1_disp_reg;
assign num0_disp = num0_disp_reg;

endmodule
