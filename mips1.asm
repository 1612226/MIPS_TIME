.data
Sat: .asciiz "Saturday"
Sun: .asciiz "Sunday"
Mon: .asciiz "Monday"
Tue: .asciiz "Tuesday"
Wed: .asciiz "Wednesday"
Thur: .asciiz "Thursday"
Fri: .asciiz "Friday"

ReadDay: .asciiz "Nhap ngay DAY: "
ReadMonth: .asciiz "Nhap thang MONTH: "
ReadYear: .asciiz "Nhap nam YEAR: "

menu: .asciiz "\n----------Ban hay chon 1 trong cac thao tac duoi day ------\n"
s1: .asciiz "1. Xuat chuoi TIME theo dinh dang DD/MM/YYYY \n"
s2: .asciiz "2. Chuyen doi chuoi TIME thanh mot trong cac dinh dang sau và xuat ra: \n"
s2a: .asciiz "		A. MM/DD/YYYY\n"
s2b: .asciiz "		B. Month DD, YYYY \n"
s2c: .asciiz "		C. DD Month, YYYY \n"
s3: .asciiz "3. Cho biet ngay vua nhap là ngay thu may trong tuan\n"
s4: .asciiz "4. Kiem tra nam trong chuoi TIME co phai là nam nhuan khong \n"
s5: .asciiz "5. Cho biet khoang thoi gian giua chuoi TIME_1 va TIME_2 \n"
s6: .asciiz "6. Cho biet 2 nam nhuan gan nhat voi nam trong chuoi time \n"
s7: .asciiz "7. Thoat \n"


choice: .asciiz "Lua chon: "

day: .byte    '\0':20
month: .byte    '\0':20
year: .byte    '\0':20
string_temp: .asciiz "123"
month_day: .byte 31, 0, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31
date_valid: .asciiz "Hop le"
date_unvalid: .asciiz "Khong hop le"
TIME: .byte '\0':11

.text

main:

addi $a1, $0, 20 # max length of input

la $a0, ReadDay
addi $v0, $0, 4
syscall 
#read day
la $a0, day       #buffer
addi $v0, $0, 8                   
syscall

la $a0, ReadMonth
addi $v0, $0, 4
syscall 
#read month
la $a0, month
addi $v0, $0, 8
syscall

la $a0, ReadYear
addi $v0, $0, 4
syscall 
#read year
la $a0, year
addi $v0, $0, 8
syscall         
#### check
la $a0, year
jal string_modify
la $a2, ($v0)

la $a0, month
jal string_modify
la $a1, ($v0)

la $a0, day
jal string_modify
la $a0, ($v0)

jal check


# exit
addi $v0,$0,10
syscall



#MENU ------------------------
	
	li $v0, 4			

	la $a0, menu
	syscall
 
	la $a0, s1
	syscall
 
	la $a0, s2
	syscall
 
	la $a0, s2a
	syscall
 
	la $a0, s2b
	syscall
 
	la $a0, s2c
	syscall
 
	la $a0, s3
	syscall
 
	la $a0, s4
	syscall
 
	la $a0, s5
	syscall

	la $a0, s6
	syscall

	la $a0, s7
	syscall

#END MENU --------------------


#ENTER CHOICE
EnterChoice:
la $a0, choice
addi $v0, $zero, 4
syscall

addi $v0, $zero, 5
syscall

add $t0, $v0, $zero

choice1:
addi $t1, $t0, -1
bne $t1, $0, choice2
#1. xuat chuoi time
#  char* Date (int, int, int, char*)
# input: $a0 day, $a1 month, $a2 year, $a3 address
# output: $v0 DD/MM/YYYY or "\0" if not is date (su dung lai ham o tren)
 
