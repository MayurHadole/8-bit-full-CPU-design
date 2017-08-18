/*File          : REGFILE.v 
--Group         : Group 8
--Programmers   : Mayur Hadole(7475783) & Rohit Bhardwaj (7639651)
--Version       : 1.0  (May 17 , 2017)
--Hardware used : Cyclone V (DE1 SoC)
--Software used : Quartus II 15 64 bit
--Description   : This program implements CPU's register file on DE1 SoC board using VHDL

-- code is working and is tested on board

*/
module REGFILE(clk,ASEL,BSEL,DSEL,DIN,RIN,a,b);    //Module names and I/o pins are declared
input clk;
input [2:0] ASEL;                                   //Bus Selection (Input)
input [2:0] BSEL;												 //Bus Selection (Input)
input [2:0] DSEL;												 //Destination Select (Input)
input [7:0] DIN;												 //Input Data (Input)
input [7:0] RIN;												 //Destination Register data In (Input)

output [7:0] a;												 //BUS Outputs
output [7:0] b;												 //BUS Outputs

reg [7:0] a;			// 8 Bit output register
reg [7:0] b;         // 8 Bit output register

// 7 8-bit registers for the CPU
reg [7:0] reg1;
reg [7:0] reg2;
reg [7:0] reg3;
reg [7:0] reg4 = 8'b10101100; 
reg [7:0] reg5 = 8'b10000000;
reg [7:0] reg6 = 8'b11111111; 
reg [7:0] reg7 = 8'b01011001;

always @(posedge clk)    //always block loop to execute over and over again
begin
	case (DSEL)             // Depending upon the register number mentioned in DSEL input line , data is transfered from that RIN to the particular register
		3'b001 : reg1 = RIN;
		3'b010 : reg2 = RIN;
		3'b011 : reg3 = RIN;
		3'b100 : reg4 = RIN;
		3'b101 : reg5 = RIN;
		3'b110 : reg6 = RIN;
		3'b111 : reg7 = RIN;
	endcase;
end
	
always @(ASEL)       //always block loop to execute over and over again
	begin
	case (ASEL)            // Depending upon the register number mentioned in ASEL input line , data is transfered from that particular register to the output line A
	   3'b000 : a = DIN;   // if ASEL is zero then DIN is directly transfered to Ouput line A
		3'b001 : a = reg1;
		3'b010 : a = reg2;
		3'b011 : a = reg3;
		3'b100 : a = reg4;
		3'b101 : a = reg5;
		3'b110 : a = reg6;
		3'b111 : a = reg7;
	endcase;
end
	
	always @(BSEL)      //always block loop to execute over and over again
	begin
	case (BSEL)           //Depending upon the register number mentioned in BSEL input line , data is transfered from that particular register to the output line B
		3'b000 : b = DIN;  // if BSEL is zero then DIN is directly transfered to Ouput line B
		3'b001 : b = reg1;
		3'b010 : b = reg2;
		3'b011 : b = reg3;
		3'b100 : b = reg4;
		3'b101 : b = reg5;
		3'b110 : b = reg6;
		3'b111 : b = reg7;
	endcase;
end
endmodule
	
	

