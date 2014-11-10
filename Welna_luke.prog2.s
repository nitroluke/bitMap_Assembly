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
	.asciiz "X"

result0:
	.asciiz "-"
#############################################
#                                           #
#                  Program                  #
#                                           #
#############################################
.text
main:
	
	# Your experiments go here
	
	
	addi $s0, $0, 0			# i = 0
	addi $s1, $0, 10		# $t1 = number of columns
	la   $s2, seq0			# $s2 = address of seq1
Loop:
	
	sll $t0, $s0, 2			# $t0 = i * 4 will be used to access the adress of the array
	add $t0, $t0, $s2		# address of $s2[i]
	beq $s0, $s1, exit		# exit if $s0 == $s1 once this loop is done the program will be over
	lw $a0, 0($t0)	        #$t1 = $s2[i] ($t2 = i * 4)
	#maybe I should use $v1? to store the word?
	jal rowprint
	
	addi $s0, $s0, 1		# i++ 
	j Loop					# jump to loop
############################################# 
# Procedure: rowprint					    #	#############################################
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
	lu $a0, $a0
	li $v0, 1		# prints the int in $a0
	syscall			
	
	la $a0, newLine
	li $v0, 4
	syscall 
	
	jr $ra
#############################################	
## end procedure rowprint                  ##
#############################################	


	# Your other procedures go here...



############################################# 
# Procedure: exit   					    #	#############################################
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