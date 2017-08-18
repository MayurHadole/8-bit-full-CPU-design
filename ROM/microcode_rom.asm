;;; Simple CPU microcode file.
;;; Includes the example microcode for our CPU

;;; Desired number of Address bits
DEPTH:	.equ 8			;

	
;;; Field Definitions

ASEL:	.field	3		; Right input of ALU
BSEL:	.field	3		; Left inpt of ALU
DSEL:	.field	3		; Destination Register
SSEL:	.field  4		; ALU operation
HSEL:	.field	3		; Shifter operation
MUX1:	.field	1		; Next Address Select
MUX2:	.field	3		; Load/Increment select
ADRS:	.field  DEPTH		; Address field
MISC:	.field	4		; Misc Field
	
;;; Constant definitions
;;; ASEL, BSEL, DSEL fields
INP:	.equ	000b		; Select Input port
NONE:	.equ	000b		; No register write
R1:	.equ	001b		; Register 1
R2:	.equ	010b		; Register 2
R3:	.equ	011b		; Register 3
R4:	.equ	100b		; Register 4
R5:	.equ	101b		; Register 5
R6:	.equ	110b		; Register 6
R7:	.equ	111b		; Register 7

;;; SSEL ALU Selection Field 
;;; 			Flags Affected
;;; 			 Z S C V	Function
TSF:	.equ	0000b ;  N N N N	Transfer A 
INC:	.equ	0001b ;  Y Y N N	Increment A by one
ADD:	.equ	0010b ;	 Y Y Y Y	Add A+B
SUB:	.equ	0101b ;	 Y Y Y Y	Subtract A-B
DEC:	.equ	0110b ;	 Y Y N N	Decrement A by one
TRC:	.equ	0111b ;	 Y Y 0 N	Transfer A and Carry=0
AND:	.equ	1000b ;	 Y Y N N	A AND B
OR:	.equ	1010b ;	 Y Y N N	A OR B
XOR:	.equ	1100b ;	 Y Y N N	A Exclusive OR B
COM:	.equ	1110b ;	 Y Y N N	Complement A

	;
;;; HSEL Shifter Selection Field 
;;; 			Function
NSH:	.equ	000b ; 	No Shift
SHL:	.equ	001b ; 	Shift Left
SHR:	.equ	010b ;  Shift Right
ZERO:	.equ	011b ; 	All Zero's in output
RLC:	.equ	100b ; 	Rotate left with carry
ROL:	.equ	101b ; 	Rotate left
ROR:	.equ	110b ; 	Rotate right
RRC:	.equ	111b ; 	Rotate right with carry

;;; MUX1 Field 
;;; 			Function
INT:	.equ    0b   ; Internal Address
EXT:	.equ	1b   ; External Address

;;; MUX2 Field
;;; 			Function
NEXT:	.equ 000b ; 	Go to next address by incrementing CAR
LAD:	.equ 001b ; 	Load address into CAR (Branch)
LC:	.equ 010b ; 	Load on Carry = 1
LNC:	.equ 011b ; 	Load on Carry = 0
LZ:	.equ 100b ; 	Load on Zero = 1
LNZ:	.equ 101b ; 	Load on Zero = 0
LS:	.equ 110b ; 	Load on Sign = 1
LV:	.equ 111b ; 	Load on Overflow = 1	

;;; MISC Field
READ:	.equ 0001b ; Read Memory
WRITE:	.equ 0010b ; Write Memory
LDMAR:	.equ 0100b ; Load MAR
LDIR:	.equ 1000b ; Load IR
FETCH:	.equ 1001b ; Read an instruction into IR
DEREF:	.equ 0101b ; Read mem, and load MAR

	.module "microcode_rom"	;

	.org 0			;

START:	INP \ -  \ R1   \ TSF \ NSH \ INT  \ NEXT \ -    \ - ;
		R1  \ -  \ R2    \ INC \ NSH \ INT \ NEXT \ -    \ - ;
		R4  \ R5  \ R2   \ ADD \ NSH \INT  \ NEXT \ -    \ - ;
		R4  \ R5  \ R2   \ SUB \ NSH \INT  \ NEXT \ -    \ - ;
		R2  \ - \ R2   \ DEC \  NSH \ INT   \ NEXT \ -    \ - ;   
		R2  \ -  \ R1   \ TRC \ NSH \ INT  \ NEXT  \ -\ - ;
		R5  \ R4  \ R2 \ AND \ NSH \ INT \ NEXT \ -   \ - ;
		R5  \ R4  \ R2 \ OR \ NSH \ INT \ NEXT \ -   \ - ;
		R5  \ R4  \ R2 \ XOR \ NSH \ INT \ NEXT \ -   \ - ;
		R6  \  -  \ R2 \ COM \ NSH \ INT \ NEXT \ - \ - ;
		R7  \ -  \ R2 \ TSF \ NSH \ INT \ NEXT \ -   \ - ;
		R7  \ -  \ R2 \ TSF \ SHL \ INT \ NEXT \ -   \ - ;
		R7  \ -  \ R2 \ TSF \ SHR \ INT \ NEXT \ -   \ - ;
		R2  \ -  \ R2 \ TSF \ ZERO \ INT \ NEXT \ -   \ - ;
		R4  \ R5  \ R2 \ ADD \ RLC \ INT \ NEXT \ -   \ - ;
		R2  \ R5  \ R2 \ TSF \ RLC \ INT \ NEXT \ -   \ - ;
		R2  \ -  \ R2 \ TSF \ ROL \ INT \ NEXT \ -   \ - ;
		R7  \ -  \ R2 \ TSF \ ROR \ INT \ NEXT \ -   \ - ;
		R4  \ R5  \ R2 \ ADD \ RRC \ INT \ NEXT \ -  \ - ;
		R2  \ -  \ R2 \ TSF \ RRC \ INT \ LAD \ START   \ - ;



	
	.org ((1<<DEPTH)-1) 	; Ensure we have at least 8 address bits
	- \ - \ - \ - \ - \ - \ - \ - \ - ;
	.end 			;
