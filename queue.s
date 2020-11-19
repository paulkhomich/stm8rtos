;---------------------------------------
; Add Task to Queue
; A <- Task Num.
;---------------------------------------
AddToQueue:
	;Save A(num) & X register
	PUSHW X
	PUSH A
	;Check Queue size (enough space?)
	LD A, QueueSize
	SUB A, #QUEUE_CAPACITY
	JRMI QueueHaveSpace
QueueFull:
	MOV QueueOverflow, #0xFF
	POP A
	POPW X
	RET	
QueueHaveSpace:
	LDW X, #0x0000
	ADDW X, QueuePtr
	ADDW X, QueueSize
	SUBW X, #QUEUE_CAPACITY
	JRPL QueueCircle
QueueLinear:
	ADDW X, #QUEUE_CAPACITY
QueueCircle:
	;Now place on (X) new value
	POP A
	LD (X), A
	INC QueueSize
	;Restore X
	POPW X

	RET

;---------------------------------------
; Delete From Queue
;---------------------------------------
DeleteFromQueue:
	;Save A
	PUSH A
	;Ptr >>> 1
	LD A, QueuePtr
	INC A
	SUB A, #QUEUE_CAPACITY
	JREQ DeleteFromQueueCircle
DeleteFromQueueLinear:
	ADD A, #QUEUE_CAPACITY
DeleteFromQueueCircle:
	;Now save new Ptr
	LD QueuePtr, A
	DEC QueueSize
	;Restore A
	POP A

	RET
	
	









