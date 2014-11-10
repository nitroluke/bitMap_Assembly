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
	la   $s2, seq0			# $s2 = address of seq1
LoopVector:
	
	sll $t0, $s0, 2			# $t0 = i * 4 will be used to access the address of the array
	add $t0, $t0, $s2		# address of $s2[i]
	beq $s0, $s1, exit		# exit if $s0 == $s1 once this loop is done the program will be over
	lw $a0, 0($t0)	        #$a0 = $s2[i] ($t0 = i * 4)
	#maybe I should use $v1? to store the word?
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

rowprint:

	# complete your procedure body here
    # do not forgot to ample comments!
	
	addi $t0, $0, 0			# i = 1
							# $s0 preserved across call, represents number of columns 
loopRow:
	beq $t0, $s1, return	# if $t0 == $s1 (in other words if i == number of columns) exit loop
	sll $t1, $t0, 2			# $t0 = i * 4 will be used to store the bits in an array for the binary representation of an int
	
	li $v0, 1				# prints the int in $a0
	syscall			
	

	
	addi $t0, $t0, 1		# i++
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