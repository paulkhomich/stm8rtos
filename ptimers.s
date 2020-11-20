TickPTimers::
	;Save A & X
	PUSH A
	PUSHW X
	PUSHW Y
	;Check size (if 0 -> runaway)
	LD A, PTimersSize
	JRNE PTimersExist
PTimersEmpty:
	POPW Y
	POPW X
	POP A
	RET
PTimersExist:
	;Go throw all PTimersQuene
	;DEC Time + Run Task (if Time == 0)
	LDW X, #PTimers
	LDW Y, #PTIMERS_CAPACITY	
TickLoop:
	TNZW Y
	JREQ AllDone
	;Check Num. (!FF -> DEC Time)	
	LD A, (X)
	CP A, 0xFF ;TODO
	JREQ NextPTimer
MakeTick:
	PUSHW Y
	INCW X
	LD A, (X)
	LD YH, A
	INCW X
	LD A, (X)
	LD YL, A
	DECW Y
	JREQ Timeout
DecTick:
	LD A, YL
	LD (X), A
	DECW X
	LD A, YH
	LD (X), A
	DECW X
	POPW Y
	JRA NextPTimer
Timeout:
	POPW Y
	DECW X
	DECW X
	;Num. Task -> A
	LD A, (X)
	PUSH A
	LD A, #0xFF ;TODO
	;Reset Num. Task (Empty PTimer)
	LD (X), A
	POP A
	CALL AddTask	
NextPTimer:
	;+3 to PTimers pointer (next PTimer)
	INCW X ;TODO
	INCW X
	INCW X
	DECW Y
	JRA TickLoop
AllDone:
	NOP
