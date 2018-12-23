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
// include "para.v"
module vga_disp_dino(
	input wire vgaclk, // pixel clock: 25MHz
	
	input wire clr, // asynchronous reset
	
	input wire [3:0] dino_pos,
	input wire [2:0] dino_state,
	input wire [8:0] tree_pos,
	input wire [2:0] game_state,
	
	input wire [3:0] num3_disp,
	input wire [3:0] num2_disp,
	input wire [3:0] num1_disp,
	input wire [3:0] num0_disp,

	output reg is_alive,
	input wire [1:0] level,

	output wire [2:0] red, // red vga output - 3 bits
	output wire [2:0] green, // green vga output - 3 bits
	output wire [1:0] blue, // blue vga output - 2 bits
	output wire hsync, // horizontal sync output
	output wire vsync  // vertical sync output
	);

// video structure constants 640*480@60Hz, 25.125MHz
parameter H_SYNC = 96; // hsync pulse length
parameter H_BACK = 48; // end of horizontal back porch
parameter H_DISP = 640;
parameter H_FRONT = 16; // beginning of horizontal front porch
parameter H_TOTAL = 800; // horizontal pixels per line

parameter V_SYNC = 2; // vsync pulse length
parameter V_BACK = 33; // end of vertical back porch
parameter V_DISP = 480;
parameter V_FRONT = 10; // beginning of vertical front porch
parameter V_TOTAL = 525; // vertical lines per frame

//                          U  K  F  C
// parameter char_line0 = 'h00_00_00_00_00;
// parameter char_line1 = 'h00_00_00_00_00;
// parameter char_line2 = 'h00_63_73_7F_1E;
// parameter char_line3 = 'h00_63_33_33_33;
// parameter char_line4 = 'h00_63_36_31_61;
// parameter char_line5 = 'h00_63_36_34_60;
// parameter char_line6 = 'h00_63_3C_3C_60;
// parameter char_line7 = 'h00_63_36_34_60;
// parameter char_line8 = 'h00_63_36_30_60;
// parameter char_line9 = 'h00_63_33_30_61;
// parameter char_lineA = 'h00_63_33_30_33;
// parameter char_lineB = 'h00_3E_73_78_1E;
// parameter char_lineC = 'h00_00_00_00_00;
// parameter char_lineD = 'h00_00_00_00_00;
// parameter char_lineE = 'h00_00_00_00_00;
// parameter char_lineF = 'h00_00_00_00_00;

// 0x20     !  "  #  $  %  &  '  (  )  *  +  ,  -  .  / 
// 0x30  0  1  2  3  4  5  6  7  8  9  :  ;  <  =  >  ?  
// 0x40  @  A  B  C  D  E  F  G  H  I  J  K  L  M  N  O 
// 0x50  P  Q  R  S  T  U  V  W  X  Y  Z  [  \  ]  ^  _ 
// 0x60  `  a  b  c  d  e  f  g  h  i  j  k  l  m  n  o 
// 0x70  p  q  r  s  t  u  v  w  x  y  z  {  |  }  ~ DEL
/*
parameter char_line0 = 'h000000000C00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000008001800000000000000000000000000000000000000000000000000000000000000;
parameter char_line1 = 'h000063000C0000300000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001C001800000000000000000000000000000000000000000000000000000000000070;
parameter char_line2 = 'h001863003E0000300C180000000000013E0C3E3E067F1C7F3E3E00000000003E3E087E1E7C7F7F1E633C0F737863631C7E3E7E3EFF636363C3C37F3C803C36000C0070000E001C00700C06701C00000000000000080000000000000E18703BD8;
parameter char_line3 = 'h003C633663001C30180C000000000003631C63630E6030636363000006006063631C333336333333631806333077633633633363DB636363C3C36330C00C63000000300006003600300C06300C00000000000000180000000000001818186ED8;
parameter char_line4 = 'h003C223661003660180C421800000007633C03031E606003636300000C003063633633613331316163180636307F7363336333639963636366C34330E00C00000000300006003200300000300C00000000000000180000000000001818180070;
parameter char_line5 = 'h003C007F60613600300666180000000E630C06033660600663631818180018066F6333603334346063180636306B7B6333633330186363633C660630700C0000003C3C3E1E3E303B361C0E330C6E6E3E6E3B6E3E7E66636363637F1818180000;
parameter char_line6 = 'h001800363E631C0030063C180000001C6B0C0C1E667E7E063E631818307E0C0C6B633E60333C3C607F18063C30637F633E633E1C18636363183C0C30380C00000046366336637C663B0C06330C7F336333663B631866636336636670180E0000;
parameter char_line7 = 'h0018003603063B003006FFFF00FF00386B0C18036603630C633F00006000060C6B6333603334346F6318063630636F63306336061863636B181818301C0C00000006336066633066330C06360C6B336333663338186636631C630C1800180000;
parameter char_line8 = 'h00180036030C6E0030063C1800000070630C30037F03630C6303000030000C0C6E7F3360333030636318063630636763306336031863636B3C1830300E0C0000003E3360667E3066330C063C0C6B33633366300E1866366B1C63181818180000;
parameter char_line9 = 'h0000007F43186600180C6618000000E0630C61030663631863030000187E180060633361333130636318663331636363306B33631863367F66186130070C00000066336066603066330C06360C6B33633366300318661C6B1C63301818180000;
parameter char_lineA = 'h0018003663336600180C4218180018C0630C636306736318630618180C00300C60633333363330376318663333636336306F336318631C36C3186330030C0000006633636663303E330C06330C6B33633E3E30631B661C7F363F631818180000;
parameter char_lineB = 'h001800363E633B000C180000180018803E3F7F3E0F3E3E183E3C18180600600C3E637E1E7C7F781D633C3C737F63631C783E733E3C3E0836C33C7F3C013C0000003B6E3E3B3E7806731E66731E6B333E3006783E0E3B083663037F0E18700000;
parameter char_lineC = 'h000000000C00000000000000180000000000000000000000000000180000000000000000000000000000000000000000000600000000000000000000000000FF0000000000000066000066000000000030060000000000000006000018000000;
parameter char_lineD = 'h000000000C0000000000000030000000000000000000000000000030000000000000000000000000000000000000000000070000000000000000000000000000000000000000003C00003C0000000000780F000000000000003C000000000000;
parameter char_lineE = 'h000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000;
parameter char_lineF = 'h000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000;
parameter end_ascii = 'h7F;
*/

