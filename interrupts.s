TIM2_Tick::
	BRES TIM2_SR1, #0x0
	CALL TickPTimers	
	IRET
