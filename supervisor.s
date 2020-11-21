;-----------------------------------------------
; Task Queue Controller 
; 1. Check current Task
; 2. Run
; 3. [Remove tast, Shift Queue]
;-----------------------------------------------

Supervisor::
	PUSHW X
	PUSH A
	;Check current [ptr] task
	LDW X, Queue
	ADDW X, QueuePtr
	LD A, (X)
	;IF not 0xFF -> real task (shift queue)
	CP A, #0xFF
	JREQ RunCurrent
NeedRemove:
	CALL RemoveTask	
RunCurrent:
	;In A save Num. Task
	CALL RunTask
	;Exit after running
	POP A
	POPW X
	RET		