parameter char_line0 = 'h000000000C0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000800;
parameter char_line1 = 'h000063000C0000300000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001C00;
parameter char_line2 = 'h001863003E0000300C180000000000013E0C3E3E067F1C7F3E3E00000000003E3E087E1E7C7F7F1E633C0F737863631C7E3E7E3EFF636363C3C37F3C803C3600;
parameter char_line3 = 'h003C633663001C30180C000000000003631C63630E6030636363000006006063631C333336333333631806333077633633633363DB636363C3C36330C00C6300;
parameter char_line4 = 'h003C223661003660180C421800000007633C03031E606003636300000C003063633633613331316163180636307F7363336333639963636366C34330E00C0000;
parameter char_line5 = 'h003C007F60613600300666180000000E630C06033660600663631818180018066F6333603334346063180636306B7B6333633330186363633C660630700C0000;
parameter char_line6 = 'h001800363E631C0030063C180000001C6B0C0C1E667E7E063E631818307E0C0C6B633E60333C3C607F18063C30637F633E633E1C18636363183C0C30380C0000;
parameter char_line7 = 'h0018003603063B003006FFFF00FF00386B0C18036603630C633F00006000060C6B6333603334346F6318063630636F63306336061863636B181818301C0C0000;
parameter char_line8 = 'h00180036030C6E0030063C1800000070630C30037F03630C6303000030000C0C6E7F3360333030636318063630636763306336031863636B3C1830300E0C0000;
parameter char_line9 = 'h0000007F43186600180C6618000000E0630C61030663631863030000187E180060633361333130636318663331636363306B33631863367F66186130070C0000;
parameter char_lineA = 'h0018003663336600180C4218180018C0630C636306736318630618180C00300C60633333363330376318663333636336306F336318631C36C3186330030C0000;
parameter char_lineB = 'h001800363E633B000C180000180018803E3F7F3E0F3E3E183E3C18180600600C3E637E1E7C7F781D633C3C737F63631C783E733E3C3E0836C33C7F3C013C0000;
parameter char_lineC = 'h000000000C00000000000000180000000000000000000000000000180000000000000000000000000000000000000000000600000000000000000000000000FF;
parameter char_lineD = 'h000000000C0000000000000030000000000000000000000000000030000000000000000000000000000000000000000000070000000000000000000000000000;
parameter char_lineE = 'h00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000;
parameter char_lineF = 'h00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000;
parameter end_ascii = 'h5F;

// parameter char_line0 = 'h00_00_00_00_00;
// parameter char_line1 = 'h00_00_00_00_00;
// parameter char_line2 = 'h00_63_73_7F_1E;
// parameter char_line3 = 'h00_63_33_33_33;
// parameter char_line4 = 'h00_63_36_31_61;
// parameter char_line5 = 'h00_63_36_34_60;
// parameter char_line6 = 'h00_63_3C_3C_60;
// parameter char_line7 = 'h00_63_36_34_60;
// parameter char_line8 = 'h00_63_36_30_60;
// parameter char_line9 = 'h00_63_33_30_61;
// parameter char_lineA = 'h00_63_33_30_33;
// parameter char_lineB = 'h00_3E_73_78_1E;
// parameter char_lineC = 'h00_00_00_00_00;
// parameter char_lineD = 'h00_00_00_00_00;
// parameter char_lineE = 'h00_00_00_00_00;
// parameter char_lineF = 'h00_00_00_00_00;
// parameter end_ascii = 'h5F;

// land and cloud source
parameter source_line0 = 'b00000000000000000000000011110000000000000000000011110000010000;
parameter source_line1 = 'b00000000000000000000111110011110000000000000000110010000111000;
parameter source_line2 = 'b00000000000000000001100000000011000000000000001000001000111000;
parameter source_line3 = 'b00000000000000000111000000000001000000000000111000000111111000;
parameter source_line4 = 'b00000000000000000100000000000001111000000000111000000111011110;
parameter source_line5 = 'b00000000000000000100000000000001001111100000001100001100111111;
parameter source_line6 = 'b00000000000001111100000000000010000000100000000111111000111111;
parameter source_line7 = 'b00000000000011000000000000000000000000111100000000000000111111;
parameter source_line8 = 'b00000011111110000000000000000000000000000100111000000111111000;
parameter source_line9 = 'b00000110000000000000000000000000000000000110001100001100111100;
parameter source_lineA = 'b01101100010000000000000000000000000000000001000111111000011100;
parameter source_lineB = 'b11000000001111111111111111111111111111111111000000000000001100;
parameter source_lineC = 'he77ddca3bb474c9d27a853d2d7064dfbd91419add64f471f073629d52627;
parameter source_lineD = 'hfb96d68a327545008a7dc16f4690472fc18eea9cbe12489e09ee8260f8de;
parameter source_lineE = 'h2c5dc4347fcd43c0073629d526274defde43a68e4d184aa32cb94f36b9fe;
parameter source_lineF = 'hb51bffd0bdf74cb609ee8260f8de41a486f1fda459fa47c7ef0f50cc5f0c;

// bird source


// dino source
parameter dino_line0 = 'b0111111110111001111000000001111100;
parameter dino_line1 = 'b1111111111110000001000000111111100;
parameter dino_line2 = 'b1101111111100000001100001111111111;
parameter dino_line3 = 'b1111111111110000001110011111111101;
parameter dino_line4 = 'b1111111111110011001111111111111100;
parameter dino_line5 = 'b1111111111011001001111111111111100;
parameter dino_line6 = 'b1111100000000001000111111111111100;
parameter dino_line7 = 'b1111111100000001100011111111111000;
parameter dino_line8 = 'b0111111110111011000001111111110000;
parameter dino_line9 = 'b1111111111110001000000111111100000;
parameter dino_lineA = 'b1100011111100001000000000000000000;
parameter dino_lineB = 'b1101011111110001100000000000000000;
parameter dino_lineC = 'b1100011111000000000000000000000000;
parameter dino_lineD = 'b1111111111000000000000000000000000;
parameter dino_lineE = 'b1111111111000000000000000000000000;
parameter dino_lineF = 'b1111111110000000000000000000000000;

// registers for storing the horizontal & vertical counters
reg [9:0] intHcnt;
reg [9:0] intVcnt;
reg [7:0] vga_rgb;
wire [9:0] Xpos;
wire [9:0] Ypos;
wire [9:0] charXpos;
wire [9:0] charYpos;
wire [9:0] landXpos;
wire [9:0] landYpos;
wire [9:0] cloudXpos;
wire [9:0] cloudYpos;
wire [9:0] treeXpos;
wire [9:0] treeYpos;
wire [9:0] birdXpos;
wire [9:0] birdYpos;
wire [9:0] dinoXpos;
wire [9:0] dinoYpos;

// Horizontal & vertical counters
always @(posedge vgaclk or posedge clr) begin
	// reset condition
	if (clr == 1) begin
		intHcnt <= 0;
		intVcnt <= 0;
	end
	else begin
		// keep counting until the end of the line
		if (intHcnt < H_TOTAL)
			intHcnt <= intHcnt + 1;
		else begin
			// keep counting until the end of the row
			intHcnt <= 0;
			if (intVcnt < V_TOTAL)
				intVcnt <= intVcnt + 1;
			else
				intVcnt <= 0;
		end
	end
end

