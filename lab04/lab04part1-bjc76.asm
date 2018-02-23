		.data
some_string:	.space	64
prompt1:	.asciiz "Please enter your string:\n"
prompt2:	.asciiz "Please enter the character to replace:\n"
q2:		.asciiz "\nHere is the output: "

		.text
		
		li $v0, 4
		la $a0, prompt1
		syscall
		
		li $v0, 8
		la $a0, some_string
		la $a1, 63
		syscall
		
		
		li $v0, 4
		la $a0, prompt2 
		syscall
		
		la $v0, 12
		syscall
		
		add $a1, $zero, $v0
		la $a0, some_string 
		jal ReplaceLetterWithAsterisk
		
		la $a0, some_string
		jal Rotate13
	
		li $v0, 4
		la $a0, q2
		syscall
		la $a0, some_string
		syscall
		li $v0, 10
		syscall

		
		
	
ReplaceLetterWithAsterisk:	#$a0 address to string and $a1 character to replace
		li $t1, 42
		
	loopReplace:
		lbu $a3, ($a0)
		beq $a3, 00, exitReplace
		beq $a3, $a1, replace
		addi $a0, $a0, 1
		j loopReplace
	
	replace:
		sb $t1, ($a0)
		addi $a0, $a0, 1 
		j loopReplace
exitReplace:
		jr $ra
	
Rotate13:		#$a0 address of string	
		lbu $a1, ($a0)
		beq $a1, 00, exitRotate
		ble $a1, 90, upperCase
		bge $a1, 97, lowerCase
		
		
	upperCase:
		ble $a1, 64, nextChar
		bge $a1, 78, subtract
		ble $a1, 77, addition
			
	lowerCase:
		bge $a1, 123, nextChar
		bge $a1, 110, subtract 
		ble $a1, 109, addition
	
	subtract:
		subi $a1, $a1, 13
		j nextChar
	addition:
		addi $a1, $a1, 13
		j nextChar
	
	nextChar:	
		sb $a1, ($a0)
		addi $a0, $a0, 1
		j Rotate13
		
exitRotate:
		jr $ra
		
		
		
