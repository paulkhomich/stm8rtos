.include "define.s"

		.area DATA
		.area SSEG
		.area HOME
			.area VECTORS
			.area TASKSTABLE
			.area CONSTANTS
		.area CODE
			.area KERNEL
				.area INIT
				.area PROCEDURES
				.area MAIN
			.area TASKS

.area DATA
.include "memory.s"

.area HOME
.area VECTORS
.include "vectors.s"
.area TASKSTABLE
.include "table.s"

.area CODE
.area KERNEL
.area INIT
.include "init.s"
.area PROCEDURES
.include "queue.s"
.area MAIN
Main:
	NOP
	NOP
	JRA Main

.area TASKS
.include "tasks.s"
