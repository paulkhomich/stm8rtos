;-------------------------------
; Kernel: Macros && Constants 
; + need hardware
;-------------------------------
.gblequ RAMEND,			#0x07FF

;CAPACITY MAX 0xFF both
.gblequ QUEUE_CAPACITY,		#0x0020
.gblequ PTIMERS_CAPACITY,	#0x0020








; HARDWARE
.gblequ CLK_CKDIVR,     0x50C6
.gblequ TIM2_CR1,       0x5300
.gblequ TIM2_IER,       0x5301
.gblequ TIM2_SR1,	0x5302
.gblequ TIM2_PSCR,      0x530C
.gblequ TIM2_ARRH,      0x530D
.gblequ TIM2_ARRL,      0x530E