// generate sync pulses 
assign hsync = (intHcnt < H_SYNC) ? 0 : 1;
assign vsync = (intVcnt < V_SYNC) ? 0 : 1;

// define the safe area
assign Xpos = intHcnt - H_SYNC - H_BACK;
assign Ypos = intVcnt - V_SYNC - V_BACK;

// Temp Clock divider
reg [31:0] q;
always @(posedge vgaclk or posedge clr) begin
	if (clr == 1) begin
		q <= 0;
	end
	else begin
		q <= q + 'b1000;
	end
end

reg [7:0] text = 8'h20;
always @(posedge q[22]) begin
	text <= q[29] ? (text<8'h5f ? text + 1 : 8'h20) : 8'h21;
end

initial begin
	is_alive = 1'b0;
end

// temp variable
reg [9:0] temp;
parameter move_x = 50;

// char ======================================================================
//       0  1  2  3  4  5  6  7  8  9  A  B  C  D  E  F
// 0x20     !  "  #  $  %  &  '  (  )  *  +  ,  -  .  / 
// 0x30  0  1  2  3  4  5  6  7  8  9  :  ;  <  =  >  ?  
// 0x40  @  A  B  C  D  E  F  G  H  I  J  K  L  M  N  O 
// 0x50  P  Q  R  S  T  U  V  W  X  Y  Z  [  \  ]  ^  _ 
// 0x60  `  a  b  c  d  e  f  g  h  i  j  k  l  m  n  o 
// 0x70  p  q  r  s  t  u  v  w  x  y  z  {  |  }  ~ DEL
// parameter char_x_0 = 150;
// parameter char_y_0 = 200;
// parameter char_lines_0 = 16;
// parameter char_rows_0 = 1;
// parameter char_scale_0 = 2;
// parameter char_disp_0 = 'h47_20_41_20_4d_20_45_20_20_4f_20_56_20_45_20_52;

// parameter char_x = 180;
// parameter char_y = 200;
parameter char_lines = 16;
parameter char_rows = 1;
parameter char_scale = 2;
// parameter char_disp = 'h47_20_41_20_4d_20_45_20_20_4f_20_56_20_45_20_52;
reg [127:0] char_disp;
// parameter char_x_1 = 150;
// parameter char_y_1 = 200;
// parameter char_lines_1 = 16;
// parameter char_rows_1 = 1;
// parameter char_scale_1 = 2;
// parameter char_disp_1 = 'h30_31_20_32_20_33_20_34_20_35_20_36_37_38_39_3A;

reg [9:0] char_x;
reg [9:0] char_y;
// reg [9:0] char_lines;
// reg [9:0] char_rows;
// reg [9:0] char_scale;
// reg [511:0] char_disp;
reg [7:0] char_index;

assign charXpos = (Xpos - char_x)/char_scale;
assign charYpos = (Ypos - char_y)/char_scale;
// char end ==================================================================

// land ======================================================================
parameter land_x = 0;
parameter land_y = 376;
parameter land_scale = 2;

wire [7:0] land_state;

assign land_state = q[29:22];

assign landXpos = (Xpos - land_x)/land_scale;
assign landYpos = (Ypos - land_y)/land_scale;
// land end ==================================================================

// cloud ======================================================================
// parameter cloud_x = 350;
parameter cloud_y = 150;
parameter cloud_scale = 2;
wire [8:0] cloud_x;
wire [2:0] cloud_state;

assign cloud_x = ~q[31:23];
assign cloud_state = {0,q[23],q[25]};

assign cloudXpos = (Xpos - cloud_x - move_x/2)/cloud_scale;
assign cloudYpos = (Ypos - cloud_y)/cloud_scale;
// cloud end ==================================================================

// tree ======================================================================
parameter tree_y = 300;
parameter tree_scale = 4;

wire [8:0] tree_x; 
wire [2:0] tree_state;

assign tree_x = ~tree_pos;
assign tree_state = {0,q[23],q[25]};

assign treeXpos = (Xpos - tree_x - move_x)/tree_scale;
assign treeYpos = (Ypos - tree_y)/tree_scale;
// tree end ==================================================================

// bird ======================================================================
//parameter bird_x = 50;
//parameter bird_y = 300;
//parameter bird_scale = 4;

//wire [2:0] bird_state;

//assign bird_state = {0,q[23],q[25]};

//assign birdXpos = (Xpos - bird_x)/bird_scale;
//assign birdYpos = (Ypos - bird_y)/bird_scale;
// bird end ==================================================================

// dino ======================================================================
parameter dino_x = 50;
parameter dino_y = 300;
parameter dino_scale = 4;

// wire [2:0] dino_state;

// assign dino_state = {0,q[24],q[26]};

assign dinoXpos = (Xpos - dino_x - move_x)/dino_scale;
assign dinoYpos = (Ypos - dino_y + dino_pos * 10)/dino_scale; // Ypos add 
// dino end ==================================================================

// char ======================================================================
//       0  1  2  3  4  5  6  7  8  9  A  B  C  D  E  F
// 0x20     !  "  #  $  %  &  '  (  )  *  +  ,  -  .  / 
// 0x30  0  1  2  3  4  5  6  7  8  9  :  ;  <  =  >  ?  
// 0x40  @  A  B  C  D  E  F  G  H  I  J  K  L  M  N  O 
// 0x50  P  Q  R  S  T  U  V  W  X  Y  Z  [  \  ]  ^  _ 
// 0x60  `  a  b  c  d  e  f  g  h  i  j  k  l  m  n  o 
// 0x70  p  q  r  s  t  u  v  w  x  y  z  {  |  }  ~ DEL

