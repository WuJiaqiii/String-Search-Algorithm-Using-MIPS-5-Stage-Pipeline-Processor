.data
str: .space 512
pattern: .space 512
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

#call brute_force
move $a0, $s0
la $a1, str
move $a2, $s1
la $a3, pattern
jal brute_force

#printf
move $a0, $v0
li $v0, 1
syscall
#return 0
li $a0, 0
li $v0, 17
syscall

# a0: len_str, a2: len_pattern, a1: str, a3: pattern
brute_force:
##### your code here #####
addi $sp, $sp, -20
sw $ra, 16($sp)
sw $a0, 12($sp)
sw $a1, 8($sp)
sw $a2, 4($sp)
sw $a3, 0($sp)

li $t1, 0 # i
li $t3, 0 # cnt

sub $t6, $a0, $a2
addi $t6, $t6, 1

for1_entry:
slt $t0, $t1, $t6 
beqz $t0, for1_exit

li $t2, 0 # j
for2_entry:
slt $t4, $t2, $a2
beqz $t4, for2_exit

add $t5, $t1, $t2 # t5 = i + j
add $t5, $a1, $t5 # t5 = &str[i + j]
lb $t5, 0($t5) # t5 = str[i + j]

add $t7, $a3, $t2 # t7 = &pattern[j]
lb $t7, 0($t7) # t7 = pattern[j]

bne $t5, $t7, for2_exit

addi $t2, $t2, 1
j for2_entry
for2_exit:

bne $t2, $a2, jump1
addi $t3, $t3, 1
jump1:

addi $t1, $t1, 1
j for1_entry
for1_exit:

move $v0, $t3
addi $sp, $sp, 20
jr $ra