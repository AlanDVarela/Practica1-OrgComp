#Practica 1: Torres de Hanoi
#Fecha: 24 - Oct - 2024
#Autor: Alan David Varela Maldonado
#Descripcion: Resolver el problema de las torres de Hanoi
#             utilizando un algoritmo recursivo en RISC V

.text

main:
    addi sp, sp, -16    # Reservar espacio en el stack
    sw ra, 12(sp)       # Guardar el valor de ra en el stack
    sw s0, 8(sp)        # Guardar s0 en el stack

    addi t0, zero, 3    # Definir el numero de discos (3 discos)
    addi t1, zero, 0    # Definir el disco inicial (0 = A)
    addi t2, zero, 1    # Definir el disco final (1 = B)
    addi t3, zero, 2    # Definir el disco final (2 = C)
    jal hanoi           # Llamar a la funcion hanoi


hanoi: #Entradas a0 - torre origen, a1, - torre destino, a2 - torre aux
    addi sp, sp, -16    # Reservar espacio en el stack
    sw t0, 0(sp)        # Guardar el numero de discos en el stack
