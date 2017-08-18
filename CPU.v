/*File          : ALU.v 
--Group         : Group 8
--Programmers   : Mayur Hadole(7475783)
					
--Hardware used : Cyclone V (DE1 SoC)
--Software used : Quartus II 15 64 bit
--Description   : This program implements CPU which consists of processor unit,rom, Mux1 ,mux2, CAR, Microcode ROM to make clock run central 
						processor unit
--Version       : 1.0  (June 19  , 2017) modules, wires, Mux1 and mux 2 are implemented
						2.0  (June 20  , 2017) used individual 7 segment display to show flags
					   3.0  (June 20  , 2017) Removed MUx1 and MUX2 to implement it in different file. Also flags and CAR are displayed on SevenSegmentDecoder
					                          segment displays	
-- code is working and is tested on board
*/

module CPU(CLK,DATA_I,DATA_O,DEBUG,data_0,dselo,temp,led);    //Module names and I/o pins are declared

input CLK;
input [7:0]DATA_I;              // 8 bit input data
output [7:0]DATA_O;             // 8 bit output data
output [13:0]data_0;             // 8 bit output data

output [23:0]DEBUG;             // 24 bit Output Debug line which will be used for displaying flags and CAR
output [6:0]dselo;
output [2:0]temp;
output led[1:0];               


   wire [31:0]  DATA_out;      // 8 bit output data
   wire [ 2:0]  ASEL;			 // A Bus Selection wire
   wire [ 2:0]  BSEL;          // B Bus Selection wire
   wire [ 2:0]  DSEL;          // Destination Select wire
   wire [ 3:0]  SSEL;          // ALU operatipon Select wire
   wire [ 2:0]  HSEL;          // Shifter Function Select wire
   wire         MUX1;          // MUX1 Select
   wire [ 2:0]  MUX2;			 // MUX2 Select
	reg MUX2Output;             // Register to save output of MUX 1
	reg  [7:0] MUX1Output;      // Register to save output of MUX 2 .Its 8 bit because it will be use to get internal or external address
	reg  [7:0] MUX1OutputNext;  // to save next address
   wire [ 7:0]  ADRS;          // wire to save address Obtained from the control word. Also this wire will be used to send address to CARMUx1MUx2 
	                            //instantiation
   wire [ 3:0]  MISC;

	wire [ 7:0] ADDR_in;       // wire to give input address to the MicroCODE ROM instantiation
	
	wire CLK;
	wire [7:0]DATA_I;         // 8 bit input wire
	wire [7:0]DATA_O;          // 8 bit output wire
	wire [13:0]data_0;          // 8 bit output wire
	wire [23:0]DEBUG;          // 24 bit Output Debug line wire which will be used for displaying flags and CAR
	reg [23:0]DEBUGr;          // 24 bit Output Debug line wire which will be used for displaying flags and CAR. Mainly to give output to the  flags
	wire [7:0]CAR;             // wire to send CAR
	wire [3:0]DSELo;
	wire [6:0]dselo;
	wire [2:0]temp;
   wire [1:0]led;               


	
	reg Z,S,C,V;              //CPU unit flags wires
	wire z,s,c,v;             //Processor UNIT flags wires

	wire CO;                  // processor unit (shifter) carry out wire

   assign                 ASEL = DATA_out[31:29];    // bit size:3
   assign                 BSEL = DATA_out[28:26];    // bit size:3
   assign                 DSEL = DATA_out[25:23];    // bit size:3
   assign                 SSEL = DATA_out[22:19];    // bit size:4
   assign                 HSEL = DATA_out[18:16];    // bit size:3
   assign                 MUX1 = DATA_out[15];       // bit size:1
   assign                 MUX2 = DATA_out[14:12];    // bit size:3
   assign                 ADRS = DATA_out[11: 4];    // bit size:8
   assign                 MISC = DATA_out[ 3: 0];    // bit size:4
	//register is transferred to wire. Reason for this is that this bit needs to connected to the output pins 
	assign 					  DEBUG[23] = DEBUGr[23];   //register is transferred to wire. Reason for this is that this bit needs to connected to the output pins 
	assign 					  DEBUG[22] = DEBUGr[22];
	assign 					  DEBUG[21] = DEBUGr[21] ;
	assign 					  DEBUG[20] = DEBUGr[20];
   assign                 DSELo[3:1] = DSEL[2:0];
	assign                 DSELo[0] = 1'b0;
	assign                 temp[2:0] = 3'b111;
	assign                 led[1:0] = 1'b00;


	
 	
