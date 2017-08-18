/*File          : ALU.v 
--Group         : Group 8
--Programmers   : Mayur Hadole(7475783) & Rohit Bhardwaj (7639651)
--Version       : 1.0  (May 26 , 2017)
--Hardware used : Cyclone V (DE1 SoC)
--Software used : Quartus II 15 64 bit
--Description   : This program implements 8 bit ALU on DE1 SoC board using Verilog

-- code is working and is tested on board
*/


module ALU(A,B,F,SSEL,Z,S,C,V);             // Module names and I/o pins are declared

input [7:0] A;                              // Input Bus A
input [7:0] B;									     // Input Bus B
input [3:0] SSEL;									  // ALU operatipon Select (Input)

output [7:0] F;								     // Funtion Output
output Z;                                   // zero flag
output S;                                   // Sign flag
output C;                                   // Carry flag
output V;                                   // Overflow flag      

reg [7:0] accumulator;                      // 8 bit register to save the data of accumulator 
reg [8:0] aluadd;                           // 9 bit register to save the data of aluadd 
reg [7:0] F;                                // 8 bit register to save the data of  function output  
reg add_ov;                                 // Register to save the data of add_ov
reg sub_ov;                                 // Register to save the data of sub_ov
reg Z,S,C,V;                                // Registers to save the data of flags

always @(SSEL,A,B)    // always block loop to execute over and over again

begin             // start of the code block which will be always executed
	case (SSEL)    // The case statement compares SSEL to a series of cases and
	               //	executes the statement associated with the first matching case
      4'b0000 : accumulator = A;	           // Transfer input A to F
		4'b0001 : accumulator = A + 1;        // Increment A by one
		4'b0010 : begin
						 accumulator = A + B;     // Add A and B
						 aluadd = ({1'b0,A}) + ({1'b0,B});       // concatinate  A and B with 0 to make inputs 9 bit
					 end
		4'b0101 : begin
						 accumulator = A - B;     // Subtract A-B    
						 aluadd = ({1'b0,A}) - ({1'b0,B});       // concatinate  A and B with 0 to make inputs 9 bit
				    end
		4'b0110 : accumulator = A - 1;        // Decrement A by one 
		4'b0111 : begin 
						accumulator = A;          // Transfer A & Carry = 0
						C = 0;
					 end
		4'b1000 : accumulator = A & B;        // AND gate 
		4'b1010 : accumulator = A | B;        // OR gate
		4'b1100 : accumulator = A ^ B;        // EXOR gate
		4'b1110 : accumulator = ~A;           // NOT gate
	endcase;
	
	case (SSEL)                              // To determine carry bit
      4'b0010 : C = aluadd[8];	           // 9th bit of the result will be carry bit for addition
		4'b0101 : C = aluadd[8];              // 9th bit of the result will be carry bit for subtraction
		default : C = 0;
	endcase;
	
	// Overflow can only happen when "adding" two numbers of the same sign and
   // getting a different sign.  So, to detect overflow we don't care about
   //any bits except the sign bits
	//add_ov = (A[7] & B[7] & (~accumulator[7])) |  ((~A[7]) & (~B[7]) & accumulator[7]);
	//sub_ov = (A[7] & (~B[7]) & (~accumulator[7])) |  ((~A[7]) & B[7] & accumulator[7]);
	
	case (SSEL)                              // To determine overflow bit
      4'b0010 : V = aluadd[8];
					
						//V = add_ov;	
		4'b0101 : V = aluadd[8];
		default : V = 0;
	endcase;
	
	if (accumulator == 0000000) begin        // To determine zero flag
		Z = 1;
	end
   else begin
		Z = 0;
   end 
	
	F = accumulator;
   S = accumulator[7];                      // To determine sign flag

end
endmodule
	



