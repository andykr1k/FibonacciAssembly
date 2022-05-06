@ fillFibonacciStruct.s
@ Andrew Krikorian
@ CS252 
@ Professor Gondree
@ Define my Raspberry Pi
        .cpu    cortex-a53
        .fpu    neon-fp-armv8
        .syntax unified         @ modern syntax

@ Constant program data
        .section .rodata
        .align  2

@ The program
        .text
        .align  2
        .global fillFibonacciStruct
        .type fillFibonacciStruct, %function

fillFibonacciStruct:
        sub     sp, sp, 24      @ space for saving regs
        str     r4, [sp, 0]     @	r4
        str     r5, [sp, 4]     @	r5
	str	r6, [sp, 8]	@	r6
	str	r7, [sp, 12]	@	r7
        str     fp, [sp, 16]    @       fp
        str     lr, [sp, 20]    @       lr
	add     fp, sp, 20      @ set our frame pointer

	mov	r4, r0		@ Address of beginning of struct
	mov	r5, r1		@ A 1
	mov	r6, r2        	@ A 2
fillStruct:
	str	r5, [r4], 4	@ Store in first struct member and increment
	str	r6, [r4], 4	@ store in next struct member and increment
	add	r7, r5, r6	@ adds 2nd to last into current
	str	r7, [r4]	@ Store in last struct member
allDone:
        ldr     r4, [sp, 0]     @	r4
        ldr     r5, [sp, 4]     @       r5
	ldr	r6, [sp, 8]	@	r6
	ldr	r7, [sp, 12]	@	r7
        ldr     fp, [sp, 16]    @       fp
        ldr     lr, [sp, 20]    @       lr
        add     sp, sp, 24      @ restore sp
        bx      lr              @ return

