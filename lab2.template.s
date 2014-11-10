#############################################
## Name:  Template File                     #
## Email: address@email.com                 #
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
##                                          #
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

seq1:	.word 60 66 157 293 329 329 334 304 131 124


#############################################
#                                           #
#                  Program                  #
#                                           #
#############################################
.text
main:
	
	# Your experiments go here

	
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