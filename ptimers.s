;---------------------------------------
; Make PTimers Tick (dec clock value)
; + AddTask in Queue (if time==0)
;---------------------------------------
TickPTimers::
	;Save A & X & Y
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
	;Size--
	DEC PTimersSize
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
	INCW X 
	INCW X
	INCW X
	DECW Y
	JRA TickLoop
AllDone:
	POPW Y
	POPW X
	POP A
	RET

;---------------------------------------
; Add PTimer to PTimers Queue
; A <- Num. Task
; Y <- Time  
;---------------------------------------
AddPTimer::
	;Save A & X
	PUSHW X
	PUSH A
	;Check size
	LD A, PTimersSize	
	CP A, #PTIMERS_CAPACITY
	JRNE PTimersCanAdd
PTimersFull:
	;PTimers Queue is Full
	MOV PTimersOverflow, #0xFF
	POP A
	POPW X
	RET 
PTimersCanAdd:
	;X <- PTimers Queue location
	LDW X, #PTimers
	;Find empty place (it's exist^)
SearchLoop:
	LD A, (X)
	CP A, #0xFF
	JREQ Placing
NextSearch:
	INCW X
	INCW X
	JRA SearchLoop
Placing:
	;Restore Num. Task
	POP A
	;Place it in num. position
	LD (X), A
	PUSH A
	;Place time H, L
	INCW X
	LD A, YH
	LD (X), A
	INCW X
	LD A, YL
	LD (X), A
	;Size++
	INC PTimersSize
	;Restore 
	POP A
	POPW X
	RET








