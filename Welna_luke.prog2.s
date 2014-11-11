#############################################
## Name:  Program 2                         #
## Email: nitro.luke@gmail.com              #
#############################################
##                                          #
##  This program prints a bitmap of a       #
##  character based on vector of integers.  #
##                                          #
##  Dimensions: 9 bits x 10 rows            #
##  Mapping:    0 ==> '-'; 1 ==> 'X'        #
##                                          #
##  Variable List:                          #
##    # list variables used in main here    #
##    $s0, $s1, $s2                         #
##    # but list all procedure variables    #
##    #             with procedure comments #
##                                          #
##                                          #
############################################# 

.globl main

#############################################
#                                           #
#                   Data                    #
#                                           #
#############################################
.data

seq0:	.word 16 56 4   80  48  24  20  84  56  16
seq1:	.word 60 66 157 293 329 329 334 304 131 124

newLine:
	.asciiz "\n"

result1:
	.asciiz "X "

result0:
	.asciiz "- "
#############################################
#                                           #
#                  Program                  #
#                                           #
#############################################
.text
main:
	
	# Your experiments go here
	
	
	addi $s0, $0, 0			# i = 0
	addi $s1, $0, 10		# $t1 = number of columns (10 instead of 9 because I was off by one, quicker to just change it to 10)
	la   $s2, seq1			# $s2 = address of seq1
#	addi $sp, $sp, 4		# increment the stack pointer
	
LoopVector:
	
	sll $t0, $s0, 2			# $t0 = i * 4 will be used to access the address of the array
	add $t0, $t0, $s2		# address of $s2[i]
	beq $s0, $s1, exit		# exit if $s0 == $s1 once this loop is done the program will be over
	lw $a0, 0($t0)	        #$a0 = $s2[i] ($t0 = i * 4)
#	sw   $sp  0($ra)		# store $ra on the stack
	jal rowprint
	#SAVE $ra IN STACK#
	addi $s0, $s0, 1		# i++ 
	j LoopVector			# jump to loop
	
############################################# 
# Procedure: rowprint					    #
#   - prints out the given integer as a     #
#     single row of bits (0='-' and 1='X"). #
#										    #
#   - inputs : $a0 = int value to display   #
#   - outputs: none                         #  
#										    #
#############################################

rowprint:

	# complete your procedure body here
    # do not forgot to ample comments!
	
	add $t2, $a0, $0		# (may not be needed)store $a0 in a temporary  variable $t2
	addi $t0, $0, 1			# $t0 starts at 1
	sll $t0, $t0, 8			# $t0 is 1 * 2^8 will be used to compare with $t2($a0)
	
	loopRow:
	beq $t0, $0, return		  # if $t0 == $s1 (in other words if i == 0) exit loop
	# (not needed, i dont think) sll $t1, $t0, 2		  
	# $t0 = i * 4 will be used to store the bits in an array for the binary representation of an int

	and $t3, $t2, $t0 		  # $t3 = $t2 equals its self anded with $t0 
	beq  $t3, 1, PrintX
	beq  $t3, 0, PrintDash
		
PrintX:
	la $a0, result1
	li $v0, 4
	syscall
	j loopAgain
PrintDash:
	la $a0, result0
	li $v0, 4
	syscall

loopAgain:	

	add $a0, $t2, $0		# resets $a0 to original value
	srl $t0, $t0,  1		# shift $i right by 1 (just messing around at this point), they are hex in the registers
	j loopRow				# jump to loopRow
return:						# prints a new line and returns
	la $a0, newLine			# sets $a0 to the string in newLine
	li $v0, 4
	syscall 
	
	jr $ra					# return to calling function
#############################################	
## end procedure rowprint                  ##
#############################################	


	# Your other procedures go here...



############################################# 
# Procedure: exit   					    #
#   - exit the program                      #
#										    #
#   - inputs : none                         #
#   - outputs: none                         #  
#										    #
#############################################
exit:
	li $v0, 10				# Exit program
	syscall
	
#############################################	
## end program                             ##
#############################################	