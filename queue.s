;---------------------------------------
; Add Task to Queue
; A <- Task Num.
;---------------------------------------
AddTask::
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
	CLRW X
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
; Remove From Queue (Shift)
;---------------------------------------
RemoveTask::
	;Save A
	PUSH A
	;Ptr >>> 1
	LD A, QueuePtr
	INC A
	SUB A, #QUEUE_CAPACITY
	JREQ RemoveTaskCircle
RemoveTaskLinear:
	ADD A, #QUEUE_CAPACITY
RemoveTaskCircle:
	;Now save new Ptr
	LD QueuePtr, A
	DEC QueueSize
	;Restore A
	POP A

	RET
	
;---------------------------------------
; Run Task
; A <- Task Num.
;---------------------------------------
RunTask::
	;Save A & Y
	PUSH A
	PUSHW Y
	;Find Task addr. by num. 
	;x2 (2-bit addr.)
	SLL A
	CLRW Y
	LD YL, A
	;Load H
	LD A, (#TasksTable, Y)
	LD XH, A
	;Load L
	INCW Y
	LD A, (#TasksTable, Y)
	LD XL, A
	;Now in X - task addr.
	;Restore A & Y
	POPW Y
	POP A
	;Go to task
	JP (X)		









