.data
str: .space 512
pattern: .space 512
table: .space 1024
filename: .asciiz "test.dat"

.text
main:
#fopen
la $a0, filename #load filename
li $a1, 0 #flag
li $a2, 0 #mode
li $v0, 13 #open file syscall index
syscall

#read str
move $a0, $v0 #load file description to $a0
la $a1, str
li $a2, 1
li $s0, 0 #len_str = 0
read_str_entry:
slti $t0, $s0, 512
beqz $t0, read_str_exit
li $v0, 14 #read file syscall index
syscall
lb $t0, 0($a1)
addi $t1, $zero, '\n'
beq $t0, $t1, read_str_exit
addi $a1, $a1, 1
addi $s0, $s0, 1
j read_str_entry
read_str_exit:

#read pattern
la $a1, pattern
li $a2, 1
li $s1, 0 #len_pattern = 0
read_pattern_entry:
slti $t0, $s1, 512
beqz $t0, read_pattern_exit
li $v0, 14 #read file syscall index
syscall
lb $t0, 0($a1)
addi $t1, $zero, '\n'
beq $t0, $t1, read_pattern_exit
addi $a1, $a1, 1
addi $s1, $s1, 1
j read_pattern_entry
read_pattern_exit:

#close file
li $v0, 16 #close file syscall index
syscall

#call horspool
move $a0, $s0
la $a1, str
move $a2, $s1
la $a3, pattern
jal horspool

#printf
move $a0, $v0
li $v0, 1
syscall
#return 0
li $a0, 0
li $v0, 17
syscall

# $a0: len_str  $a1: str  $a2: len_pattern  $a3: pattern
horspool:
##### your code here #####

li $t0, 0 # i
li $t2, 0 # cnt

la $t4, table

for1_entry:
slti $t3, $t0, 256
beqz $t3, for1_exit

sll $t7, $t0, 2
add $t5, $t4, $t7
li $t6, -1
sw $t6, 0($t5)

addi $t0, $t0, 1
j for1_entry
for1_exit:

li $t0, 0 # i

for2_entry:
slt $t3, $t0, $a2
beqz $t3, for2_exit

add $t5, $t0, $a3 # t5 = &pattern[i]
lb $t5, 0($t5) # t5 = pattern[i]
sll $t5, $t5, 2
add $t5, $t5, $t4
sw $t0, 0($t5)

addi $t0, $t0, 1
j for2_entry
for2_exit:

addi $t0, $a2, -1

while1_entry:
slt $t3, $t0, $a0
beqz $t3, while1_exit

li $t1 0  # j

while2_entry:
addi $t5, $a2, -1
sub $t5, $t5, $t1
add $t5, $t5, $a3
lb $t5, 0($t5)
sub $t6, $t0, $t1 
add $t6, $t6, $a1
lb $t6, 0($t6)
sub $t5, $t5, $t6
nor $t5, $t5, $zero
slt $t6, $t1, $a2
and $t5, $t5, $t6
beqz $t5, while2_exit
addi $t1, $t1, 1
j while2_entry
while2_exit:

bne $t1, $a2, jump1
addi $t2, $t2, 1
jump1:

add $t5, $t0, $a1
lb $t5, 0($t5)
sll $t5, $t5, 2
add $t5, $t5, $t4
lw $t5, 0($t5)
addi $t5, $t5, 1
sub $t6, $a2, $t1
slt $t5, $t5, $t6

li $t6, 1
beq $t5, $t6, jump2

addi $t0, $t0, 1
j end

jump2:
add $t5, $t0, $a1
lb $t5, 0($t5)
sll $t5, $t5, 2
add $t5, $t5, $t4
lw $t5, 0($t5)
sub $t5, $a2, $t5
addi $t5, $t5, -1
add $t0, $t0, $t5

end:

j while1_entry
while1_exit:

move $v0, $t2
jr $ra