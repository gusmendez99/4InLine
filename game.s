/**********************************
Universidad del Valle de Guatemala
Organizacion de computadoras y Assembler
Gustavo Mendez y Diego Estrada

- File: game.s
***********************************/

.data
.align 2

@Matrix column-based
currentColumn: .word 0
column1: .word 0,0,0,0
column2: .word 0,0,0,0
column3: .word 0,0,0,0
column4: .word 0,0,0,0

@Console messages
inputColumnMessage: .asciz "Ingrese columna jugador %d (1, 2, 3, 4): "
errorMessage: .asciz "--- Numero invalido, intente de nuevo ---\n"
fullMatrixMessage: .asciz "--- La columna se encuentra llena! ---\n"
@Inputs
columnEntered: .asciz "%d"
matrixSpace: .asciz "|%d|"
enter: .asciz "\n"


.text
.align 2


.global printBoard
printBoard:
    /*inefficient way of printing, improve this part later*/
	push {lr} @store the link register
	column1 .req r5 @column1 variable
	column2 .req r6 @column2 variable
	column3 .req r7 @column3 variable
	column4 .req r8 @column4 variable
    
	ldr column1, =column1
	ldr column2, =column2
	ldr column3, =column3
	ldr column4, =column4
    
    /*1st row*/
	add column1, #12
	add column2, #12
	add column3, #12
	add column4, #12
    @Printing
	ldr r0, =matrix
	ldr r1, [column1]
	bl printf
	ldr r0, =matrix
	ldr r1, [column2]
	bl printf
	ldr r0, =matrix
	ldr r1, [column3]
	bl printf
	ldr r0, =matrix
	ldr r1, [column4]
	bl printf
	ldr r0, =enter
	bl printf
	
    /*2nd row*/
	add column1, #-4
	add column2, #-4
	add column3, #-4
	add column4, #-4
	@Printing
	ldr r0, =matrix
	ldr r1, [column1]
	bl printf
	ldr r0, =matrix
	ldr r1, [column2]
	bl printf
	ldr r0, =matrix
	ldr r1, [column3]
	bl printf
	ldr r0, =matrix
	ldr r1, [column4]
	bl printf
	ldr r0, =enter
	bl printf
	
    /*3rd row*/
	add column1, #-4
	add column2, #-4
	add column3, #-4
	add column4, #-4
	@Printing
	ldr r0, =matrix
	ldr r1, [column1]
	bl printf
	ldr r0, =matrix
	ldr r1, [column2]
	bl printf
	ldr r0, =matrix
	ldr r1, [column3]
	bl printf
	ldr r0, =matrix
	ldr r1, [column4]
	bl printf
	ldr r0, =enter
	bl printf
	
    /*4th row*/
	add column1, #-4
	add column2, #-4
	add column3, #-4
	add column4, #-4
    @Printing
	ldr r0, =matrix
	ldr r1, [column1]
	bl printf
	ldr r0, =matrix
	ldr r1, [column2]
	bl printf
	ldr r0, =matrix
	ldr r1, [column3]
	bl printf
	ldr r0, =matrix
	ldr r1, [column4]
	bl printf
	ldr r0, =enter
	bl printf

	.unreq column1
	.unreq column2
	.unreq column3
	.unreq column4
	pop {lr}
	mov pc, lr