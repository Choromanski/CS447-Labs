	.data
msg1:	.asciiz		"Please enter your integer\n"
msg2:	.asciiz		"Here is the input in binary: "
msg3:	.asciiz		"\nHere is the input in hexadecimal: "
msg4:	.asciiz		"\nHere is the output in binary: "
msg5:	.asciiz		"\nHere is the output in hexadecimal: "
	
	.text
	li $v0, 4
	la $a0, msg1
	syscall			#prints msg1
	li $v0, 5
	syscall			#reads input and places it in t1
	add $t1, $zero, $v0
	li $v0, 4
	la $a0, msg2
	syscall			#prints msg2
	li $v0, 35
	add $a0, $zero, $t1
	syscall			#prints input in binary
	li $v0, 4
	la $a0, msg3
	syscall			#prints msg3
	li $v0, 34
	add $a0, $zero, $t1
	syscall			#prints input in hexadecimal
	srl $t1, $t1, 12	#shiftf input to the right 12 bits
	andi $t1, $t1, 15	#gets rid of all bits other than 12-15
	li $v0, 4
	la $a0, msg4
	syscall			#prints msg4
	li $v0, 35
	add $a0, $zero, $t1
	syscall			#prints output in binary
	li $v0, 4
	la $a0, msg5
	syscall			#prints msg5
	li $v0, 34
	add $a0, $zero, $t1
	syscall			#prints output in hexadecimal	
	li $v0, 10
	syscall			#exits program
