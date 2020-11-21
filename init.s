Init::
	;Init RAM
	MOV QueueSize,		#0x0
	MOV QueuePtr,		#0x0
	MOV QueueOverflow,	#0x0

	MOV PTimersSize,	#0x0
	MOV PTimersOverflow,	#0x0
	
	;Init Interrupts
	RIM

	;Init CLK freq (fMASTER = fCPU = fHSI = 16MHz) max
	MOV CLK_CKDIVR, #0x00

	;Init TIM2 timer (for 1ms interval)
	;16MHz ->(/8 prescale)-> 2MHz ->(/2k counter ARR)-> 1KHz
	MOV TIM2_PSCR, #0x08		;Prescale = 8
	MOV TIM2_ARRH, #0x07		;ARR=2000
	MOV TIM2_ARRL, #0xD0
	BSET TIM2_IER,  #0x0		;Interrupt Update ON
	BSET TIM2_CR1,  #0x0		;Run TIM2

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
	JRA QueueInitLoop
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
	JRA PTimersInitLoop
PTimersInitEnd:
	JP Main	
