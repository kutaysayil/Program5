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
	
	AND R3, R3, #0	;clear counter r3
	AND R1,R1,#0
	STI R1,buffer

; start of actual program
loop
	LDI   R0,buffer
	BRz   loop
	TRAP  x21
	AND R1,R1,#0
	STI R1,buffer
	ADD R3, R3, -1
	BRn TrueA
	;BRz TrueU
	;BRp TrueG
	BRnzp loop



TrueA 
	LD R2, lettermA
	ADD R2, R0, R2	;tests to see if equal to A
	BRnp #2
	AND R3, R3, #0
	ADD R3, R3, #1	;change R3 to one
	BRnzp loop
	TRAP x25

lettermA	.FILL -65
lettermG	.FILL -71
lettermU	.FILL -85
pointer	.FILL x4000
intrloc	.FILL x2600
ivt	.FILL x0180
kbsrloc	.FILL xFE00
intenable	.FILL x4000
buffer  .FILL x4600
		.END  ;ends
