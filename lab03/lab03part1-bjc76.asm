	.data
y:	.byte	33
z:	.byte	0
x:	.byte	16

	.text			#compute y-x and store it in z
	lb $t0, y		#puts y into $t0 
	lb $t1, x		#puts x into $t1
	sub $t0, $t0, $t1	#puts y-x into $t0
	la $t1, z		#sets the address of z to $t1
	sb $t0, ($t1)		#stores $t0 (y-x) into z
	
	#part B
	sb $t0, -1($t1)		#stores $t0 to y
	sb $t0, 1($t1)		#stores $t0 to x
	