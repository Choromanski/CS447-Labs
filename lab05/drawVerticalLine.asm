# Function: drawVerticalLine
#   $a0 - x position
#   $a1 - y position
#   $a2 - number of spaces to move vertically
#   $a3 - color
_drawVerticalLine:
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
_dvlLoop: bge $s4, $s2, _dvlExit
	add  $a0, $s0, $zero    # x
	add  $a1, $s1, $s4      # y
	move $a2, $s3   	    # color
	jal _setLED
	addi $s4, $s4, 1        # loop counter
	j _dvlLoop

_dvlExit:
	lw   $s0 0($sp)
	lw   $s1, 4($sp)
	lw   $s2, 8($sp)
	lw   $s3, 12($sp)
	lw   $s4, 16($sp)
	lw   $ra, 20($sp)
	addi $sp, $sp, 24
	jr $ra

