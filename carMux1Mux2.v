/*File          : ALU.v 
--Group         : Group 8
--Programmers   : Mayur Hadole(7475783)
					
--Hardware used : Cyclone V (DE1 SoC)
--Software used : Quartus II 15 64 bit
--Description   : This program implements MUX1, MUX2 and Control word Logic. Basically it selects which will be the next control word to be executed
--Version       : 1.0  (June 21  , 2017)  Mux1 , mux 2  and CAR logic are implemented
						
-- code is working and is tested on board
*/



module carMux1Mux2(clk,Z,S,C,V,internalAddress,externalAddress,mux1Select,mux2Select,outputAddress);  //Module names and I/o pins are declared


input clk;
input Z,S,C,V;   								// flags
input [7:0] internalAddress;				//internal address to be fed to the MUX 1
input [7:0] externalAddress;           //external address to be fed to the MUX 1
input mux1Select;								//MUX 1 select obtained from control word
input [2:0] mux2Select;						//MUX 2 select obtained from control word
output [7:0] outputAddress;            // Output address which will be used to send to microcode ROM

wire [7:0] internalAddress;				//internal address wire to be fed to the MUX 1	
wire [7:0] externalAddress;				//external address wire to be fed to the MUX 2
wire mux1Select;								//MUX 1 select wire obtained from control word
wire [2:0] mux2Select;						//MUX 2 select wire obtained from control word
reg [7:0] outputAddress;					//Also defined as register because needs to connected to the output port
reg [7:0] MUX1Output;                  // register to save output of MUX 1
reg MUX2Output;                        // register to save output of MUX 2
reg [7:0] CAR;      							//Control Address Register               
reg [7:0] CARnext;							//CAR having +1 address of CAR  

always @(posedge clk)									// always block loop to execute over and over again
begin
	case (mux1Select)                            //Selects internal address if MUX 1 Select is Zero. Else, external address is selected 
		1'b0 : MUX1Output = internalAddress;			
		1'b1 : MUX1Output = externalAddress;                          
	endcase;
	
	case (mux2Select)                  // MUX 2
		3'b000 : MUX2Output = 0;        // NEXT  :Go to next address by incrementing CAR
		3'b001 : MUX2Output = 1;		  // LAD   :Load address into CAR (Branch)
		3'b010 : MUX2Output = C;		  // LC    :Load on Carry = 1
		3'b011 : MUX2Output = ~C;		  // LNC	  :Load on Carry = 0
		3'b100 : MUX2Output = Z;		  // LZ	  :Load on Zero = 1
		3'b101 : MUX2Output = ~Z;		  // LNZ	  :Load on Zero = 0
		3'b110 : MUX2Output = S;		  // LS	  :Load on Sign = 1
		3'b111 : MUX2Output = V;		  // LV	  :Load on Overflow = 1
	endcase;
	
	case( MUX2Output)        			//if MUX 2 Output is zero then increment CAR by 1 else keep it as it is
		1'b0 : begin
					CARnext = CAR + 1;
					CAR = CARnext;
				 end		
		1'b1 : CAR = MUX1Output;
	endcase
	outputAddress = CAR;   // sending CAR to the Output address port
end


endmodule