Date:
	# kiem tra input co hop le
	addi $t0, $0, 47  # kí t? '/'
	addi $t1, $0, 0   # bi?n l?u ch? s? khi tách
	addi $t2, $0, 10  # s? chia
	#day
	div  $a0, $t2
	mflo $t1
	addi $t1, $t1, 48 # chuy?n thành kí t?
	sb   $t1, 0($a3)
	mfhi $t1
	addi $t1, $t1, 48
	sb   $t1, 1($a3)
	sb   $t0, 2($a3)
	#month
	div  $a1, $t2
	mflo $t1
	addi $t1, $t1, 48
	sb   $t1, 3($a3)
	mfhi $t1
	addi $t1, $t1, 48
	sb   $t1, 4($a3)
	sb   $t0, 5($a3)
	#year
	addi $t2, $0, 1000
	div  $a2, $t2
	mflo $t1
	addi $t1, $t1, 48
	sb   $t1, 6($a3)
	mfhi $t3    # issue, $t3 is temporary to save  quotient
	addi $t2, $0, 100
	div  $t3, $t2
	mflo $t1
	addi $t1, $t1, 48
	sb   $t1, 7($a3)
	mfhi $t3
	addi $t2, $0, 10
	div  $t3, $t2
	mflo $t1
	addi $t1, $t1, 48
	sb   $t1, 8($a3)
	mfhi $t1
	addi $t1, $t1, 48
	sb   $t1, 9($a3)
 
	add  $v0, $a3, $0
	jr   $ra

#
j endChoice
choice2:
addi $t1, $t0, -2
bne $t1, $0, choice3
#2.chuyen doi chuoi time

#
j endChoice
choice3:                                    
addi $t1, $t0, -3
bne $t1, $0, choice4
#3. cho biet ngay thu may trong tuan

#
j endChoice
choice4:
addi $t1, $t0, -4
bne $t1, $0, choice5
#4. kiem tra nam nhuan

#
j endChoice
choice5:
addi $t1, $t0, -5
bne $t1, $0, choice6
#5. cho biet khoang cach giua 2 time

#
j endChoice
choice6:
addi $t1, $t0, -6
bne $t1, $0, anotherchoice
#6. cho biet 2 nam nhuan gan nhat

#
j endChoice
anotherchoice:
#yeu cau nhap lai
j EnterChoice

endChoice:
#END ENTERCHOICE

#exit
add $v0, $0, 10
syscall
j endmain




endmain:                                                                                                                                                                                                                         
addi $v0,$0,10
syscall



###############################
string_to_num:
	addiu $sp, $sp, -4
 	sw $a0, 0($sp)
	addi $t1, $0, 10 # set t1 to 10
	addu $t2, $0, $0
	stn_sum_loop:
		lb $t0, ($a0) # load every byte from $a0 to t1
		addiu $a0, $a0, 1
		beq $t0, 0, stn_end_sum_loop
		mult $t2, $t1 # v0 *= 10
		mflo $t2
		subu $t0, $t0, '0' # t0 -= '0'
		addu $t2, $t2, $t0
		j stn_sum_loop
	stn_end_sum_loop:
		addu $v0, $t2, $0
		lw $s0, 0($sp)
		addiu $sp, $sp, 4
		jr $ra
string_modify:
	addiu $sp, $sp, -4
	la $t0, ($a0)
	sw $t0, ($sp)
	sm_loop:
		lb $t0, ($a0)
		beq $t0, 10, exit
		addiu $a0, $a0, 1
		j sm_loop
	exit:
		addiu $t1, $0, 0
		sb $t1, ($a0)
		lw $v0,  ($sp)
		addiu $sp, $sp, 4
		jr $ra
		
# get length of a string ($a0 is the address of string, $v0 is the length)
string_length:
	addu $v0, $0, $0 #init the return value to 0
	length_loop:
		lb $t0, ($a0)
		addiu $a0, $a0, 1
		beq $t0, 0, end_length_loop
		addiu $v0, $v0, 1
		j length_loop
	end_length_loop:
		jr $ra
		
#date
# int Day (char* TIME)
# input: $a0 address
# output: $v0 day
Day:
	lb   $t0, 0($a0)  # l?y kí t? ?àu
	subi $t0, $t0, 48
	lb   $t1, 1($a0)  # l?y kí t? th? 2
	subi $t1, $t1, 48
	addi $t2, $0, 10  # gán $t2 = 10
 	mult $t0, $t2
 	mflo $v0
 	add  $v0, $v0, $t1
 
 	jr   $ra
 #month
  Month:
 	lb   $t0, 3($a0)
 	subi $t0, $t0, 48
 	lb   $t1, 4($a0)
 	subi $t1, $t1, 48
 	addi $t2, $0, 10
 	mult $t0, $t2
 	mflo $v0
 	add  $v0, $v0, $t1
 	jr   $ra
 #year
 Year:
	addiu $sp, $sp, -8
	sw $ra, ($sp)
	sw $a0, -4($sp)
	addu $t1, $0, $0
	addiu $t2, $0, 2
	year_loop:
		lb $t0, ($a0)
		beq $t1, $t2, end_year_loop # check if t1 equal to 2 (there are 2 /)
		bne $t0, 47, end_count_t1 
		addiu $t1, $t1, 1
		end_count_t1:
		addiu $a0, $a0, 1
		j year_loop
	end_year_loop:
		jal string_to_num
		lw $ra, ($sp)
		lw $a0, -4($sp)
		addiu $sp, $sp, 8
		jr $ra
