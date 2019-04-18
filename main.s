/**********************************
Universidad del Valle de Guatemala
Organizacion de computadoras y Assembler
Gustavo Mendez y Diego Estrada

- File: mais.s
***********************************/

.data
.align 2
@Message strings
welcomeMessage: .asciz "******* BIENVENIDO ******\n"
player1MessageInfo: .asciz "- El jugador 1 es representado por la letra 'x'.\n"
player2MessageInfo: .asciz "- El jugador 2 representado por la letra 'o'.\n"
emptyInputMessage: .asciz "- Espacio vacio representado por ' '.\n"
winnerMessage: .asciz "NUEVO GANADOR: Jugador %d!\n"
draw: .asciz "Ha ocurrido un EMPATE!"


.text
.align 2
.global main
.type main,%function
main:
	stmfd sp!,{lr}

	winner .req r5
	cont .req r6
	mov cont, #0
	mov winner, #0

	/* Displaying messages */
	ldr r0, =welcomeMessage
	bl printf
	mov r0, #0

	/* Displaying instructions */
	ldr r0, =player1MessageInfo
	bl printf
	mov r0, #0
	ldr r0, =player2MessageInfo
	bl printf
	ldr r0, =emptyInputMessage
	bl printf

