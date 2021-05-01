# AUTHOR: Mohammad S Kharboutli
# DATE: 06 NOV 2020
# FILENAME: MULT12
# 
# DESCRIPTION: Takes values of x in register x12
# and computes the 12x if |x| < x or 12|x| if 
# |x| > x.

j main

compute: addi sp, sp, -16		#INPUT: x12 | OUTPUT: x11
sw x18, 0(sp)					#store saved regs
sw x19, 8(sp)
addi, x18, x12, 0
bgt x12, x0, cont
neg x18, x12					#var y = |x|
cont: addi x19, x0, 3
blt x12, x18, less
j nless
less:
slli x11, x12, 2				#using slli first is slightly more effecient than multiplying by 12
mul x11, x11, x19
j exit
nless:
slli x11, x18, 2
mul x11, x11, x19
exit: lw x18, 0(sp)
lw x19, 8(sp)
addi sp, sp, 16
jalr x0, 0(x1)

main: li x12, -12 				#test var x
jal x1, compute
addi x10, x0, 1
ecall