#leapyear
LeapYear:
# s2 : year
# if (((year % 4 == 0) && (year % 100!= 0)) || (year%400 == 0))
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	jal Year
	add $s2, $v0, $zero
	addi $t0, $zero, 4
	div $s2, $t0
	mfhi $t1 #t1 = year % 4
 
	addi $t0, $zero, 100
	div $s2, $t0
	mfhi $t2 #t2 = year % 100
 
	addi $t0, $zero, 400
	div $s2, $t0
	mfhi $t3 #t3 = year % 400
 
 
	bne $t1, $zero, False
	bne $t2, $zero, True
	beq $t3, $zero, True
	False: 
	add, $v0, $zero, $zero
	j endLeapYear
 
	True: 
	addi, $v0, $zero, 1
 
	endLeapYear: 
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	jr $ra

#num to string	
num_to_string:
	addiu $sp, $sp, -104
	sw $a0, -100($sp)
	la $t0, 0($sp)
	addu $t4, $0, $0
	sb $t4, ($t0)
	add $t0, $t0, -1
	addiu $t1, $0, 10 # set t1 to 10
	nts_sum_loop:
		beq $a0, $0, nts_end_sum_loop
		div $a0, $t1
		mfhi $t2 # t2 = a0 % 10
		mflo $a0 # a0 /= 10
		addu $t2, $t2, '0' # t2 += '0'
		sb $t2, ($t0)
		addiu $t0, $t0, -1 # Decrease t0 by 1
		j nts_sum_loop
	nts_end_sum_loop:
		.data
		nts_temp_string: .space 100
		.text
		la $t2, nts_temp_string
		addiu $t0, $t0, 1 #because t0 address is smaller than 1
		loop:
			lb $t1, ($t0) 
			beq $t1, 0, end_loop # loop when t1 is nul(end of string)
			sb $t1, ($t2)
			addiu $t2, $t2, 1
			addiu $t0, $t0, 1
			j loop
		end_loop:
			sb $t1, ($t2)
			la $v0, nts_temp_string
			lw $a0, -100($sp)
			addiu $sp, $sp, 104
			jr $ra
## check valid ------------------------
# int isNumber(char* )
# input: $a0 address string
# output: int: number, 0: contain alphabet	
isNumber:		
	addi $sp, $sp, -8
	sw   $ra, 0($sp)
	sw   $a0, 4($sp)
 
	jal  string_length
	add  $t1, $v0, $0   # $t1: string length $a0
	addi  $t0, $0, 0       # index i
	lw    $a0, 4($sp)    #load $a0 because after length, $a0 has change
	while:
		slt $t2, $t0, $t1    # while (i<length)
		beq $t2, $0, exitWhile
		lb  $t3, 0($a0)     # load byte to $t3_character in string
		slti $t2, $t3, 48
		bne $t2, $0, return
		slti $t2, $t3, 58
		beq $t2, $0, return
		# i++
		addi $t0, $t0, 1
		addi $a0, $a0, 1
		j while
 
	exitWhile:  # full number
		lw  $a0, 4($sp)
		jal string_to_num   # $v0 ko doi
		lw  $ra, 0($sp)
		addi $sp, $sp, 8
		jr  $ra
	return:   # contain character
		addi $v0, $0, 0
		lw   $ra, 0($sp)
		addi $sp, $sp, 8
		jr   $ra
                     
