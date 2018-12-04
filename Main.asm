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
	
	AND R1,R1,#0
	STI R1,buffer

; start of actual program
loop
	LDI   R0,buffer
	BRz   loop
	TRAP  x21
	AND R1,R1,#0
	STI R1,buffer
	BRnzp loop
	TRAP x25

pointer	.FILL x4000
intrloc	.FILL x2600
ivt	.FILL x0180
kbsrloc	.FILL xFE00
intenable	.FILL x4000
buffer  .FILL x4600
		.END
