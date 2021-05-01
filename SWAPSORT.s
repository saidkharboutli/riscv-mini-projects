# AUTHOR: Mohammad S Kharboutli
# DATE: 06 NOV 2020
# FILENAME: SWAPSORT
# 
# DESCRIPTION: Takes an array and a value n in the
# .data section representing a word array of n
# n elements. The array is then sorted using the
# bubblesort swap method. The result is then printed
# to console.

.data
arr: .word 31 115 87 19 24 3
n: .word 6

.text
j main
input: addi sp, sp, -12
sw x18, 0(sp)
sw x19, 4(sp)
sw x20, 8(sp)
li x18, 0x0fffffec					# array pointer
lw x19, n							# load number of elements
beq x19, x0 exit_input
la x20, arr							# load address of static data
slli x19, x19, 2					# calculate bytes
add x19, x19, x18					# counter limit
for_input: lw x5, 0(x20)
sw x5, 0(x18)
addi x18, x18, 4
addi x20, x20, 4
beq x18, x19, exit_input
j for_input
exit_input:  lw x18, 0(sp)
lw x19, 4(sp)
lw x20, 8(sp)
addi sp, sp, 12
jalr x0, 0(x1)

sort: addi sp, sp, -20
sw x18, 0(sp)
sw x19, 4(sp)
sw x20, 8(sp)
sw x21, 12(sp)
sw x1, 16(sp)
li x18, 0x0fffffec					# outer counter
lw x21, n							# load num of elements
beq x0, x21, retmain
addi x21, x21, -1					# offset count
slli x21, x21, 2					# calculate bytes
add x20, x18, x21					# limiter
for_outer: beq x18, x20, retmain	# counter == limiter: leave
addi x19, x18, 4					# inner counter--start 1 pos forward
lw x5, 0(x18)						# outer load
for_inner: bgt x19, x20, increment	# counter > limiter: restart
lw x6, 0(x19)						# inner load
bgt x5, x6, reorder
addi x19, x19, 4					# inner increment
j for_inner
reorder: jal x1, swap
j for_inner
retmain: lw x18, 0(sp)
lw x19, 4(sp)
lw x20, 8(sp)
lw x21, 12(sp)
lw x1, 16(sp)
addi sp, sp, 20
jalr x0, 0(x1)
increment: addi x18, x18, 4			# outer increment
j for_outer

swap: sw x6, 0(x18)
sw x5, 0(x19)
lw x5, 0(x18)						# do now b/c we cant later
jalr x0, 0(x1)


output: addi sp, sp, -12
sw x18, 0(sp)
sw x19, 4(sp)
sw x20, 8(sp)
lw x20, n
beq x20, x0, stop_print
slli, x20, x20, 2
li x18, 0x0fffffec					# counter
add x19, x18, x20					# limiter
for_print: beq x18, x19, stop_print
lw x11, 0(x18)
li x10, 1
ecall
li x11, 32
li x10, 11
ecall
addi x18, x18, 4
j for_print
stop_print: lw x18, 0(sp)
lw x19, 4(sp)
lw x20, 8(sp)
addi sp, sp, 12
jalr x0, 0(x1)

main: jal x1, input
jal x1, sort
jal x1, output