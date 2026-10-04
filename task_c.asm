.data
array: .space 400       # Выделяем память под массив (с запасом)
prompt: .asciz "Вводите числа (0 для остановки):\n"
size_msg: .asciz "Итоговый размер массива: "
newline: .asciz "\n"
N_val: .word 5          # ЗАМЕНИТЕ 5 на ваш номер в списке!
                        # Тогда размер массива будет 16 + 5 = 21

.text
.globl main
main:
    # Выводим приглашение
    la a0, prompt
    li a7, 4
    ecall

    li t0, 0            # t0 = счетчик (i)
    
    # Вычисляем 16 + n
    la t1, N_val
    lw t1, 0(t1)
    addi t1, t1, 16     # t1 = 16 + n (максимальный размер)
    
    la t2, array        # t2 = адрес начала массива

read_loop:
    # Проверяем, не достигли ли лимита 16+n
    bge t0, t1, end_read

    # Считываем число
    li a7, 5
    ecall
    mv t3, a0           # t3 = введенное число

    # Если введен 0 - завершаем чтение
    beqz t3, end_read

    # Сохраняем число в массив
    slli t4, t0, 2      # t4 = i * 4 (сдвиг влево на 2 = умножение на 4)
    add t4, t2, t4      # t4 = адрес array[i]
    sw t3, 0(t4)        # Сохраняем слово

    # Увеличиваем счетчик
    addi t0, t0, 1
    j read_loop

end_read:
    # Выводим сообщение
    la a0, size_msg
    li a7, 4
    ecall

    # Выводим итоговый размер массива (сколько чисел реально считано)
    mv a0, t0
    li a7, 1
    ecall

    # Новая строка
    la a0, newline
    li a7, 4
    ecall

    # Завершение
    li a7, 10
    ecall