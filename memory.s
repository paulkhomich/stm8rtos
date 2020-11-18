;-----------------------
; Tasks Queue
;-----------------------
QueueSize:
.ds	0x1
QueuePtr:
.ds	0x1
QueueOverflow:
.ds	0x1
Queue:
.ds	QUEUE_CAPACITY

;-----------------------
; Timers Queue
;-----------------------
PTimersSize:
.ds	0x1
PTimersOverflow:
.ds	0x1
PTimers:
.blk3	PTIMERS_CAPACITY
