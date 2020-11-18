.include "define.s"

		.area DATA
		.area SSEG
		.area HOME
			.area VECTORS
			.area INIT
			.area CONSTANTS
		.area CODE
			.area KERNEL
			.area TASKS

.area DATA
.include "memory.s"

.area HOME
.area VECTORS
.include "vectors.s"
.area INIT
.include "init.s"

.area CODE
.area KERNEL
Main:
	NOP
	NOP
	JP Main
