	.data
a:	.word	0x7a7b7c7d
	.text
	lb $t1, 0x10010001
	
	li $v0, 1
	add $a0, $zero, $t1
	syscall