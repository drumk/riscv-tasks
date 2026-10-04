.data
prompt_x: .asciz "Введите число x: "
space: .asciz " "
newline: .asciz "\n"
group_y: .word 10    # ЗАМЕНИТЕ 10 на номер вашей группы!
student_h: .word 5   # ЗАМЕНИТЕ 5 на ваш номер в списке!

.text
.globl main
main:
    # Выводим приглашение
    la a0, prompt_x
    li a7, 4
    ecall

    # Считываем x
    li a7, 5
    ecall
    mv t0, a0           # t0 = x

    # Загружаем y и h
    la t1, group_y
    lw t1, 0(t1)        # t1 = y
    la t2, student_h
    lw t2, 0(t2)        # t2 = h

    # Определяем min и max
    # t3 = min, t4 = max
    ble t0, t1, x_less_y
    
    # Если x > y
    mv t3, t1           # min = y
    mv t4, t0           # max = x
    j loop_start

x_less_y:
    # Если x <= y
    mv t3, t0           # min = x
    mv t4, t1           # max = y

loop_start:
    # Проверяем, не вышли ли за границу max
    bgt t3, t4, end_loop

    # Выводим текущее число (min)
    mv a0, t3
    li a7, 1
    ecall

    # Выводим пробел
    la a0, space
    li a7, 4
    ecall

    # Прибавляем шаг h
    add t3, t3, t2
    j loop_start

end_loop:
    # Переход на новую строку для красоты
    la a0, newline
    li a7, 4
    ecall

    # Завершение
    li a7, 10
    ecall