#Practica 1: Torres de Hanoi
#Fecha: 24 - Oct - 2024
#Autor: Alan David Varela Maldonado
#Descripcion: Resolver el problema de las torres de Hanoi
#             utilizando un algoritmo recursivo en RISC V

.data
	torreA: .word 0x10010000    # Dirección para la torre A
.text 
    addi s0, zero, 3              # Número de discos, cambiar aquí para N discos
    la   a1, torreA                 # Dirección de Torre A (origen)
   
# Distribuir los discos en la torre de origen (Torre A)
    addi   t0, zero, 1              # Contador de discos
inicializarTorreA:
    bgt  t0, s0, main	            # Si t0 > s0, terminar la inicialización
    sw   t0, 0(a1)        	    # Colocar el disco en la torre A
    addi a1, a1, 32                 # Avanzar a la siguiente posición en torre A
    addi t0, t0, 1                  # Incrementar el contador de discos
    j    inicializarTorreA          # Repetir el ciclo
main:
    #Parametros funcion "hanoi(int n, char origen, char destino, char auxiliar)"
    addi   a0, s0, 0                # N discos
    li   a1, 0x10010000             # Direccion de Torre A
    li   a2, 0x10010004             # Direccion de Torre B
    li   a3, 0x10010008             # Direccion de Torre C
    
    jal  ra, hanoi                  # Llamar a la función recursiva hanoi
  
#Fin Programa
  
#Funcion hanoi(n, origen, destino, auxiliar) 
# n = a0, origen = a1, destino = a2, aux = a3
hanoi:
# Caso base: Si n == 1, mover un disco
    addi t1, a0, -1           # t1 = n - 1
    beqz t1, mover_disco      # Si n == 1, saltar a mover_disco

    # Llamar recursivamente para mover n-1 discos de origen a auxiliar
    addi sp, sp, -20             # Reserva espacio en el stack
    sw a0, 16(sp)                # Guardar n
    sw a1, 12(sp)                # Guardar origen
    sw a2, 8(sp)                 # Guardar destino
    sw a3, 4(sp)                 # Guardar auxiliar
    sw ra, 0(sp)                 # Guardar el registro de retorno


mover_disco:
    lw   t0, 0(a1)               # Cargar el disco de la torre origen
    sw   t0, 0(a2)               # Guardar el disco en la torre destino
    addi a1, a1, 32              # Avanzar en la torre origen
    addi a2, a2, 32              # Avanzar en la torre destino