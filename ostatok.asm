.data
	chast: .asciz "\nЧастное: \n"
	ost: .asciz "Остаток: \n" 
	enter: .asciz "\n"
	vvod1: .asciz "Введите первое число: "
	vvod2: .asciz "Введите второе число: "
	err: .asciz "\nДеление на 0 невозможно!"
.text

la a0, vvod1
li a7, 4
ecall
li a7, 5
ecall
mv t0, a0
la a0, vvod2
li a7, 4
ecall
li a7, 5
ecall
mv t1, a0

mv t3, t1
mv t4, t1
li s1, 0

beqz t1, if_error # если второе число = 0 -> это ошибка

bltz t0, if_first_number_negative
beqz t0, if_first_number_zero
bgtz t0, if_first_number_positive

# если первое число положительно
if_first_number_positive:
bgtz t3, before_while_1_check_second_number
bltz t4, before_while_1_check_second_number_mod
mv t2, t0
while1:
bgt t4, t0, end_while1
add t0, t3, t0
addi s1, s1, 1
j while1
end_while1:
bltz t1, check_chast 
end_while1_continue:
la a0, ost
li a7, 4
ecall
mv a0, t0
li a7, 1
ecall
la a0, chast
li a7, 4
ecall
mv a0, s1
li a7, 1
ecall
j end

before_while_1_check_second_number:
neg t3, t1
j if_first_number_positive

before_while_1_check_second_number_mod:
neg t4, t1
j if_first_number_positive

check_chast:
neg s1, s1
j end_while1_continue






if_first_number_negative:
# если первое число отрицательное
#mv a0, t0
#li a7, 1
#ecall
bgtz t3, before_while_2_check_second_number
bltz t4, before_while_2_check_second_number_mod
neg t0, t0
mv t2, t0
while2:
bgt t4, t0, end_while2
add t0, t3, t0
addi s1, s1, 1
j while2
end_while2:
bgtz t1, check_cast_2
check_cast_2_continue:
la a0, ost
li a7, 4
ecall
neg t0, t0
mv a0, t0
li a7, 1
ecall
la a0, chast
li a7, 4
ecall
mv a0, s1
li a7, 1
ecall
j end

before_while_2_check_second_number:
neg t3, t1
j if_first_number_negative

before_while_2_check_second_number_mod:
neg t4, t1
j if_first_number_negative

check_cast_2:
neg s1, s1
j check_cast_2_continue






if_first_number_zero:
# если первое число равно нулю
la a0, ost
li a7, 4
ecall
mv a0, t1
li a7, 1
ecall
la a0, chast
li a7, 4
ecall
mv a0, t0
li a7, 1
ecall
j end

if_error:
la a0, err
li a7, 4
ecall
end:



