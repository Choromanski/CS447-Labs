		.data
names:		.asciiz	"alex", "sam", "jamie", "andi", "riley"
cities:		.asciiz "boston", "new york", "chicago", "pittsburgh", "denver"
prompt1:	.asciiz "Please enter a name:\n"
prompt2:	.asciiz "City is: "
prompt3:	.asciiz "Not found!"
some_string:	.space 	64

			.text
	
			la $a0, prompt1
			li $v0, 4
			syscall
			
			li $v0, 8
			la $a0, some_string
			li $a1, 63
			syscall
			li $t9, 0
			j enter
			
	loop:		
			addi $t9, $t9, 1	
		enter:
			la $a0, names
			add $a1, $zero $t9
			jal LookUp
			la $a1, some_string
			add $a0, $zero, $v0
			jal CheckName 
			bnez $v0, match
			beq $t9, 4, noMatch
			j loop
	
	match:
			la $a0, prompt2
			li $v0, 4
			syscall
			la $a0, cities
			add $a1, $zero, $t9
			jal LookUp
			add $a0, $zero $v0
			li $v0, 4
			syscall
			li $v0, 10
			syscall
	noMatch:
			la $a0, prompt3
			li $v0, 4
			syscall
			li $v0, 10
			syscall

CheckName:	#compares addresses $a0 and $a1 if they are both the same then returns 1 in $v0 and if different returns 0 in $v0
			lbu $t0, ($a0)
			lbu $t1, ($a1)
			j checkNull
	test:
			beq $t0, $t1, equal
			bne $t0, $t1, notEqual
			 
	equal:
			li $v0, 1
			add $a0, $a0, 1
			add $a1, $a1, 1
			j CheckName
	notEqual:
			li $v0, 0
			j exitCheckName
	checkNull:
			beqz $t0, Null
			j test
	Null:
			li $v0, 1
			beq $t1, 10, exitCheckName
			j test 
	
exitCheckName:
			jr $ra


LookUp:		#$a0 address of string array $a1 index and returns address of string at that index in $v0
			beqz $a1, exitLookUp
			lbu $t1, ($a0)
			addi $a0, $a0, 1		
			beqz $t1, nextIndex
			j LookUp
			
	nextIndex:
			subi $a1, $a1, 1
			j LookUp
			
exitLookUp:
			add $v0, $zero, $a0
			jr $ra


StrSize:	#$a0 address of string returns the number of characters before the next null character to $v0
			li $v0, 0
	loopStrSize:
			lbu $t1, ($a0)
			beqz $t1, exitStrSize
			addi $v0, $v0, 1
			addi $a0, $a0, 1
			j loopStrSize
			
exitStrSize:
			jr $ra
			
			
			
