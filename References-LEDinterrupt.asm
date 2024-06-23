	ORG	8000H		;initialize 8085A uP
	JMP	START		;main at START
	ORG	802CH		;8000H + 2CH <-
	JMP	ISR55		;RST5.5 -> 5.5*8=44 -> 2CH

	ORG	8100H		;initialize Stack Pointer, SP
START:	LXI	SP,0F000H	;load data into SP
	MVI	A, 00011110B	;0001 1(7.5)(6.5)(5.5)
	SIM			;1 = Cannot Use, 0 = Can Use
	EI
RPT:	
	MVI	A, 00001111B	;all I3-I0 disabled, Out3-0 lights on
	OUT	00H		;go to PORT 00H --> GPIO
	CALL	DELAY		
	MVI	A, 00H		;all I3-I0 disabled, Out3-0 lights off
	OUT	00H		;go to PORT 00H --> GPIO
	CALL	DELAY		
	JMP	RPT		;continuous looping
	HLT

DELAY:	LXI	D, 0FF01H
	RST	1
	RET	

ISR55:	MVI	A, 00001010B	;all I3-I0 disabled, Out3/1 lights on
	OUT	00H		;go to PORT 00H --> GPIO
	CALL	DELAY		
	MVI	A, 00H		;all I3-I0 disabled, Out3-0 lights off
	OUT	00H		;go to PORT 00H --> GPIO
	CALL	DELAY
	MVI	A, 00000101B	;all I3-I0 disabled, Out2/0 lights on
	OUT	00H		;go to PORT 00H --> GPIO
	CALL	DELAY
	EI			;Need to EI to using it again
	RET
