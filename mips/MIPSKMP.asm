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
beqz $t4, E2
addi $t5, $t5, 1
addi $t6, $t6, 4
j P2
E2:
move $a2, $t5
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
sll $t5, $t1, 2
add $t5, $t5, $a3
lw $t5, 0($t5)
sll $t6, $t0, 2
add $t6, $t6, $a1
lw $t6, 0($t6)
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
j EXIT
generateNext:
li $t0, 1
li $t1, 0
beqz $a1, end
li $t2, 0
sw $t2, 0($a0)
while1_entry:
slt $t2, $t0, $a1
beqz $t2, while1_exit
sll $t3, $t0, 2
add $t3, $t3, $a2
lw $t3, 0($t3)
sll $t4, $t1, 2
add $t4, $t4, $a2
lw $t4, 0($t4)
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
EXIT:
j EXIT