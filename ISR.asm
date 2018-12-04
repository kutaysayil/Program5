; ISR.asm
; Name: Kutay Sayil & Cypher Miller
; UTEid: ks48624	cam7937
; Keyboard ISR runs when a key is struck
; Checks for a valid RNA symbol and places it at x4600


               .ORIG x2600

	ST R0, saveR0
	ST R1, saveR1

	LDI R0, kbDR
	LD R1, letterA
	ADD R1, R0, R1
	BRz validval

	LD R1, letterC
	ADD R1, R0, R1
	BRz validval

	LD R1, letterG
	ADD R1, R0, R1
	BRz validval

	LD R1, letterU
	ADD R1, R0, R1
	BRz validval


	BRnzp end

validval

	STI R0, globalloc



end	LD R0, saveR0
	LD R1, saveR1


	RTI


saveR0	.BLKW 1
saveR1	.BLKW 1

globalloc	.FILL x4600

letterA	.FILL -65
letterC	.FILL -67
letterG	.FILL -71
letterU	.FILL -85
kbDR	.FILL xFE02			



		.END	
