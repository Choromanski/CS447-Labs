	.data
msg1:	.asciiz		"What is the first value?\n"
msg2:	.asciiz		"What is the second value?\n"
msg3:	.asciiz		"The product of "
msg4:	.asciiz		" and "
msg5: 	.asciiz		" is "

	.text
	li $v0, 4
	la $a0, msg1
	syscall			#prints msg1
	li $v0, 5
	syscall			#gets first integer and puts it into $t1
	add $t1, $zero, $v0
	li $v0, 4
	la $a0, msg2
	syscall			#prints msg2
	li $v0, 5
	syscall				#gets second integer and puts it into $t2
	add $t2, $zero, $v0	
	li $v0, 4
	la $a0, msg3
	syscall			#prints msg3
	li $v0, 1
	add $a0,$zero, $t1
	syscall			#prints first integer
	li $v0, 4
	la $a0, msg4
	syscall			#prints msg4
	li $v0, 1
	add $a0, $zero, $t2
	syscall			#prints second integer
	li $v0, 4
	la $a0, msg5
	syscall			#prints msg5
	mult $t1, $t2		#multiplies the 2 integers together
	mflo $a0
	li $v0, 1
	syscall			#prints the product
	li $v0, 10
	syscall			#exits program
	
