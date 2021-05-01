# AUTHOR: Mohammad S Kharboutli
# DATE: 20 NOV 2020
# FILENAME: RECURSIVEARITH
# 
# DESCRIPTION: A recursive function that takes some
# value of x and performs the following operation:
# f(x) = f(x-1) + 2 * x, x >= 0
# Upon completion, the result is placed in register
# x11 and printed to console.

.data
x: .word 1

.text
j main

recursive_func: addi x2, x2, -8
sw x12, 0(sp)
sw x1, 4(sp)
bne x12, x0, recurse
lw x12, 0(sp)
lw x1, 4(sp)
addi x2, x2, 8
jalr x0, 0(x1)					#only executes when we hit 0
recurse: addi x12, x12, -1
jal x1, recursive_func
lw x12, 0(sp)
lw x1, 4(sp)
addi x2, x2, 8
slli x5, x12, 1
add x11, x5, x11
jalr x0, 0(x1)

iterative_func: slli x5, x12, 1
add x11, x5, x11
addi x12, x12, -1
bne x12, x0, iterative_func
jalr x0, 0(x1)

main: lw x12, x					#load input
jal x1, recursive_func			#INPUT: reg x12 || OUTPUT: reg x11
addi x10, x0, 1
ecall
addi x10, x0, 11
addi x11, x0, 10
ecall
addi x11, x0, 0					#reset output register
jal x1, iterative_func			#INPUT: reg x12 || OUTPUT: reg x11
addi x10, x0, 1
ecall