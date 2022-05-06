@ fillFibonacciArray.s
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
        .global fillFibonacciArray
        .type fillFibonacciArray, %function

fillFibonacciArray:
        sub     sp, sp, 36      @ space for saving regs
        str     r4, [sp, 0]     @	r4
        str     r5, [sp, 4]     @	r5
	str	r6, [sp, 8]	@	r6
	str	r7, [sp, 12]	@	r7
	str	r8, [sp, 16]	@	r8
	str	r9, [sp, 20]	@	r9
	str	r10, [sp, 24]	@	r10
        str     fp, [sp, 28]    @       fp
        str     lr, [sp, 32]    @       lr
	add     fp, sp, 32      @ set our frame pointer
                
        mov     r5, 0           @ index = 0;
	mov	r6, r0		@ arrayPointer
	mov	r7, r1		@ size
	mov	r8, 0		@ number is i
	mov	r9, 0		@ number is i - 1
	mov	r10, 0		@ number is i - 2
	
fillArray:
        cmp     r5, r7		@ all filled?
        beq     allDone         @ yes
        
	cmp	r5, 0		@ checks for first index
	beq	firstElement	@ if so, fills index 0 with 0

	add	r8, r9, r10	@ adds 2nd to last into current
	str	r8, [r6]	@ stores number into array
	mov 	r10, r9		@ moves last index to second-to-last
	mov 	r9, r8		@ moves current index to last
	add     r5, r5, 1       @ index++;
	add	r6, r6, 4	@ pointer
        b       fillArray
firstElement:
	mov	r8, 1		@ moves 1 into current
	str	r8, [r6]	@ store first element
	mov	r9, r8		@ stores curr into last
	add 	r5, r5, 1	@ index++
	add	r6, r6, 4	@ pointer++
	b	fillArray	
allDone:
        ldr     r4, [sp, 0]     @	r4
        ldr     r5, [sp, 4]     @       r5
	ldr	r6, [sp, 8]	@	r6
	ldr	r7, [sp, 12]	@	r7
	ldr	r8, [sp, 16]	@	r8
	ldr	r9, [sp, 20]	@	r9
	ldr	r10, [sp, 24]	@	r10
        ldr     fp, [sp, 28]    @       fp
        ldr     lr, [sp, 32]    @       lr
        add     sp, sp, 36      @ restore sp
        bx      lr              @ return