always @(posedge vgaclk) begin
	// is_alive <= 1'b1;
	case(game_state[1:0])
		2'b00:begin char_disp <= {112'h57_20_45_20_4c_20_43_20_4f_20_4d_20_45_20,text,8'h20}; char_x <= 10'd192; char_y <= 10'd200; end
		2'b01:begin char_disp <= {28'h4c_56_20_3,2'b00,level,64'h20_20_53_43_4f_52_45_20,4'h3,num3_disp,4'h3,num2_disp,4'h3,num1_disp,4'h3,num0_disp}; char_x <= 10'd360; char_y <= 10'd100; end
		2'b11:begin char_disp <= {28'h4c_56_20_3,2'b00,level,64'h20_20_53_43_4f_52_45_20,4'h3,num3_disp,4'h3,num2_disp,4'h3,num1_disp,4'h3,num0_disp}; char_x <= 10'd360; char_y <= 10'd100; end
		2'b10:begin case(q[30:28])
				'b000:begin char_disp <= 128'h47_20_41_20_4d_20_45_20_20_4f_20_56_20_45_20_52; char_x <= 10'd192; char_y <= 10'd200; end
				'b001:begin char_disp <= {28'h4c_56_20_3,2'b00,level,64'h20_20_53_43_4f_52_45_20,4'h3,num3_disp,4'h3,num2_disp,4'h3,num1_disp,4'h3,num0_disp}; char_x <= 10'd192; char_y <= 10'd200; end
				'b010:begin char_disp <= 128'h47_20_41_20_4d_20_45_20_20_4f_20_56_20_45_20_52; char_x <= 10'd192; char_y <= 10'd200; end
				'b011:begin char_disp <= 128'h20_20_20_4d_49_4e_47_52_55_49_20_59_55_20_20_20; char_x <= 10'd192; char_y <= 10'd200; end
				'b100:begin char_disp <= 128'h47_20_41_20_4d_20_45_20_20_4f_20_56_20_45_20_52; char_x <= 10'd192; char_y <= 10'd200; end
				'b101:begin char_disp <= {28'h4c_56_20_3,2'b00,level,64'h20_20_53_43_4f_52_45_20,4'h3,num3_disp,4'h3,num2_disp,4'h3,num1_disp,4'h3,num0_disp}; char_x <= 10'd192; char_y <= 10'd200; end
				'b110:begin char_disp <= 128'h47_20_41_20_4d_20_45_20_20_4f_20_56_20_45_20_52; char_x <= 10'd192; char_y <= 10'd200; end
				'b111:begin char_disp <= 128'h20_20_20_53_48_49_57_45_49_20_57_41_4e_47_20_20; char_x <= 10'd184; char_y <= 10'd200; end
			endcase end
	endcase
	if (Xpos >= 0 && Xpos < (H_DISP - 0) && Ypos >= 0 && Ypos < (V_DISP - 0)) begin
		if (game_state[2]) vga_rgb <= 8'b000_000_00; else vga_rgb <= 8'b111_111_11;
		if (Xpos >= char_x && Xpos < (char_x + 8*char_scale*char_lines) && Ypos >= char_y && Ypos < (char_y + 16*char_scale*char_rows)) begin
			case(charXpos[6:3])
				'h0:char_index <= end_ascii - char_disp[127:120];
				'h1:char_index <= end_ascii - char_disp[119:112];
				'h2:char_index <= end_ascii - char_disp[111:104];
				'h3:char_index <= end_ascii - char_disp[103:96];
				'h4:char_index <= end_ascii - char_disp[95:88];
				'h5:char_index <= end_ascii - char_disp[87:80];
				'h6:char_index <= end_ascii - char_disp[79:72];
				'h7:char_index <= end_ascii - char_disp[71:64];
				'h8:char_index <= end_ascii - char_disp[63:56];
				'h9:char_index <= end_ascii - char_disp[55:48];
				'hA:char_index <= end_ascii - char_disp[47:40];
				'hB:char_index <= end_ascii - char_disp[39:32];
				'hC:char_index <= end_ascii - char_disp[31:24];
				'hD:char_index <= end_ascii - char_disp[23:16];
				'hE:char_index <= end_ascii - char_disp[15:8];
				'hF:char_index <= end_ascii - char_disp[7:0];
				default:char_index <= end_ascii - 'h20;
			endcase
			case(charYpos[3:0])
				'h0:if (char_line0[8*char_index + 7 - charXpos[2:0]]) begin if (~game_state[2]) vga_rgb <= 8'b000_000_00; else vga_rgb <= 8'b111_111_11; end else if (game_state[2]) vga_rgb <= 8'b000_000_00; else vga_rgb <= 8'b111_111_11; 
				'h1:if (char_line1[8*char_index + 7 - charXpos[2:0]]) begin if (~game_state[2]) vga_rgb <= 8'b000_000_00; else vga_rgb <= 8'b111_111_11; end else if (game_state[2]) vga_rgb <= 8'b000_000_00; else vga_rgb <= 8'b111_111_11; 
				'h2:if (char_line2[8*char_index + 7 - charXpos[2:0]]) begin if (~game_state[2]) vga_rgb <= 8'b000_000_00; else vga_rgb <= 8'b111_111_11; end else if (game_state[2]) vga_rgb <= 8'b000_000_00; else vga_rgb <= 8'b111_111_11; 
				'h3:if (char_line3[8*char_index + 7 - charXpos[2:0]]) begin if (~game_state[2]) vga_rgb <= 8'b000_000_00; else vga_rgb <= 8'b111_111_11; end else if (game_state[2]) vga_rgb <= 8'b000_000_00; else vga_rgb <= 8'b111_111_11; 
				'h4:if (char_line4[8*char_index + 7 - charXpos[2:0]]) begin if (~game_state[2]) vga_rgb <= 8'b000_000_00; else vga_rgb <= 8'b111_111_11; end else if (game_state[2]) vga_rgb <= 8'b000_000_00; else vga_rgb <= 8'b111_111_11; 
				'h5:if (char_line5[8*char_index + 7 - charXpos[2:0]]) begin if (~game_state[2]) vga_rgb <= 8'b000_000_00; else vga_rgb <= 8'b111_111_11; end else if (game_state[2]) vga_rgb <= 8'b000_000_00; else vga_rgb <= 8'b111_111_11; 
				'h6:if (char_line6[8*char_index + 7 - charXpos[2:0]]) begin if (~game_state[2]) vga_rgb <= 8'b000_000_00; else vga_rgb <= 8'b111_111_11; end else if (game_state[2]) vga_rgb <= 8'b000_000_00; else vga_rgb <= 8'b111_111_11; 
				'h7:if (char_line7[8*char_index + 7 - charXpos[2:0]]) begin if (~game_state[2]) vga_rgb <= 8'b000_000_00; else vga_rgb <= 8'b111_111_11; end else if (game_state[2]) vga_rgb <= 8'b000_000_00; else vga_rgb <= 8'b111_111_11; 
				'h8:if (char_line8[8*char_index + 7 - charXpos[2:0]]) begin if (~game_state[2]) vga_rgb <= 8'b000_000_00; else vga_rgb <= 8'b111_111_11; end else if (game_state[2]) vga_rgb <= 8'b000_000_00; else vga_rgb <= 8'b111_111_11; 
				'h9:if (char_line9[8*char_index + 7 - charXpos[2:0]]) begin if (~game_state[2]) vga_rgb <= 8'b000_000_00; else vga_rgb <= 8'b111_111_11; end else if (game_state[2]) vga_rgb <= 8'b000_000_00; else vga_rgb <= 8'b111_111_11; 
				'hA:if (char_lineA[8*char_index + 7 - charXpos[2:0]]) begin if (~game_state[2]) vga_rgb <= 8'b000_000_00; else vga_rgb <= 8'b111_111_11; end else if (game_state[2]) vga_rgb <= 8'b000_000_00; else vga_rgb <= 8'b111_111_11; 
				'hB:if (char_lineB[8*char_index + 7 - charXpos[2:0]]) begin if (~game_state[2]) vga_rgb <= 8'b000_000_00; else vga_rgb <= 8'b111_111_11; end else if (game_state[2]) vga_rgb <= 8'b000_000_00; else vga_rgb <= 8'b111_111_11; 
				'hC:if (char_lineC[8*char_index + 7 - charXpos[2:0]]) begin if (~game_state[2]) vga_rgb <= 8'b000_000_00; else vga_rgb <= 8'b111_111_11; end else if (game_state[2]) vga_rgb <= 8'b000_000_00; else vga_rgb <= 8'b111_111_11; 
				'hD:if (char_lineD[8*char_index + 7 - charXpos[2:0]]) begin if (~game_state[2]) vga_rgb <= 8'b000_000_00; else vga_rgb <= 8'b111_111_11; end else if (game_state[2]) vga_rgb <= 8'b000_000_00; else vga_rgb <= 8'b111_111_11; 
				'hE:if (char_lineE[8*char_index + 7 - charXpos[2:0]]) begin if (~game_state[2]) vga_rgb <= 8'b000_000_00; else vga_rgb <= 8'b111_111_11; end else if (game_state[2]) vga_rgb <= 8'b000_000_00; else vga_rgb <= 8'b111_111_11; 
				'hF:if (char_lineF[8*char_index + 7 - charXpos[2:0]]) begin if (~game_state[2]) vga_rgb <= 8'b000_000_00; else vga_rgb <= 8'b111_111_11; end else if (game_state[2]) vga_rgb <= 8'b000_000_00; else vga_rgb <= 8'b111_111_11; 
				default:if (game_state[2]) vga_rgb <= 8'b000_000_00; else vga_rgb <= 8'b111_111_11;
			endcase
		end
		
		// draw land
		if (Xpos >= land_x && Xpos < (land_x + 320*land_scale) && Ypos >= land_y && Ypos < (land_y + 30*land_scale)) begin
			// if (landYpos >= 0 && landYpos < 8) begin
				// case({land_state[0], landYpos[2:0]})
					// 'h0:if (source_line0[43 - landXpos]) vga_rgb <= 8'b000_000_00; else vga_rgb <= 8'b111_111_11;
					// 'h1:if (source_line1[43 - landXpos]) vga_rgb <= 8'b000_000_00; else vga_rgb <= 8'b111_111_11;
					// 'h2:if (source_line2[43 - landXpos]) vga_rgb <= 8'b000_000_00; else vga_rgb <= 8'b111_111_11;
					// 'h3:if (source_line3[43 - landXpos]) vga_rgb <= 8'b000_000_00; else vga_rgb <= 8'b111_111_11;
					// 'h4:if (source_line4[43 - landXpos]) vga_rgb <= 8'b000_000_00; else vga_rgb <= 8'b111_111_11;
					// 'h5:if (source_line5[43 - landXpos]) vga_rgb <= 8'b000_000_00; else vga_rgb <= 8'b111_111_11;
					// 'h6:if (source_line6[43 - landXpos]) vga_rgb <= 8'b000_000_00; else vga_rgb <= 8'b111_111_11;
					// 'h7:if (source_line7[43 - landXpos]) vga_rgb <= 8'b000_000_00; else vga_rgb <= 8'b111_111_11;
					// 'h8:if (source_line8[43 - landXpos]) vga_rgb <= 8'b000_000_00; else vga_rgb <= 8'b111_111_11;
					// 'h9:if (source_line9[43 - landXpos]) vga_rgb <= 8'b000_000_00; else vga_rgb <= 8'b111_111_11;
					// 'hA:if (source_lineA[43 - landXpos]) vga_rgb <= 8'b000_000_00; else vga_rgb <= 8'b111_111_11;
					// 'hB:if (source_lineB[43 - landXpos]) vga_rgb <= 8'b000_000_00; else vga_rgb <= 8'b111_111_11;
					// default:vga_rgb <= 8'b111_111_11;
				// endcase
			// end
			
			if (landYpos == 4) begin
				if (~game_state[2]) vga_rgb <= 8'b000_000_00; else vga_rgb <= 8'b111_111_11;
			end
			
			if (landYpos == 14) begin
				if (source_lineC[land_state + landXpos]) begin if (~game_state[2]) vga_rgb <= 8'b000_000_00; else vga_rgb <= 8'b111_111_11; end else if (game_state[2]) vga_rgb <= 8'b000_000_00; else vga_rgb <= 8'b111_111_11; 
			end
			if (landYpos == 28) begin
				if (source_lineD[land_state + landXpos]) begin if (~game_state[2]) vga_rgb <= 8'b000_000_00; else vga_rgb <= 8'b111_111_11; end else if (game_state[2]) vga_rgb <= 8'b000_000_00; else vga_rgb <= 8'b111_111_11; 
			end
			if (landYpos == 22) begin
				if (source_lineE[land_state + landXpos]) begin if (~game_state[2]) vga_rgb <= 8'b000_000_00; else vga_rgb <= 8'b111_111_11; end else if (game_state[2]) vga_rgb <= 8'b000_000_00; else vga_rgb <= 8'b111_111_11; 
			end
			if (landYpos == 26) begin
				if (source_lineF[land_state + landXpos]) begin if (~game_state[2]) vga_rgb <= 8'b000_000_00; else vga_rgb <= 8'b111_111_11; end else if (game_state[2]) vga_rgb <= 8'b000_000_00; else vga_rgb <= 8'b111_111_11; 
			end
		end
		
		// draw cloud
		if (Xpos >= (cloud_x + move_x/2) && Xpos < (cloud_x + 44*cloud_scale + move_x/2) && Ypos >= cloud_y && Ypos < (cloud_y + 12*cloud_scale)) begin
			case(cloudYpos)
				'h0:if (source_line0[61 - cloudXpos]) vga_rgb <= 8'b100_100_10; else if (game_state[2]) vga_rgb <= 8'b000_000_00; else vga_rgb <= 8'b111_111_11; 
				'h1:if (source_line1[61 - cloudXpos]) vga_rgb <= 8'b100_100_10; else if (game_state[2]) vga_rgb <= 8'b000_000_00; else vga_rgb <= 8'b111_111_11; 
				'h2:if (source_line2[61 - cloudXpos]) vga_rgb <= 8'b100_100_10; else if (game_state[2]) vga_rgb <= 8'b000_000_00; else vga_rgb <= 8'b111_111_11; 
				'h3:if (source_line3[61 - cloudXpos]) vga_rgb <= 8'b100_100_10; else if (game_state[2]) vga_rgb <= 8'b000_000_00; else vga_rgb <= 8'b111_111_11; 
				'h4:if (source_line4[61 - cloudXpos]) vga_rgb <= 8'b100_100_10; else if (game_state[2]) vga_rgb <= 8'b000_000_00; else vga_rgb <= 8'b111_111_11; 
				'h5:if (source_line5[61 - cloudXpos]) vga_rgb <= 8'b100_100_10; else if (game_state[2]) vga_rgb <= 8'b000_000_00; else vga_rgb <= 8'b111_111_11; 
				'h6:if (source_line6[61 - cloudXpos]) vga_rgb <= 8'b100_100_10; else if (game_state[2]) vga_rgb <= 8'b000_000_00; else vga_rgb <= 8'b111_111_11; 
				'h7:if (source_line7[61 - cloudXpos]) vga_rgb <= 8'b100_100_10; else if (game_state[2]) vga_rgb <= 8'b000_000_00; else vga_rgb <= 8'b111_111_11; 
				'h8:if (source_line8[61 - cloudXpos]) vga_rgb <= 8'b100_100_10; else if (game_state[2]) vga_rgb <= 8'b000_000_00; else vga_rgb <= 8'b111_111_11; 
				'h9:if (source_line9[61 - cloudXpos]) vga_rgb <= 8'b100_100_10; else if (game_state[2]) vga_rgb <= 8'b000_000_00; else vga_rgb <= 8'b111_111_11; 
				'hA:if (source_lineA[61 - cloudXpos]) vga_rgb <= 8'b100_100_10; else if (game_state[2]) vga_rgb <= 8'b000_000_00; else vga_rgb <= 8'b111_111_11; 
				'hB:if (source_lineB[61 - cloudXpos]) vga_rgb <= 8'b100_100_10; else if (game_state[2]) vga_rgb <= 8'b000_000_00; else vga_rgb <= 8'b111_111_11; 
				default:if (game_state[2]) vga_rgb <= 8'b000_000_00; else vga_rgb <= 8'b111_111_11;
			endcase
		end

		// draw dino
		if (Xpos >= (dino_x + move_x) && Xpos < (dino_x + 20*dino_scale + move_x) && (Ypos >= dino_y - dino_pos * 10) && Ypos < (dino_y + 22*dino_scale - dino_pos * 10)) begin // Ypos minus 
			if (dinoXpos >= 10 && dinoXpos < 20 && dinoYpos >= 0 && dinoYpos < 8) begin
				case({dino_state[0], dinoYpos[2:0]})
					'h0:if (dino_line0[43 - dinoXpos]) begin if (~game_state[2]) vga_rgb <= 8'b000_000_00; else vga_rgb <= 8'b111_111_11; end else if (game_state[2]) vga_rgb <= 8'b000_000_00; else vga_rgb <= 8'b111_111_11; 
					'h1:if (dino_line1[43 - dinoXpos]) begin if (~game_state[2]) vga_rgb <= 8'b000_000_00; else vga_rgb <= 8'b111_111_11; end else if (game_state[2]) vga_rgb <= 8'b000_000_00; else vga_rgb <= 8'b111_111_11; 
					'h2:if (dino_line2[43 - dinoXpos]) begin if (~game_state[2]) vga_rgb <= 8'b000_000_00; else vga_rgb <= 8'b111_111_11; end else if (game_state[2]) vga_rgb <= 8'b000_000_00; else vga_rgb <= 8'b111_111_11; 
					'h3:if (dino_line3[43 - dinoXpos]) begin if (~game_state[2]) vga_rgb <= 8'b000_000_00; else vga_rgb <= 8'b111_111_11; end else if (game_state[2]) vga_rgb <= 8'b000_000_00; else vga_rgb <= 8'b111_111_11; 
					'h4:if (dino_line4[43 - dinoXpos]) begin if (~game_state[2]) vga_rgb <= 8'b000_000_00; else vga_rgb <= 8'b111_111_11; end else if (game_state[2]) vga_rgb <= 8'b000_000_00; else vga_rgb <= 8'b111_111_11; 
					'h5:if (dino_line5[43 - dinoXpos]) begin if (~game_state[2]) vga_rgb <= 8'b000_000_00; else vga_rgb <= 8'b111_111_11; end else if (game_state[2]) vga_rgb <= 8'b000_000_00; else vga_rgb <= 8'b111_111_11; 
					'h6:if (dino_line6[43 - dinoXpos]) begin if (~game_state[2]) vga_rgb <= 8'b000_000_00; else vga_rgb <= 8'b111_111_11; end else if (game_state[2]) vga_rgb <= 8'b000_000_00; else vga_rgb <= 8'b111_111_11; 
					'h7:if (dino_line7[43 - dinoXpos]) begin if (~game_state[2]) vga_rgb <= 8'b000_000_00; else vga_rgb <= 8'b111_111_11; end else if (game_state[2]) vga_rgb <= 8'b000_000_00; else vga_rgb <= 8'b111_111_11; 
					'h8:if (dino_line8[43 - dinoXpos]) begin if (~game_state[2]) vga_rgb <= 8'b000_000_00; else vga_rgb <= 8'b111_111_11; end else if (game_state[2]) vga_rgb <= 8'b000_000_00; else vga_rgb <= 8'b111_111_11; 
					'h9:if (dino_line9[43 - dinoXpos]) begin if (~game_state[2]) vga_rgb <= 8'b000_000_00; else vga_rgb <= 8'b111_111_11; end else if (game_state[2]) vga_rgb <= 8'b000_000_00; else vga_rgb <= 8'b111_111_11; 
					'hA:if (dino_lineA[43 - dinoXpos]) begin if (~game_state[2]) vga_rgb <= 8'b000_000_00; else vga_rgb <= 8'b111_111_11; end else if (game_state[2]) vga_rgb <= 8'b000_000_00; else vga_rgb <= 8'b111_111_11; 
					'hB:if (dino_lineB[43 - dinoXpos]) begin if (~game_state[2]) vga_rgb <= 8'b000_000_00; else vga_rgb <= 8'b111_111_11; end else if (game_state[2]) vga_rgb <= 8'b000_000_00; else vga_rgb <= 8'b111_111_11; 
					'hC:if (dino_lineC[43 - dinoXpos]) begin if (~game_state[2]) vga_rgb <= 8'b000_000_00; else vga_rgb <= 8'b111_111_11; end else if (game_state[2]) vga_rgb <= 8'b000_000_00; else vga_rgb <= 8'b111_111_11; 
					'hD:if (dino_lineD[43 - dinoXpos]) begin if (~game_state[2]) vga_rgb <= 8'b000_000_00; else vga_rgb <= 8'b111_111_11; end else if (game_state[2]) vga_rgb <= 8'b000_000_00; else vga_rgb <= 8'b111_111_11; 
					'hE:if (dino_lineE[43 - dinoXpos]) begin if (~game_state[2]) vga_rgb <= 8'b000_000_00; else vga_rgb <= 8'b111_111_11; end else if (game_state[2]) vga_rgb <= 8'b000_000_00; else vga_rgb <= 8'b111_111_11; 
					'hF:if (dino_lineF[43 - dinoXpos]) begin if (~game_state[2]) vga_rgb <= 8'b000_000_00; else vga_rgb <= 8'b111_111_11; end else if (game_state[2]) vga_rgb <= 8'b000_000_00; else vga_rgb <= 8'b111_111_11; 
					default:if (game_state[2]) vga_rgb <= 8'b000_000_00; else vga_rgb <= 8'b111_111_11;
				endcase
			end
			else if (dinoXpos >= 0 && dinoXpos < 16 && dinoYpos >= 8 && dinoYpos < 18) begin
				case((dinoYpos - 8))
					'h0:if (dino_line0[15 - dinoXpos]) begin if (~game_state[2]) vga_rgb <= 8'b000_000_00; else vga_rgb <= 8'b111_111_11; end else if (game_state[2]) vga_rgb <= 8'b000_000_00; else vga_rgb <= 8'b111_111_11; 
					'h1:if (dino_line1[15 - dinoXpos]) begin if (~game_state[2]) vga_rgb <= 8'b000_000_00; else vga_rgb <= 8'b111_111_11; end else if (game_state[2]) vga_rgb <= 8'b000_000_00; else vga_rgb <= 8'b111_111_11; 
					'h2:if (dino_line2[15 - dinoXpos]) begin if (~game_state[2]) vga_rgb <= 8'b000_000_00; else vga_rgb <= 8'b111_111_11; end else if (game_state[2]) vga_rgb <= 8'b000_000_00; else vga_rgb <= 8'b111_111_11; 
					'h3:if (dino_line3[15 - dinoXpos]) begin if (~game_state[2]) vga_rgb <= 8'b000_000_00; else vga_rgb <= 8'b111_111_11; end else if (game_state[2]) vga_rgb <= 8'b000_000_00; else vga_rgb <= 8'b111_111_11; 
					'h4:if (dino_line4[15 - dinoXpos]) begin if (~game_state[2]) vga_rgb <= 8'b000_000_00; else vga_rgb <= 8'b111_111_11; end else if (game_state[2]) vga_rgb <= 8'b000_000_00; else vga_rgb <= 8'b111_111_11; 
					'h5:if (dino_line5[15 - dinoXpos]) begin if (~game_state[2]) vga_rgb <= 8'b000_000_00; else vga_rgb <= 8'b111_111_11; end else if (game_state[2]) vga_rgb <= 8'b000_000_00; else vga_rgb <= 8'b111_111_11; 
					'h6:if (dino_line6[15 - dinoXpos]) begin if (~game_state[2]) vga_rgb <= 8'b000_000_00; else vga_rgb <= 8'b111_111_11; end else if (game_state[2]) vga_rgb <= 8'b000_000_00; else vga_rgb <= 8'b111_111_11; 
					'h7:if (dino_line7[15 - dinoXpos]) begin if (~game_state[2]) vga_rgb <= 8'b000_000_00; else vga_rgb <= 8'b111_111_11; end else if (game_state[2]) vga_rgb <= 8'b000_000_00; else vga_rgb <= 8'b111_111_11; 
					'h8:if (dino_line8[15 - dinoXpos]) begin if (~game_state[2]) vga_rgb <= 8'b000_000_00; else vga_rgb <= 8'b111_111_11; end else if (game_state[2]) vga_rgb <= 8'b000_000_00; else vga_rgb <= 8'b111_111_11; 
					'h9:if (dino_line9[15 - dinoXpos]) begin if (~game_state[2]) vga_rgb <= 8'b000_000_00; else vga_rgb <= 8'b111_111_11; end else if (game_state[2]) vga_rgb <= 8'b000_000_00; else vga_rgb <= 8'b111_111_11; 
					default:if (game_state[2]) vga_rgb <= 8'b000_000_00; else vga_rgb <= 8'b111_111_11;
				endcase
			end
			else if (dinoXpos >= 5 && dinoXpos < 13 && dinoYpos >= 18 && dinoYpos < 22) begin
				temp <= dinoYpos - 18;
				case({dino_state[2:1], temp[1:0]})
					'h0:if (dino_line0[28 - dinoXpos]) begin if (~game_state[2]) vga_rgb <= 8'b000_000_00; else vga_rgb <= 8'b111_111_11; end else if (game_state[2]) vga_rgb <= 8'b000_000_00; else vga_rgb <= 8'b111_111_11; 
					'h1:if (dino_line1[28 - dinoXpos]) begin if (~game_state[2]) vga_rgb <= 8'b000_000_00; else vga_rgb <= 8'b111_111_11; end else if (game_state[2]) vga_rgb <= 8'b000_000_00; else vga_rgb <= 8'b111_111_11; 
					'h2:if (dino_line2[28 - dinoXpos]) begin if (~game_state[2]) vga_rgb <= 8'b000_000_00; else vga_rgb <= 8'b111_111_11; end else if (game_state[2]) vga_rgb <= 8'b000_000_00; else vga_rgb <= 8'b111_111_11; 
					'h3:if (dino_line3[28 - dinoXpos]) begin if (~game_state[2]) vga_rgb <= 8'b000_000_00; else vga_rgb <= 8'b111_111_11; end else if (game_state[2]) vga_rgb <= 8'b000_000_00; else vga_rgb <= 8'b111_111_11; 
					'h4:if (dino_line4[28 - dinoXpos]) begin if (~game_state[2]) vga_rgb <= 8'b000_000_00; else vga_rgb <= 8'b111_111_11; end else if (game_state[2]) vga_rgb <= 8'b000_000_00; else vga_rgb <= 8'b111_111_11; 
					'h5:if (dino_line5[28 - dinoXpos]) begin if (~game_state[2]) vga_rgb <= 8'b000_000_00; else vga_rgb <= 8'b111_111_11; end else if (game_state[2]) vga_rgb <= 8'b000_000_00; else vga_rgb <= 8'b111_111_11; 
					'h6:if (dino_line6[28 - dinoXpos]) begin if (~game_state[2]) vga_rgb <= 8'b000_000_00; else vga_rgb <= 8'b111_111_11; end else if (game_state[2]) vga_rgb <= 8'b000_000_00; else vga_rgb <= 8'b111_111_11; 
					'h7:if (dino_line7[28 - dinoXpos]) begin if (~game_state[2]) vga_rgb <= 8'b000_000_00; else vga_rgb <= 8'b111_111_11; end else if (game_state[2]) vga_rgb <= 8'b000_000_00; else vga_rgb <= 8'b111_111_11; 
					'h8:if (dino_line8[28 - dinoXpos]) begin if (~game_state[2]) vga_rgb <= 8'b000_000_00; else vga_rgb <= 8'b111_111_11; end else if (game_state[2]) vga_rgb <= 8'b000_000_00; else vga_rgb <= 8'b111_111_11; 
					'h9:if (dino_line9[28 - dinoXpos]) begin if (~game_state[2]) vga_rgb <= 8'b000_000_00; else vga_rgb <= 8'b111_111_11; end else if (game_state[2]) vga_rgb <= 8'b000_000_00; else vga_rgb <= 8'b111_111_11; 
					'hA:if (dino_lineA[28 - dinoXpos]) begin if (~game_state[2]) vga_rgb <= 8'b000_000_00; else vga_rgb <= 8'b111_111_11; end else if (game_state[2]) vga_rgb <= 8'b000_000_00; else vga_rgb <= 8'b111_111_11; 
					'hB:if (dino_lineB[28 - dinoXpos]) begin if (~game_state[2]) vga_rgb <= 8'b000_000_00; else vga_rgb <= 8'b111_111_11; end else if (game_state[2]) vga_rgb <= 8'b000_000_00; else vga_rgb <= 8'b111_111_11; 
					'hC:if (dino_line8[28 - dinoXpos]) begin if (~game_state[2]) vga_rgb <= 8'b000_000_00; else vga_rgb <= 8'b111_111_11; end else if (game_state[2]) vga_rgb <= 8'b000_000_00; else vga_rgb <= 8'b111_111_11; 
					'hD:if (dino_line9[28 - dinoXpos]) begin if (~game_state[2]) vga_rgb <= 8'b000_000_00; else vga_rgb <= 8'b111_111_11; end else if (game_state[2]) vga_rgb <= 8'b000_000_00; else vga_rgb <= 8'b111_111_11; 
					'hE:if (dino_lineA[28 - dinoXpos]) begin if (~game_state[2]) vga_rgb <= 8'b000_000_00; else vga_rgb <= 8'b111_111_11; end else if (game_state[2]) vga_rgb <= 8'b000_000_00; else vga_rgb <= 8'b111_111_11; 
					'hF:if (dino_lineB[28 - dinoXpos]) begin if (~game_state[2]) vga_rgb <= 8'b000_000_00; else vga_rgb <= 8'b111_111_11; end else if (game_state[2]) vga_rgb <= 8'b000_000_00; else vga_rgb <= 8'b111_111_11; 
					default:if (game_state[2]) vga_rgb <= 8'b000_000_00; else vga_rgb <= 8'b111_111_11;
				endcase
			end
		end
	
		// draw tree
		if (Xpos >= (tree_x + move_x) && Xpos < (tree_x + 6*tree_scale + move_x) && Ypos >= tree_y && Ypos < (tree_y + 22*tree_scale)) begin
			case(treeYpos)
				'h0:if (source_line4[5 - treeXpos]) begin if (~game_state[2]) vga_rgb <= 8'b000_000_00; else vga_rgb <= 8'b111_111_11; end else if (game_state[2]) vga_rgb <= 8'b000_000_00; else vga_rgb <= 8'b111_111_11; 
				'h1:if (source_line5[5 - treeXpos]) begin if (~game_state[2]) vga_rgb <= 8'b000_000_00; else vga_rgb <= 8'b111_111_11; end else if (game_state[2]) vga_rgb <= 8'b000_000_00; else vga_rgb <= 8'b111_111_11; 
				'h2:if (source_line5[5 - treeXpos]) begin if (~game_state[2]) vga_rgb <= 8'b000_000_00; else vga_rgb <= 8'b111_111_11; end else if (game_state[2]) vga_rgb <= 8'b000_000_00; else vga_rgb <= 8'b111_111_11; 
				'h3:if (source_line5[5 - treeXpos]) begin if (~game_state[2]) vga_rgb <= 8'b000_000_00; else vga_rgb <= 8'b111_111_11; end else if (game_state[2]) vga_rgb <= 8'b000_000_00; else vga_rgb <= 8'b111_111_11; 
				'h4:if (source_line5[5 - treeXpos]) begin if (~game_state[2]) vga_rgb <= 8'b000_000_00; else vga_rgb <= 8'b111_111_11; end else if (game_state[2]) vga_rgb <= 8'b000_000_00; else vga_rgb <= 8'b111_111_11; 
				'h5:if (source_line5[5 - treeXpos]) begin if (~game_state[2]) vga_rgb <= 8'b000_000_00; else vga_rgb <= 8'b111_111_11; end else if (game_state[2]) vga_rgb <= 8'b000_000_00; else vga_rgb <= 8'b111_111_11; 
				'h6:if (source_line5[5 - treeXpos]) begin if (~game_state[2]) vga_rgb <= 8'b000_000_00; else vga_rgb <= 8'b111_111_11; end else if (game_state[2]) vga_rgb <= 8'b000_000_00; else vga_rgb <= 8'b111_111_11; 
				'h7:if (source_line5[5 - treeXpos]) begin if (~game_state[2]) vga_rgb <= 8'b000_000_00; else vga_rgb <= 8'b111_111_11; end else if (game_state[2]) vga_rgb <= 8'b000_000_00; else vga_rgb <= 8'b111_111_11; 
				'h8:if (source_line5[5 - treeXpos]) begin if (~game_state[2]) vga_rgb <= 8'b000_000_00; else vga_rgb <= 8'b111_111_11; end else if (game_state[2]) vga_rgb <= 8'b000_000_00; else vga_rgb <= 8'b111_111_11; 
				'h9:if (source_line5[5 - treeXpos]) begin if (~game_state[2]) vga_rgb <= 8'b000_000_00; else vga_rgb <= 8'b111_111_11; end else if (game_state[2]) vga_rgb <= 8'b000_000_00; else vga_rgb <= 8'b111_111_11; 
				'hA:if (source_line5[5 - treeXpos]) begin if (~game_state[2]) vga_rgb <= 8'b000_000_00; else vga_rgb <= 8'b111_111_11; end else if (game_state[2]) vga_rgb <= 8'b000_000_00; else vga_rgb <= 8'b111_111_11; 
				'hB:if (source_line5[5 - treeXpos]) begin if (~game_state[2]) vga_rgb <= 8'b000_000_00; else vga_rgb <= 8'b111_111_11; end else if (game_state[2]) vga_rgb <= 8'b000_000_00; else vga_rgb <= 8'b111_111_11; 
				default:if (source_line5[5 - treeXpos]) begin if (~game_state[2]) vga_rgb <= 8'b000_000_00; else vga_rgb <= 8'b111_111_11; end else if (game_state[2]) vga_rgb <= 8'b000_000_00; else vga_rgb <= 8'b111_111_11; 
			endcase
		end
		
		// // draw bird
		// if (Xpos >= dino_x && Xpos < (dino_x + 20*dino_scale) && Ypos >= dino_y && Ypos < (dino_y + 22*dino_scale)) begin

		// end
	end
	else vga_rgb <= 8'b000_000_00;

	// case({game_state[2],vga_rgb})
	// 	9'b0111_111_11:begin vga_rgb <= 8'b111_111_11; end
	// 	9'b0000_000_00:begin vga_rgb <= 8'b000_000_00; end
	// 	9'b1111_111_11:begin vga_rgb <= 8'b000_000_00; end
	// 	9'b1000_000_00:begin vga_rgb <= 8'b111_111_11; end
	// endcase
end

assign {red[2:0],green[2:0],blue[1:0]} = {vga_rgb[7:5],vga_rgb[4:2],vga_rgb[1:0]};


endmodule
