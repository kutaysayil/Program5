; Main.asm
; Name: Kutay Sayil & Cypher Miller
; UTEid: ks48624	cam7937
; Continuously reads from x4600 making sure its not reading duplicate
; symbols. Processes the symbol based on the program description
; of mRNA processing.
               .ORIG x4000
; initialize the stack pointer
	AND R6, R6, #0
	LD R6, pointer

; set up the keyboard interrupt vector table entry
	LD R0, intrloc
	STI R0, ivt


; enable keyboard interrupts
	LD R0, intenable
	STI R0, kbsrloc
	
	AND R4, R4, #0	;clears R4
	AND R3, R3, #0	;clear counter r3
	AND R1, R1, #0
	STI R1, buffer

; start of actual program
loop
	LDI   R0, buffer
	BRz   loop
	TRAP  x21
	AND R1, R1, #0
	STI R1, buffer
	ADD R3, R3, -1
	BRn TrueA
	BRz TrueU
	BRp TrueG
	BRnzp loop    ;if previously unbranched, loop back



TrueA 
	LD R2, lettermA
	ADD R2, R0, R2	;tests to see if equal to A
	BRnp #2
	AND R3, R3, #0
	ADD R3, R3, #1	;change R3 to one
	BRnzp loop

TrueU
	LD R2, lettermU
	ADD R2, R0, R2	;tests to see if equal to U
	BRnp TrueA
	AND R3, R3, #0
	ADD R3, R3, #2	;change R3 to two
	BRnzp loop

TrueG 
	LD R2, lettermG
	ADD R2, R0, R2	;tests to see if equal to G
	BRnp TrueA
	AND R3, R3, #0
	LD R0, bar
	TRAP x21   	;prints character to console
	BRnzp part2
	BRnzp loop



part2	

	LDI   R0, buffer
	BRz   part2
	TRAP  x21
	AND R1, R1, #0
	STI R1, buffer
	ADD R3, R3, -1
	BRn TrueU2
	BRz TrueAG
	ADD R4, R4, #-1
	BRz test3A	;takes branch if A
	BRnzp test3G	;takes branch if G


TrueU2
	LD R2, lettermU
	ADD R2, R0, R2	;tests to see if equal to U
	BRnp #2
	AND R3, R3, #0
	ADD R3, R3, #1	;change R3 to one
	BRnzp part2

TrueAG
	LD R2, lettermA
	ADD R2, R0, R2	;tests to see if equal to A
	BRz secondA
	LD R2, lettermG
	ADD R2, R0, R2	;tests to see if equal to G
	BRz secondG
	BRnzp part2

secondA		;if equal to A
	AND R4, R4, #0
	ADD R4, R4, #1	;R4 equal 1
	AND R3, R3, #0
	ADD R3, R3, #2	;change R3 to two
	BRnzp part2

secondG		;if equal to G
	AND R4, R4, #0
	ADD R4, R4, #2	;R4 equal 2
	AND R3, R3, #0
	ADD R3, R3, #2	;change R3 to two
	BRnzp part2

test3A
	LD R2, lettermA   ;checking if A
	ADD R2, R0, R2
	BRz finish
	
	LD R2, lettermG   ;checking if G
	ADD R2, R0, R2
	BRz finish
	
	LD R2, lettermU   ;checking if U
	ADD R2, R0, R2
	BRz holdu

	AND R3, R3, #0
		
	
holdu	BRnzp part2   ;go to part2
	

test3G	

	LD R2, lettermA   ;checking if A
	ADD R2, R0, R2
	BRz finish
	
	
	LD R2, lettermU	  ;checking if U
	ADD R2, R0, R2
	BRz holdu

	AND R3, R3, #0
	BRnzp part2

finish


	TRAP x25 


lettermA	.FILL -65
lettermG	.FILL -71
lettermU	.FILL -85
pointer		.FILL x4000
intrloc		.FILL x2600
ivt		.FILL x0180
kbsrloc		.FILL xFE00
intenable	.FILL x4000
buffer  	.FILL x4600
bar		.FILL 124
		.END  