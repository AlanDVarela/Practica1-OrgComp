#Practica 1: Torres de Hanoi
#Fecha: 24 - Oct - 2024
#Autor: Alan David Varela Maldonado
#Descripcion: Resolver el problema de las torres de Hanoi
#             utilizando un algoritmo recursivo en RISC V

.data
    torreA: .word 0x10010000    # Dirección base para la torre A
.text 
    addi s0, zero, 3              # Número de discos, cambiar aquí para N discos
    la   a1, torreA               # Dirección de Torre A (origen)

# Distribuir los discos en la torre de origen (Torre A)
    addi   t0, zero, 1              # Contador de discos
inicializarTorreA:
    bgt  t0, s0, main              # Si t0 > s0, terminar la inicialización
    sw   t0, 0(a1)                 # Colocar el disco en la torre A
    addi a1, a1, 32                 # Avanzar a la siguiente posición en torre A
    addi t0, t0, 1                  # Incrementar el contador de discos
    j    inicializarTorreA          # Repetir el ciclo

main:
	addi s2, zero, 1 # S2 = 1, para comparaciones

    # Parámetros función "hanoi(int n, char origen, char destino, char auxiliar)"
    addi   a0, s0, 0                # N discos
    li     a1, 0x10010000           # Dirección de Torre A
    li     a2, 0x10010004           # Dirección de Torre B
    li     a3, 0x10010008           # Dirección de Torre C
    
    jal  ra, hanoi                  # Llamar a la función recursiva hanoi
  
# Fin Programa
#Correcto  
  
  
  
# Función hanoi(n, origen, destino, auxiliar) 
# Parámetros:
#   a0: número de discos
#   a1: origen (dirección de la torre de origen)
#   a2: destino (dirección de la torre de destino)
#   a3: auxiliar (dirección de la torre auxiliar)
hanoi:
    # Caso base: si n == 1, mover un solo disco
    beq a0, s2, mover_disco           # Si n == 1, saltar a mover_disco

    # Guardar registros en el stack antes de la llamada recursiva
    addi sp, sp, -20              # Reservar espacio en el stack
    sw a0, 16(sp)                 # Guardar n
    sw a1, 12(sp)                 # Guardar origen
    sw a2, 8(sp)                  # Guardar destino
    sw a3, 4(sp)                  # Guardar auxiliar
    sw ra, 0(sp)                  # Guardar el valor de retorno
    
    # Mover los primeros n-1 discos de origen a auxiliar
    addi a0, a0, -1               # n = n - 1
    mv   t2, a2                   # t2 = destino (guarda destino temporal)
    mv   a2, a3                   # a2 = auxiliar (nuevo destino temporal)
    jal  ra, hanoi                # Llamada recursiva: hanoi(n-1, origen, auxiliar, destino)

    # Mover el disco n de origen a destino
    lw a0, 16(sp)                 # Restaurar n
    lw a1, 12(sp)                 # Restaurar origen
    lw a2, 8(sp)                  # Restaurar destino
    lw a3, 4(sp)                  # Restaurar auxiliar

mover_disco:
    # Buscar el espacio en la torre destino
    addi t6, zero, 32             # Cargar el valor 32 (Lo que tenemos que recorrer para la siguiente fila de la columna)
    mul t6, t6, a0                # Guardar el resultado de 32 * Numero de discos
    add t5, a2, t6                # Sumar el resultado de la multiplicación a la dirección base de la torre destino

buscar_espacio:
    lw t4, 0(a2)                   # Cargar el valor en la posición actual de la torre destino
    bgt t4, zero, insertar_disco_anterior  # Si la posición está ocupada (t4 > 0), retroceder para insertar disco en la posición anterior
    addi a2, a2, 32                # Avanzar a la siguiente posición en la torre (32 bytes)
    blt a2, t5, buscar_espacio      # Si no hemos llegado al límite, seguir buscando
    j insertar_disco               # Si llegamos al final y no encontramos posición ocupada, insertar el disco en la última posición

insertar_disco_anterior:
    addi a2, a2, -32               # Retroceder a la posición anterior
    j insertar_disco               # Saltar para insertar el disco en la posición anterior

insertar_disco:
    sw a0, 0(a2)                   # Insertar el disco en la posición actual
    ret                            # Retornar


    # Mover los n-1 discos de auxiliar a destino
    lw a0, 16(sp)                 # Restaurar n
    lw a1, 4(sp)                  # Restaurar auxiliar (nuevo origen)
    lw a3, 12(sp)                 # Restaurar origen (nuevo auxiliar)
    addi a0, a0, -1                # n = n - 1
    jal ra, hanoi                  # Llamada recursiva: hanoi(n-1, auxiliar, destino, origen)

    lw ra, 0(sp)                   # Restaurar el valor de retorno
    addi sp, sp, 20                # Liberar el espacio en el stack
    jr ra                          # Retornar
