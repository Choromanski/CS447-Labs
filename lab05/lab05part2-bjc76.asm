		.data
prompt1:	.asciiz		"Please enter the x coordinate of the position:\n"
prompt2:	.asciiz		"Please enter the y coordinate of the porition:\n"
prompt3:	.asciiz		"Please enter the size:\n"
prompt4:	.asciiz		"Please enter the color ('g' -green, 'y' -yellow and 'r' -red):\n"
prompt5:	.asciiz		"\n"

		.text

		la $a0, prompt1
		li $v0, 4
		syscall
		li $v0, 5
		syscall
		add $s0, $v0, $zero
		la $a0, prompt2
		li $v0, 4
		syscall
		li $v0, 5
		syscall
		add $s1, $v0, $zero
		la $a0, prompt3
		li $v0, 4
		syscall
		li $v0, 5
		syscall
		add $s2, $v0, $zero
	back:
		la $a0, prompt4
		li $v0, 4
		syscall
		li $v0, 12
		syscall
		add $s4, $v0, $zero
		la $a0, prompt5
		li $v0, 4
		syscall
		li $s3, 1
		beq $s4, 0x72, out
		addi $s3, $s3, 1
		beq $s4, 0x79, out
		addi $s3, $s3, 1
		beq $s4, 0x67, out
		j back
	out:
		#gets all input from user, stores x cord in $s0, y cord in $1, size in $s2, and color in $s3
		add $a0, $s0, $zero
		add $a1, $s1, $zero
		add $a2, $s2, $zero
		add $a3, $s3, $zero
		jal drawSquare
		li $v0, 10
		syscall
		
drawSquare:	#$a0= x position, $a1= y position, $a2= size, $a3= color
		#setup
		addi $sp, $sp, -24
		sw   $s0, 0($sp)
		sw   $s1, 4($sp)
		sw   $s2, 8($sp)
		sw   $s3, 12($sp)
		sw   $s4, 16($sp)
		sw   $ra, 20($sp)
		
		#body
		add $s2, $a2, $zero
		add $s0, $a0, $zero
		add $s1, $a1, $zero
		add $s3, $a3, $zero
		jal drawVerticalLine
		add $a2, $s2, $zero
		add $a0, $s0, $zero
		add $a1, $s1, $zero
		add $a3, $s3, $zero
		jal drawHorizontalLine
		add $a2, $s2, $zero
		add $a0, $s0, $a2
		addi $a0, $a0, -1
		add $a1, $s1, $zero
		add $a3, $s3, $zero
		jal drawVerticalLine
		add $a2, $s2, $zero
		add $a0, $s0, $zero
		add $a1, $s1, $a2
		addi $a1, $a1, -1
		add $a3, $s3, $zero
		jal drawHorizontalLine
		
		#exit
		lw   $s0 0($sp)
		lw   $s1, 4($sp)
		lw   $s2, 8($sp)
		lw   $s3, 12($sp)
		lw   $s4, 16($sp)
		lw   $ra, 20($sp)
		addi $sp, $sp, 24
		jr $ra

drawVerticalLine:	#$a0= x position, $a1= y position, $a2= size, $a3= color
		# setup
		addi $sp, $sp, -24
		sw   $s0, 0($sp)
		sw   $s1, 4($sp)
		sw   $s2, 8($sp)
		sw   $s3, 12($sp)
		sw   $s4, 16($sp)
		sw   $ra, 20($sp)
		
		# body
		move $s0, $a0	# x
		move $s1, $a1	# y
		move $s2, $a2	# count
		move $s3, $a3	# color
		li   $s4, 0
	dvlLoop:
		bge $s4, $s2, dvlExit
		add  $a0, $s0, $zero    # x
		add  $a1, $s1, $s4      # y
		move $a2, $s3   	# color
		jal setLED
		addi $s4, $s4, 1        # loop counter
		j dvlLoop

	dvlExit:
		lw   $s0 0($sp)
		lw   $s1, 4($sp)
		lw   $s2, 8($sp)
		lw   $s3, 12($sp)
		lw   $s4, 16($sp)
		lw   $ra, 20($sp)
		addi $sp, $sp, 24
		jr $ra
		
drawHorizontalLine:	#$a0= x position, $a1= y position, $a2= size, $a3= color
		#setup
		addi $sp, $sp, -24
		sw   $s0, 0($sp)
		sw   $s1, 4($sp)
		sw   $s2, 8($sp)
		sw   $s3, 12($sp)
		sw   $s4, 16($sp)
		sw   $ra, 20($sp)
		
		#body
		move $s0, $a0	# x
		move $s1, $a1	# y
		move $s2, $a2	# count
		move $s3, $a3	# color
		li   $s4, 0
	dhlLoop:
		bge $s4, $s2, dhlExit
		add $a0, $s0, $s4	#x
		add $a1, $s1, $zero	#y
		move $a2, $s3		#color
		jal setLED
		addi $s4, $s4, 1	#loop counter
		j dhlLoop
		
	dhlExit:
		lw   $s0 0($sp)
		lw   $s1, 4($sp)
		lw   $s2, 8($sp)
		lw   $s3, 12($sp)
		lw   $s4, 16($sp)
		lw   $ra, 20($sp)
		addi $sp, $sp, 24
		jr $ra
		
setLED:
	# byte offset into display = y * 16 bytes + (x / 4)
	sll	$t0,$a1,4      # y * 16 bytes
	srl	$t1,$a0,2      # x / 4
	add	$t0,$t0,$t1    # byte offset into display
	li	$t2,0xffff0008 # base address of LED display
	add	$t0,$t2,$t0    # address of byte with the LED
	# now, compute led position in the byte and the mask for it
	andi	$t1,$a0,0x3    # remainder is led position in byte
	neg	$t1,$t1        # negate position for subtraction
	addi	$t1,$t1,3      # bit positions in reverse order
	sll	$t1,$t1,1      # led is 2 bits
	# compute two masks: one to clear field, one to set new color
	li	$t2,3		
	sllv	$t2,$t2,$t1
	not	$t2,$t2        # bit mask for clearing current color
	sllv	$t1,$a2,$t1    # bit mask for setting color
	# get current LED value, set the new field, store it back to LED
	lbu	$t3,0($t0)     # read current LED value	
	and	$t3,$t3,$t2    # clear the field for the color
	or	$t3,$t3,$t1    # set color field
	sb	$t3,0($t0)     # update display
	jr	$ra
