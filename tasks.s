Idle::
	NOP
	NOP
	RET

Light::
;	BCPL PE_ODR, #0x5
	LD A, #0x01
	LDW Y, #0x0300
	CALL AddPTimer	
	RET