microcode_rom microcode_rom_inst     // MicrocodeRom Instantiation
(
	.ADDR_in(CAR) ,	// input [7:0] ADDR_in_sig
	.DATA_out(DATA_out) 	// output [31:0] DATA_out_sig
);
	
	
processorUnit processorUnit_inst     //Processor unit Instantiation
(
	.CLK(CLK) ,	// input  CLK_sig
	.DATA_I(DATA_I) ,	// input [7:0] DATA_I_sig
	.ASEL(ASEL) ,	// input [2:0] ASEL_sig
	.BSEL(BSEL) ,	// input [2:0] BSEL_sig
	.DSEL(DSEL) ,	// input [2:0] DSEL_sig
	.SSEL(SSEL) ,	// input [3:0] SSEL_sig
	.HSEL(HSEL) ,	// input [2:0] HSEL_sig
	.DATA_O(DATA_O) ,	// output [7:0] DATA_O_sig
	.z(z) ,	// output  z_sig
	.s(s) ,	// output  s_sig
	.c(c) ,	// output  c_sig
	.v(v) ,	// output  v_sig
	.CO(CO) 	// output  CO_sig
);

carMux1Mux2 carMux1Mux2_inst    //Car MUX1 MUX2 Instantiation
(
	.clk(CLK) ,	// input  clk_sig
	.Z(Z) ,	// input  Z_sig
	.S(S) ,	// input  S_sig
	.C(C) ,	// input  C_sig
	.V(V) ,	// input  V_sig
	.internalAddress(ADRS) ,	// input [7:0] internalAddress_sig
	.externalAddress(8'b00000000) ,	// input [7:0] externalAddress_sig
	.mux1Select(MUX1) ,	// input  mux1Select_sig
	.mux2Select(MUX2) ,	// input [2:0] mux2Select_sig
	.outputAddress(CAR) 	// output [7:0] outputAddress_sig
);


//to display Upper nibble of CAR on seven segment display
SevenSegmentDecoder SevenSegmentDecoder_inst1
(
	.INP(CAR[7:4]) ,	// input [3:0] INP_sig
	.SEG(DEBUG[19:13]) 	// output [0:6] SEG_sig
);

//to display lowerr nibble of CAR on seven segment display
SevenSegmentDecoder SevenSegmentDecoder_inst2
(
	.INP(CAR[3:0]) ,	// input [3:0] INP_sig
	.SEG(DEBUG[12:6]) 	// output [0:6] SEG_sig
);

SevenSegmentDecoder SevenSegmentDecoder_inst3
(
	.INP(DATA_O[7:4]) ,	// input [3:0] INP_sig
	.SEG(data_0[13:7]) 	// output [0:6] SEG_sig
);

SevenSegmentDecoder SevenSegmentDecoder_inst4
(
	.INP(DATA_O[3:0]) ,	// input [3:0] INP_sig
	.SEG(data_0[6:0]) 	// output [0:6] SEG_sig
);

SevenSegmentDecoder SevenSegmentDecoder_inst5
(
	.INP(DSELo[3:0]) ,	// input [3:0] INP_sig
	.SEG(dselo[6:0]) 	// output [0:6] SEG_sig
);



//logic of  "Shifter Updating of the C flag should take precedence over the ALU updating"
always @(DATA_O)  // always block loop to execute over and over again

begin
	case (HSEL)       		// The case statement compares HSEL to a series of cases and
									//	executes the statement associated with the first matching case
		3'b100:begin    		//if rotate operatipon with carry is selected
						C = CO;  // Shifter carry is transfered to CPU carry
						S = s;	// Rest are ALU flags
						Z= z;
						V=v;
				 end	
      3'b111: begin        //if rotate operatipon with carry is selected
						C = CO;  // Shifter carry is transfered to CPU carry
						S = s;   // Rest are ALU flags
						Z= z;
						V=v;
				  end	
	   default:begin        //For all other Shifter operations
						C = c;   // transfer ALU flags to CPU flags
						S = s;
						Z = z;
						V = v;
				  end	
		 
	endcase;
	  
	DEBUGr[23] = ~Z;     // Complementing flags to display on seven segment display (common anode ).
	DEBUGr[22] = ~S;
	DEBUGr[21] = ~C;
	DEBUGr[20] = ~V;
end


endmodule
