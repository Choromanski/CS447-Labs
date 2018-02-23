		.data
prompt1:	.asciiz		"Please enter a number n:\n"
prompt2:	.asciiz		"Please enter another number k:\n"
prompt3:	.asciiz		"The chosen value is "

		.text
		
		la $a0, prompt1
		li $v0, 4
		syscall		#prints prompt 1
		li $v0, 5
		syscall		#gets n
		add $a1, $v0, $zero
		la $a0, prompt2
		li $v0, 4
		syscall		#prints prompt 2
		li $v0, 5
		syscall		#gets k
		add $a2, $v0, $zero
		jal chooseFunction
		add $t0, $v0, $zero
		la $a0, prompt3
		li $v0, 4
		syscall		#prints prompt 3
		add $a0, $t0, $zero
		li $v0, 1
		syscall		#prints result
		li $v0, 10
		syscall		#terminates
		
		
		
		
chooseFunction:				#n is passed as $a1, k is passed as $a2, $v0 is returned
		#prologue
		addi $sp, $sp, -16
		sw $a1, 0($sp)
		sw $a2, 4($sp)
		sw $v1, 8($sp)
		sw $ra, 12($sp)
		beq $a2, $zero, kIs0
		beq $a1, $a2, nIsk
		blt $a1, $a2, nIsLessThanK
		j loop
		
		
	kIs0:
		li $v0, 1
		j exit
	nIsk:
		li $v0, 1
		j exit
	nIsLessThanK:
		li $v0, 0
		j exit
	loop:
		addi $a1, $a1, -1
		jal chooseFunction
		add $v1, $v0, $zero
		addi $a2, $a2, -1
		jal chooseFunction
		add $v0, $v1, $v0
		j exit
	exit:
		#epilogue
		lw $a1, 0($sp)
		lw $a2, 4($sp)
		lw $v1, 8($sp)
		lw $ra, 12($sp)
		addi $sp, $sp, 16
		jr $ra
