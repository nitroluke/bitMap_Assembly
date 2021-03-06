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

seq0:	.word 16  56  4   80  48  24  20  84  56  16

seqA1:  .word 60  66  157 293 329 329 334 304 131 124
seqA2:  .word 0   56  72  80  102 420 296 274 326 0
seqA3:  .word 16  56  40  68  68  130 254 130 130 130
seqA4:  .word 252 130 130 130 252 130 130 130 130 252

seqB1:  .word 65  34  20  8   20  34  65  0   0   0
seqB2:  .word 8   8   8   127 8   8   8   0   0   0
seqB3:  .word 0   0   0   8   0   0   0   0   0   0
seqB4:  .word 73  42  28  127 28  42  73  0   0   0
seqB5:  .word 73  42  28  119 28  42  73  0   0   0

seqC1:  .word 0   60  64  128 128 128 128 64  60  0
seqC2:  .word 0   248 132 130 130 130 130 132 248 0
seqC3:  .word 0   308 196 258 258 258 258 196 308 0 # (A + B)
seqC4:  .word 0   188 68  2   2   2   2   68  188 0 # (B - A)
seqC5:  .word 0   120 128 256 256 256 256 128 120 0 
seqC6:  .word 0   496 264 260 260 260 260 264 496 0

newLine:
	.asciiz "\n"

result1:
	.asciiz "X "

result0:
	.asciiz "- "
	
VectorC:
	
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
	la   $s2, seqC6			# $s2 = address of seq1
	
	
	
	
LoopVector: # calls rowPrint 
	sll $t0, $s0, 2			# $t0 = i * 4 will be used to access the address of the array
	add $t0, $t0, $s2		# address of $s2[i]
	beq $s0, $s1, exit		# exit if $s0 == $s1 once this loop is done the program will be over
	lw $a0, 0($t0)	        # $a0 = $s2[i] ($t0 = i * 4)
	jal rowprint
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

rowprint: # calls print char 10 times

	# complete your procedure body here
    # do not forgot to ample comments!

	sw $ra, 0($sp)			# put $ra on the stack
	addi $sp $sp, -4		# decrement the stack pointer
	add $t2, $a0, $0		# (may not be needed)store $a0 in a temporary  variable $t2
	addi $t0, $0, 1			# $t0 starts at 1
	sll $t0, $t0, 8			# $t0 is 1 * 2^8 will be used to compare with $t2($a0)
	
loopRow:
	beq $t0, $0, return		  # if $t0 == $s1 (in other words if i == 0) exit loop
	jal printChar	  
	
loopAgain:	
	add $a0, $t2, $0		# resets $a0 to original value
	srl $t0, $t0,  1		# shift $i right by 1 
	j loopRow				# jump to loopRow

return:						# prints a new line and returns	
	jal printLine
	addi $sp, $sp, 4		# add 4 to the stack pointer
	lw $ra 0($sp)			# restore $ra
	jr $ra					# return to calling function
	
	
#############################################	
## end procedure rowprint                  ##
##                                         ## 
##                                         ##  
##	 - inputs :                            ##
##   - outputs: prints char to console     ##  
##                                         ##  
##                                         ##  
#############################################	


	# Your other procedures go here...
printChar:
	and $t3, $t2 , $t0 		  # $t3 = $t2 equals its self anded with $t0 
	beq  $t3, 1, PrintX
	beq  $t3, 0, PrintDash
		
PrintX:
	la $a0, result1			  # load result1 in $a0
	li $v0, 4
	syscall
	jr $ra					  # jump return
	
PrintDash:
	la $a0, result0			  # load result0 in $a0
	li $v0, 4		
	syscall
	jr $ra					  # jump return
	
printLine:
	la $a0, newLine			# sets $a0 to the string in newLine
	li $v0, 4
	syscall 
	
	jr $ra
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