check:
	#$a0,$a1,$a2 day,month,year address
	addi $sp, $sp, -16
	sw   $ra, 0($sp)
	
	jal isNumber
	beq $v0, 0, Not_valid
	addi $t0, $v0, 0
	sw $t0, 8($sp)
	
	add $a0, $a1, $0
	jal isNumber
	beq $v0, 0, Not_valid
	addi $t1, $v0, 0
	sw $t1, 12($sp)
	
	add $a0, $a2, $0
	jal isNumber
	beq $v0, 0, Not_valid
	addi $t2, $v0, 0
	
	lw $t0, 8($sp)
	lw $t1, 12($sp)
	
	la $s1, month_day
	lb $s0, ($s1)
	bne $t1, 1, L2
	slt $t7, $s0, $t0
	beq $t7, 1, Not_valid
	slt $t7, $t0, $0
	beq $t7, 1, Not_valid
	j Valid
	L2:
		sw $t0, 4($sp)
		addiu $s1, $s1, 1
		bne $t1, 2, L3
		addiu $a0, $0, 1
		addiu $a1, $0, 1
		addu $a2, $t2, $0
		la $a3, TIME
		jal Date
		addu $a0, $v0, $0
		jal LeapYear
		lw $t0, 4($sp)
		
		beq $v0, $0, L2_notLeapYear
		addiu $s0, $0, 29
		j L2_end
		L2_notLeapYear:
			addiu $s0, $0, 28
		L2_end:
		slt $t7, $s0, $t0
		beq $t7, 1, Not_valid
		slt $t7, $t0, $0
		beq $t7, 1, Not_valid
		j Valid
	L3:
		addiu $s1, $s1, 1
		bne $t1, 3, L4
		lb $s0, ($s1)
		slt $t7, $s0, $t0
		beq $t7, 1, Not_valid
		slt $t7, $t0, $0
		beq $t7, 1, Not_valid
		j Valid
	L4:
		addiu $s1, $s1, 1
		bne $t1, 4, L5
		lb $s0, ($s1)
		slt $t7, $s0, $t0
		beq $t7, 1, Not_valid
		slt $t7, $t0, $0
		beq $t7, 1, Not_valid
		j Valid
	L5:
		addiu $s1, $s1, 1
		bne $t1, 5, L6
		lb $s0, ($s1)
		slt $t7, $s0, $t0
		beq $t7, 1, Not_valid
		slt $t7, $t0, $0
		beq $t7, 1, Not_valid
		j Valid
	L6:
		addiu $s1, $s1, 1
		bne $t1, 6, L7
		lb $s0, ($s1)
		slt $t7, $s0, $t0
		beq $t7, 1, Not_valid
		slt $t7, $t0, $0
		beq $t7, 1, Not_valid
		j Valid
	L7:
		addiu $s1, $s1, 1
		bne $t1, 7, L8
		lb $s0, ($s1)
		slt $t7, $s0, $t0
		beq $t7, 1, Not_valid
		slt $t7, $t0, $0
		beq $t7, 1, Not_valid
		j Valid
	L8:
		addiu $s1, $s1, 1
		bne $t1, 8, L9
		lb $s0, ($s1)
		slt $t7, $s0, $t0
		beq $t7, 1, Not_valid
		slt $t7, $t0, $0
		beq $t7, 1, Not_valid
		j Valid
	L9:
		addiu $s1, $s1, 1
		bne $t1, 9, L10
		lb $s0, ($s1)
		slt $t7, $s0, $t0
		beq $t7, 1, Not_valid
		slt $t7, $t0, $0
		beq $t7, 1, Not_valid
		j Valid
	L10:
		addiu $s1, $s1, 1
		bne $t1, 8, L11
		lb $s0, ($s1)
		slt $t7, $s0, $t0
		beq $t7, 1, Not_valid
		slt $t7, $t0, $0
		beq $t7, 1, Not_valid
		j Valid
	L11:
		addiu $s1, $s1, 1
		bne $t1, 11, L12
		lb $s0, ($s1)
		slt $t7, $s0, $t0
		beq $t7, 1, Not_valid
		slt $t7, $t0, $0
		beq $t7, 1, Not_valid
		j Valid
	L12:
		addiu $s1, $s1, 1
		bne $t1, 12, Not_valid
		lb $s0, ($s1)
		slt $t7, $s0, $t0
		beq $t7, 1, Not_valid
		slt $t7, $t0, $0
		beq $t7, 1, Not_valid
		j Valid
	Valid:
		la $a0, date_valid 
		addi $v0,$0, 4
		syscall
		addi $v0, $0, 1
		j end
	Not_valid: 
		la $a0, date_unvalid
		addi $v0,$0, 4
		syscall
		addi $v0,$0,0
	end:
		# exit
		lw $ra, 0($sp)
		addi $sp, $sp, 16
		jr $ra
