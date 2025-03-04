.global lab1
.syntax unified
.cpu cortex-m4
.thumb

lab1:
    push {lr}          @ Збереження лінк-регістра

    ldr r0, =A        @ Завантаження адреси змінної A
    ldr r0, [r0]      @ Завантаження значення A
    ldr r1, =B        @ Завантаження адреси B
    ldr r1, [r1]      @ Завантаження значення B
    and r2, r0, r1    @ Виконання побітового \"І\" (a & b)

    ldr r3, =SHIFT    @ Завантаження адреси SHIFT
    ldr r3, [r3]      @ Завантаження значення SHIFT
    lsrs r2, r2, r3   @ Логічний зсув вправо (a & b) >> SHIFT

    ldr r4, =C        @ Завантаження адреси C
    ldr r4, [r4]      @ Завантаження значення C
    bl factorial      @ Виклик функції факторіала
    add r2, r2, r0    @ Додавання факторіала c до результату

    pop {pc}          @ Повернення з функції

factorial:
    push {r1, r2, lr} @ Збереження регістрів
    mov r1, #1        @ Початкове значення факторіала
    cmp r4, #1        @ Перевірка, чи c <= 1
    ble end_fact      @ Якщо так, вихід

fact_loop:
    mul r1, r1, r4    @ r1 *= r4
    subs r4, r4, #1   @ r4--
    cmp r4, #1        @ Перевірка, чи r4 > 1
    bgt fact_loop     @ Повторити, якщо r4 > 1

end_fact:
    mov r0, r1        @ Запис результату у r0
    pop {r1, r2, pc}  @ Відновлення регістрів та повернення

.section .data
A: .word 4  @ Значення a
B: .word 2  @ Значення b
C: .word 3  @ Значення c
SHIFT: .word 1  @ Кількість бітів для зсуву

