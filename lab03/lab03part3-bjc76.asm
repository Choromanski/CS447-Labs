.data
	
Array_A:.word		0xa1a2a3a4, 0xa5a6a7a8, 0xacabaaa9
type: 	.asciiz 	"Please enter element type ('w' -word, 'h' -half, 'b' -byte):\n"
output:	.asciiz		"\nHere is the output (address, value in hexadecimal, value in decimal):\n"
space:	.asciiz		", "
	
.text		## MAKE SURE TO USE lbu and lhu WHEN LOADING IN HALFWORDS AND BYTSE##
	
			#w = 0x77
			#h = 0x68
			#b = 0x62
	
	li $v0, 4
	la $a0, type
	syscall		#Prints prompt for which type
	li $v0, 12
	syscall		#Takes inpuc character ant stores it in $v0
	la $a0, output
	la $t0, Array_A
	beq $v0, 0x77, w
	beq $v0, 0x68, h
	beq $v0, 0x62, b 

w:			#WORD
	add $t0, $t0, 8
	lw $t1, ($t0)
	j main
h:			#HALFWORD
	add $t0, $t0, 4
	lhu $t1, ($t0)
	j main
b:			#BYETE
	add $t0, $t0, 2
	lbu $t1, ($t0)
	j main
main:
	li $v0, 4
	syscall			#prints outputline
	li $v0, 34
	add $a0, $zero, $t0
	syscall			#prints adress
	li $v0, 4
	la, $a0, space
	syscall			#prints space
	li $v0, 34
	add $a0, $zero, $t1
	syscall			#prints in hex
	li $v0, 4
	la $a0, space
	syscall			#prints space
	li $v0, 1
	add $a0, $zero, $t1
	syscall			#prints in decemal
	li $v0, 10
	syscall			#exits
	
