#Practica 1: Torres de Hanoi
#Fecha: 24 - Oct - 2024
#Autor: Alan David Varela Maldonado
#Descripcion: Resolver el problema de las torres de Hanoi
#             utilizando un algoritmo recursivo en RISC V

.data
	torreA: .word 0x10010000        # Dirección para la torre A
.text 
    addi s0, zero, 3                # Número de discos, cambiar aquí para N discos
    la   a1, torreA                 # Dirección de Torre A (origen)
   
# Distribuir los discos en la torre de origen (Torre A)
    addi   t0, zero, 1              # Contador de discos
inicializarTorreA:
    bgt  t0, s0, main	            # Si t0 > s0, terminar la inicialización
    sw   t0, 0(a1)        	        # Colocar el disco en la torre A
    addi a1, a1, 32                 # Avanzar a la siguiente posición en torre A
    addi t0, t0, 1                  # Incrementar el contador de discos
    j    inicializarTorreA          # Repetir el ciclo
main:
    #Parametros funcion "hanoi(int n, char origen, char destino, char auxiliar)"
    addi   a0, s0, 0                # N discos
    li   a1, 0x10010000             # Direccion de Torre A
    li   a2, 0x10010004             # Direccion de Torre B
    li   a3, 0x10010008             # Direccion de Torre C