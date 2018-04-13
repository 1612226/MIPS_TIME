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

choice: .asciiz "Lua chon: "

day: .space    20
month: .space   20
year: .space    20

.text

for int i = 0; i < n; i++ 
cin >> a[i] ;
cin	
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



## check valid ------------------------


## end check valid --------------------

#MENU ------------------------


#END MENU --------------------


#ENTER CHOICE

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
bne $t1, $0, choice7
#6. cho biet 2 nam nhuan gan nhat

#
j endChoice
choice7:
addi $t1, $t0, -7
bne $t1, $0, endChoice
#7. Kiem tra hop le

#
j endChoice

endChoice:
#END ENTERCHOICE

#exit
add $v0, $0, 10
syscall
j endmain




endmain:                                                                                                                                                                                                                         
