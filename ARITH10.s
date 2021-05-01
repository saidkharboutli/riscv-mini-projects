# AUTHOR: Mohammad S Kharboutli
# DATE: 06 NOV 2020
# FILENAME: ARITH10
# 
# DESCRIPTION: Takes a value x and n in registers
# x12 and x13, respectively, and performs 3x+4 if
# x >= 10 or n^x otherwise. The result is placed
# in register x11.

j main

comp: addi sp, sp -24			#INPUT: x12-x / x13-n | OUTPUT: x11
sw x18, 0(sp)
sw x19, 8(sp)
sw x1, 16(sp)
li x18, 9
bgt x12, x18, greater
jal x1, con2
j retmain
greater: jal x1, con1
retmain: lw x1, 16(sp)
lw x18, 0(sp)
lw x19, 8(sp)
addi sp, sp, 24
jalr x0, 0(x1)

con1: addi x18, x0, 3
mul x11, x18, x12
addi, x11, x11, 4
jalr x0, 0(x1)

con2: addi x11, x0, 1			#handle case of x=0
beq x12, x0, endloop
addi x18, x0, 1
add x11, x0, x13
multiplyloop:
beq x18, x12, endloop
mul x11, x11, x13
addi x18, x18, 1
j multiplyloop
endloop: jalr x0, 0(x1)

main: li x12, 0 				#test var x
li x13, 4						#test var n
jal x1, comp
addi x10, x0, 1
ecall