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
				.area INTERRUPTS
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
.include "ptimers.s"
.include "supervisor.s"
.area INTERRUPTS
.include "interrupts.s"
.area MAIN
Main:
	NOP
	CALL Light
Lo:
	NOP
	CALL Supervisor
	JRA Lo

.area TASKS
.include "tasks.s"
