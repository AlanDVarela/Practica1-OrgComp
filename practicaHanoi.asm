# Practica 1: Torres de Hanoi - Simulación de registros
# Fecha: 24 - Oct - 2024
# Autor: Alan David Varela Maldonado
# Descripcion: Simulación de las Torres de Hanoi
#              Visualizando únicamente el comportamiento en los registros
# Definimos las direcciones de las torres solo como referencia para cargar los valores
 .data
    torreA: .word 0x10010000    # Dirección base de Torre A
.text
     addi s0, zero, 3              # Número de discos, cambiar aquí para N discos
     la   a1, torreA                 # Dirección de Torre A (origen)
     
     #Distribuir los discos en la torre de origen (Torre A)
    addi   t0, zero, 1              # Contador de discos
inicializarTorreA:
    bgt  t0, s0, main	            # Si t0 > s0, terminar la inicialización
    sw   t0, 0(a1)        	    # Colocar el disco en la torre A
    addi a1, a1, 32                 # Avanzar a la siguiente posición en torre A
    addi t0, t0, 1                  # Incrementar el contador de discos
    j    inicializarTorreA          # Repetir el ciclo
    
main: 
    # Parámetros iniciales para las torres A, B y C
    la   a1, torreA               # Dirección de Torre A (origen)
    li   a2, 0x10010008           # Dirección de Torre C (destino)
    li   a3, 0x10010004           # Dirección de Torre B (auxiliar)

    # Llamar a la función recursiva hanoi
    add  a0, zero, s0            	# N discos
    jal   ra, hanoi               # Llamar a hanoi(3, A, C, B)

    # Fin del programa
    li   a7, 10                   #Salir
    ecall

# Función recursiva hanoi(n, origen, destino, auxiliar)
# Parámetros:
#   a0 = número de discos (n)
#   a1 = origen (dirección de la torre origen)
#   a2 = destino (dirección de la torre destino)
#   a3 = auxiliar (dirección de la torre auxiliar)
hanoi:
    addi t1, zero, 1              # t1 = 1, para comparar con n
    beq  a0, t1, mover_disco      # Si n == 1, mover el disco

    # Guardar registros antes de la llamada recursiva
    addi sp, sp, -20              # Reservar espacio en el stack
    sw   a0, 16(sp)               # Guardar n
    sw   a1, 12(sp)               # Guardar origen
    sw   a2, 8(sp)                # Guardar destino
    sw   a3, 4(sp)                # Guardar auxiliar
    sw   ra, 0(sp)                # Guardar el valor de retorno

    # Primera llamada recursiva hanoi(n-1, origen, auxiliar, destino)
    addi a0, a0, -1               # n = n - 1
    mv   t2, a2                   # Guardar el destino original en t2
    mv   a2, a3                   # a2 = auxiliar (nuevo destino)
    mv   a3, t2                   # a3 = destino original (nuevo auxiliar)
    jal  ra, hanoi                # Llamada recursiva

    # Restaurar registros después de la primera llamada recursiva
    lw   a0, 16(sp)               # Restaurar n
    lw   a1, 12(sp)               # Restaurar origen
    lw   a2, 8(sp)                # Restaurar destino
    lw   a3, 4(sp)                # Restaurar auxiliar

    # Mover disco de origen a destino
    jal  ra, mover_disco

    # Segunda llamada recursiva hanoi(n-1, auxiliar, destino, origen)
    lw   a0, 16(sp)               # Restaurar n
    lw   a1, 4(sp)                # Restaurar auxiliar (nuevo origen)
    lw   a2, 8(sp)                # Restaurar destino
    lw   a3, 12(sp)               # Restaurar origen (nuevo auxiliar)
    addi a0, a0, -1               # n = n - 1
    jal  ra, hanoi                # Llamada recursiva

    # Restaurar registros y retornar
    lw   ra, 0(sp)                # Restaurar el valor de retorno
    addi sp, sp, 20               # Liberar espacio en el stack
    jr   ra                       # Retornar

# Función para mover el disco de la torre origen a la torre destino
# Parámetros:
#   a0 = número de discos (n)
#   a1 = origen (dirección de la torre origen)
#   a2 = destino (dirección de la torre destino)
mover_disco:
    # Mostrar los valores en los registros (simulación del movimiento)
    mv t0, a0        # Guardar el número de disco en t0 (número de disco)
    mv t1, a1        # Guardar la dirección de la torre origen en t1
    mv t2, a2        # Guardar la dirección de la torre destino en t2
    # Visualizar en memoria moviemiento disco
    
    
    
    
    
    
    jr ra            # Retornar de la función mover_disco
