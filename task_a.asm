.data
prompt: .asciz "Введите число x: "
my_number: .word 5  # ЗАМЕНИТЕ 5 на ваш номер в списке группы!

.text
.globl main
main:
    # Выводим приглашение к вводу
    la a0, prompt
    li a7, 4
    ecall

    # Считываем число x
    li a7, 5
    ecall
    mv t0, a0           # t0 = x

    # Загружаем наш номер
    la t1, my_number
    lw t1, 0(t1)        # t1 = my_number

    # Сравниваем
    beq t0, t1, match   # Если x == my_number, прыгаем на match
    
    # Если не совпало - выводим 0
    li a0, 0
    j print_result

match:
    # Если совпало - выводим 1
    li a0, 1

print_result:
    li a7, 1
    ecall               # Вывод результата

    # Завершение программы
    li a7, 10
    ecall