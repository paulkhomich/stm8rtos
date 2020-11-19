.include "define.s"

		.area DATA
		.area SSEG
		.area HOME
			.area VECTORS
			.area INIT
			.area CONSTANTS
		.area CODE
			.area KERNEL
				.area PROCEDURES
				.area MAIN
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
.area PROCEDURES
.include "queue.s"
.area MAIN
Main:
	NOP
	NOP
	JP Main
