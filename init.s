Init:
	MOV QueueSize,		#0x0
	MOV QueuePtr,		#0x0
	MOV QueueOverflow,	#0x0

	MOV PTimersSize,	#0x0
	MOV PTimersOverflow,	#0x0
	;Stack init
	LDW X, #RAMEND
	LDW SP, X	

	LD A, #0xFF
	;Queue init all items with 0xFF
	LDW X, #Queue
	LDW Y, #QUEUE_CAPACITY 
QueueInitLoop:
	TNZW Y
	JREQ QueueInitEnd
	LD (X), A
	INCW X
	DECW Y
	JP QueueInitLoop
QueueInitEnd:
	 
	;PTimers init all items with {0xFF,0xFF,0xFF}
	LDW X, #PTimers
	LDW Y, #PTIMERS_CAPACITY
PTimersInitLoop:
	TNZW Y
	JREQ PTimersInitEnd
	LD (X), A
	INCW X
	LD (X), A
	INCW X
	LD (X), A
	DECW Y
	JP PTimersInitLoop
PTimersInitEnd:
	JP Main	
