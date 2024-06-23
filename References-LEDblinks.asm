	ORG	8000H		;initialize 8085A uP
	JMP	START		;main at START

	ORG	8100H		;initialize Stack Pointer, SP
START:	LXI	SP,0F000H	;load data into SP
RPT:	
	MVI	A, 00001111B	;all I3-I0 disabled, Out3-0 lights on
	OUT	00H		;go to PORT 00H --> GPIO
	CALL	DELAY		
	MVI	A, 00H		;all I3-I0 disabled, Out3-0 lights off
	OUT	00H		;go to PORT 00H --> GPIO
	CALL	DELAY		
	JMP	RPT		;continuous looping
	HLT

DELAY:	LXI	D, 0FF01H	;LSB (FFH) MSB(01H) --> If MSB to high,
	RST	1		;loop too long
	RET	
