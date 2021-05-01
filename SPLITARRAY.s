# AUTHOR: Mohammad S Kharboutli
# DATE: 20 NOV 2020
# FILENAME: SPLITARRAY
# 
# DESCRIPTION: This program takes some array A of
# length n (.data section) and splits the array
# into 3 sub arrays, each memory location
# designated in the .data section. Each array is
# split based on the following criteria:
# Array 1: A1 = {A0^2 mod 4}
# Array 2: A2 = {A0 * 2 mod 6 == 4}
# Array 3: A3 = {A mod 5 < 4}
# The result is then printed to console.

.data
A: .word 120, 17, 29, 44, 49
n: .word 5
mem_loc1: .word 0x6fffffc0					#place for array1
mem_loc2: .word 0x5fffffc0					#place for array2
mem_loc3: .word 0x4fffffc0					#place for array3

.text
j main

split1: addi x2, x2, -12
sw x18, 0(sp)
sw x19, 4(sp)
sw x20, 8(sp)
la x18, A									#initial input array address
lw x19, mem_loc1							#initial output array address
lw x5, n									#quantity of items
lw x12, n									#seems redundant here but will contribute to neatness
slli x5, x5, 2
add x20, x5, x18							#address limiter
split1_loop: lw x5, 0(x18)
mul x5, x5, x5
li x6, 4
rem x5, x5, x6
sw x5, 0(x19)
addi x18, x18, 4
addi x19, x19, 4
bne x18, x20, split1_loop
lw x18, 0(sp)
lw x19, 4(sp)
lw x20, 8(sp)
addi x2, x2, 12
lw x5, mem_loc1								#for output purposes
jalr x0, 0(x1)

split2: addi x2, x2, -12
sw x18, 0(sp)
sw x19, 4(sp)
sw x20, 8(sp)
la x18, A									#initial input array address
lw x19, mem_loc2							#initial output array address
lw x5, n									#quantity of items
li x12, 0								
slli x5, x5, 2
add x20, x5, x18							#address limiter
split2_loop: lw x5, 0(x18)
slli x7, x5, 1
li x6, 6
rem x7, x7, x6
li x6, 4
bne x7, x6, split2_increment
sw x5, 0(x19)								#store the array element
addi x19, x19, 4
addi x12, x12, 1							#this is our output "n"
split2_increment: addi x18, x18, 4
bne x18, x20, split2_loop
lw x18, 0(sp)
lw x19, 4(sp)
lw x20, 8(sp)
addi x2, x2, 12
lw x5, mem_loc2
jalr x0, 0(x1)

split3: addi x2, x2, -12
sw x18, 0(sp)
sw x19, 4(sp)
sw x20, 8(sp)
la x18, A									#initial input array address
lw x19, mem_loc3							#initial output array address
lw x5, n									#quantity of items
li x12, 0								
slli x5, x5, 2
add x20, x5, x18							#address limiter
split3_loop: lw x5, 0(x18)
li x6, 5
rem x7, x5, x6
li x6, 4
bge x7, x6, split3_increment
sw x5, 0(x19)								#store the array element
addi x12, x12, 1							#this is our output "n"
split3_increment: addi x18, x18, 4
addi x19, x19, 4
bne x18, x20, split3_loop
lw x18, 0(sp)
lw x19, 4(sp)
lw x20, 8(sp)
addi x2, x2, 12
lw x5, mem_loc3
jalr x0, 0(x1)

output: slli x12, x12, 2
add x6, x5, x12								#limiter
output_loop: lw x11, 0(x5)
addi x10, x0, 1
ecall
addi x10, x0, 11
addi x11, x0, 32
ecall
addi x5, x5, 4
bne x5, x6, output_loop
addi x10, x0, 11
addi x11, x0, 10
ecall
jalr x0, 0(x1)

main: jal x1, split1
jal x1, output
jal x1, split2
jal x1, output
jal x1, split3
jal x1, output