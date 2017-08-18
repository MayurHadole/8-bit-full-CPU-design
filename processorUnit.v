/*File          : processorUnit.v 
--Group         : Group 8
--Programmers   : Mayur Hadole(7475783)

						
--Hardware used : Cyclone V (DE1 SoC)
--Software used : Quartus II 15 64 bit
--Description   : This program implements proccessor unit which consists of ALU, Shifter and REGFILE
--Version       : 1.0  (June 19  , 2017) processor unit and wires defined module defined 
						2.0  (June 20  , 2017) Instantiation 
-- code is working and is tested on board
*/

module processorUnit(CLK,DATA_I,ASEL,BSEL,DSEL,SSEL,HSEL,DATA_O,z,s,c,v,CO);  //Module names and I/o pins are declared

input CLK;   
input [7:0]DATA_I;                   // 8 bit input data

input [ 2:0]  ASEL;                 //Bus Selection (Input)
input [ 2:0]  BSEL;                 //Bus Selection (Input)
input [ 2:0]  DSEL;                 //Destination Select (Input)
input [ 3:0]  SSEL;                 // ALU operatipon Select (Input)
input [ 2:0]  HSEL;                 // Shifter Function Select (Input)

output [7:0]DATA_O;                 // 8 bit output data
output z,s,c,v;                     // ALU flags
output CO;                          // Carry out of shifter       


wire z,s,c,v; 
wire C0;
wire [7:0]DATA_I;
wire [7:0]DATA_O;


   wire [ 2:0]  ASEL;						//A Bus Selection wire
   wire [ 2:0]  BSEL;						//B Bus Selection wire
   wire [ 2:0]  DSEL;						//Destination Select wire
   wire [ 3:0]  SSEL;						// ALU operatipon Select wire
   wire [ 2:0]  HSEL;						// Shifter Function Select wire

	wire [7:0] aWire;                   // Wire for connecting A of ALU to the A of shifter
	wire [7:0] bWire;							// Wire for connecting B of ALU to the B of shifter
	wire [7:0] fWire;                   // Wire for connecting Output result F of ALU to the Input F of shifter
	wire [7:0] sWire;							// Wire for connecting Output result S of Shifter to the DatA_O of processor unit

REGFILE regfile1(.DSEL(DSEL),.ASEL(ASEL),.BSEL(BSEL),.DIN(DATA_I),.RIN(DATA_O),.a(aWire),.b(bWire),.clk(CLK));  // instantiation of Regfile
ALU alu1(.SSEL(SSEL),.A(aWire),.B(bWire),.F(fWire),.Z(z),.S(s),.C(c),.V(v));				// instantiation of ALU
SHIFTER shifter1(.f(fWire),.HSEL(HSEL),.CI(c),.S(DATA_O),.CO(CO));							// instantiation of Shifter

always @ (DATA_I)
begin

end

endmodule 