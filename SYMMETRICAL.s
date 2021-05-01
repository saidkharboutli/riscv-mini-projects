# AUTHOR: Mohammad S Kharboutli
# DATE: 20 NOV 2020
# FILENAME: SYMMETRICAL
# 
# DESCRIPTION: Takes some matrix M defined in the
# .data section, along with specific row and col
# counts, and checks if M is symmetrical. The
# result is printed to console.

.data
M: .word 1, 2, 15
   .word 2, 2, 7
   .word 15, 7, 3
row: .word 3
col: .word 3

# M: .word 1, 2, 3, 4
#    .word 2, 8, 5, 6
#    .word 3, 5, 9, 7
#    .word 4, 6, 7, 0
# row: .word 4
# col: .word 4

# M: .word 2, 1, 0, 0, 0, 0
#    .word 1, 1, 0, 0, 0, 0
#    .word 0, 0, 2, 3, 0, 0
#    .word 0, 0, 3, 5, 0, 0
#    .word 0, 0, 0, 0, 1, 0
#    .word 0, 0, 0, 0, 0, -1
# row: .word 6
# col: .word 6

.text
j main

is_symmetrical: addi sp, sp, -20
sw x18, 0(sp)
sw x19, 4(sp)
sw x20, 8(sp)
sw x21, 12(sp)
sw x22, 16(sp)
lw x5, row								#register will remain static with r/c val
lw x6, col
bne x5, x6, not_symmetrical
slli x7, x5, 2							#bytes of one full row
la x18, M								#static for calculations
li x19, 0								#i
for_outer: li x20, 0					#j
mul x6, x7, x19
add x21, x6, x18						#first accessor (will go with loop)
for_inner: mul x6, x7, x20				#memory address of i,j
add x22, x6, x18
slli x6, x19, 2
add x22, x22, x6						#memory address of j,i
lw x28, 0(x21)							#value at i,j
lw x29, 0(x22)							#value at j,i
bne x28, x29, not_symmetrical				#check equivalence, quit 0 not equivalent
addi x20, x20, 1						#increment j
addi x21, x21, 4
bne x20, x5, for_inner					#hit limit of j
#end_inner
addi x19, x19, 1
bne x19, x5, for_outer
#end_loop
addi x11, x0, 1
j exit
not_symmetrical: addi x11, x0, 0
exit: lw x18, 0(sp)
lw x19, 4(sp)
lw x20, 8(sp)
lw x21, 12(sp)
lw x22, 16(sp)
addi sp, sp, 20
jalr x0, 0(x1)

main: jal x1, is_symmetrical
addi x10, x0, 1
ecall