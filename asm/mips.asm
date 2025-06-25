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
li $s0, 0 #len_pattern = 0
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
jal kmp

#printf
move $a0, $v0
li $v0, 1
syscall
#return 0
li $a0, 0
li $v0, 17
syscall

kmp: # 参数表：$a0: len_str  $a1: str  $a2: len_pattern  $a3: pattern
##### your code here #####

li $t0, 0 
li $t1, 0 
li $t2, 0 

li $t5, 0
move $t6, $a1
P1:
lw $t4, 0($t6)
beqz $t4, E1
addi $t5, $t5, 1
addi $t6, $t6, 4
j P1
E1:
move $a0, $t5
li $t5, 0
move $t6, $a3
P2:
lw $t4, 0($t6)
beqz $t4, E1
addi $t5, $t5, 1
addi $t6, $t6, 4
j P1
E2:
move $a2, $t5

move $t4, $a0
move $a0, $a2
add $a0, $a0, $a2
add $a0, $a0, $a2
add $a0, $a0, $a2

li $v0, 9
syscall

move $t3, $v0   # $t3为申请内存地址
move $a0, $t4   #复原$a0

addi $sp, $sp, -36
sw $t3, 32($sp)
sw $t2, 28($sp)
sw $t1, 24($sp)
sw $t0, 20($sp)
sw $ra, 16($sp)
sw $a0, 12($sp)
sw $a1, 8($sp)
sw $a2, 4($sp)
sw $a3, 0($sp)

move $a0, $t3
move $a1, $a2
move $a2, $a3
jal generateNext

lw $t3, 32($sp)
lw $t2, 28($sp)
lw $t1, 24($sp)
lw $t0, 20($sp)
lw $ra, 16($sp)
lw $a0, 12($sp)
lw $a1, 8($sp)
lw $a2, 4($sp)
lw $a3, 0($sp)
addi $sp, $sp, 36


while2_entry:
slt $t4, $t0, $a0
beqz $t4, while2_exit

#sll $t5, $t1, 2
add $t5, $t1, $a3
lb $t5, 0($t5)
#sll $t6, $t0, 2
add $t6, $t0, $a1
lb $t6, 0($t6)

sub $t5, $t5, $t6
bne $t5, $zero, jump3

sub $t5, $t1, $a2
addi $t5, $t5, 1
bne $t5, $zero, jump4
addi $t2, $t2, 1
addi $t6, $a2, -1
sll $t6, $t6, 2 
add $t6, $t6, $t3
lw $t1, 0($t6)
addi $t0, $t0, 1
j endif1
jump4:
addi $t0, $t0, 1
addi $t1, $t1, 1
endif1:
j endif
jump3:
sub $t5, $zero, $t1
slt $t5, $t5, $zero
beqz $t5, jump5
addi $t6, $t1, -1
sll $t6, $t6, 2
add $t6, $t6, $t3
lw $t1, 0($t6)
j endif2
jump5:
addi $t0, $t0, 1
endif2:
endif:
j while2_entry
while2_exit:
move $v0, $t2
jr $ra

generateNext:
li $t0, 1
li $t1, 0
beqz $a1, end
li $t2, 0
sw $t2, 0($a0)
while1_entry:
slt $t2, $t0, $a1
beqz $t2, while1_exit
#sll $t3, $t0, 2
add $t3, $t0, $a2
lb $t3, 0($t3)
#sll $t4, $t1, 2
add $t4, $t1, $a2
lb $t4, 0($t4)
sub $t3, $t3, $t4
bne $t3, $zero, jump1
sll $t3, $t0, 2
add $t3, $t3, $a0
addi $t4, $t1, 1
sw $t4, 0($t3) 
addi $t0, $t0, 1
addi $t1, $t1, 1
j if_else_end
jump1:
sub $t3, $zero, $t1
slt $t3, $t3, $zero
beq $t3, $zero, jump2
addi $t4, $t1, -1
sll $t4, $t4, 2
add $t4, $t4, $a0
lw $t1, 0($t4)
j if_else_end
jump2:
sll $t3, $t0, 2
add $t3, $t3, $a0
sw $zero, 0($t3)
addi $t0, $t0, 1
if_else_end:
j while1_entry
while1_exit:
li $v0, 0
jr $ra
end:
li $v0, 1
jr $ra
