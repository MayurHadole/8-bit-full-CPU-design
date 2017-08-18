
/*File          : SevenSegmentDecoder.v 
--Group         : Group 8
--Programmers   : Mayur Hadole(7475783) & Rohit Bhardwaj (7639651)
--Version       : 1.0  (May 10 , 2017)
--Hardware used : Cyclone V (DE1 SoC)
--Software used : Quartus II 15 64 bit
--Description   : This program implements binary to seven segment decoder on DE1 SoC board using Verilog

-- code is working and is tested on board

*/

module SevenSegmentDecoder(INP, SEG); //Module names and I/o pins are declared
input   [3:0] INP;            // 4 bit input which is connected to 4 switches
output  [0:6] SEG;            // 8 bit output which is connected to seven segment display
reg     [0:6] SEG;            // 7 bit register to save the seven segment code 
always @(INP)                 //always block loop to execute over and over again
begin								   // start of the code block which will be always executed
	case(INP)
		
                                           //The case statement compares INP  to a series of cases and
                                           //	executes the statement associated with the first matching case
		4'b0000: SEG = 7'b0000001; // "0"
		4'b0001: SEG = 7'b1001111; // "1"
		4'b0010: SEG = 7'b0010010; // "2"
		4'b0011: SEG = 7'b0000110; // "3"
		4'b0100: SEG = 7'b1001100; // "4"
		4'b0101: SEG = 7'b0100100; // "5"
		4'b0110: SEG = 7'b0100000; // "6"
		4'b0111: SEG = 7'b0001111; // "7"
		4'b1000: SEG = 7'b0000000; // "8"
		4'b1001: SEG = 7'b0001100; // "9"
		4'b1010: SEG = 7'b0001000; // "A"
		4'b1011: SEG = 7'b1100000; // "B"
		4'b1100: SEG = 7'b0110001; // "C"
		4'b1101: SEG = 7'b1000010; // "D"
		4'b1110: SEG = 7'b0110000; // "E"
		4'b1111: SEG = 7'b0111000; // "F"
		default: SEG = 7'bXXXXXXX;
	endcase;
end
endmodule
