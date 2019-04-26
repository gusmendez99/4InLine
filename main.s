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
playerOneMessageInfo: .asciz "- El jugador 1 es representado por la letra 'x'.\n"
playerTwoMessageInfo: .asciz "- El jugador 2 representado por la letra 'o'.\n"
emptyInputMessage: .asciz "- Espacio vacio representado por ' '.\n"
winnerMessage: .asciz "NUEVO GANADOR: Jugador %d!\n"
tieMessage: .asciz "Ha ocurrido un EMPATE!"

.text
.align 2
.global main
.type main,%function
main:
	stmfd sp!, {lr}

	winner .req r5
	cont .req r6
	mov cont, #0
	mov winner, #0

	/* Displaying welcome message  */
	ldr r0, =welcomeMessage
	bl printf
	mov r0, #0

	/* Displaying instructions */
	ldr r0, =playerOneMessageInfo
	bl printf
	mov r0, #0
	ldr r0, =playerTwoMessageInfo
	bl printf
	ldr r0, =emptyInputMessage
	bl printf


/**************************

		Player 1 Input

**************************/
playerOneInput:
	mov r1, #0
	mov r0, #1
	bl input

	@Get the inputs, and then insert...
	mov r1, r0		@Column entered
	mov r0, #1		@Player
	bl insertInput
	
	@Printing game board
	bl printBoard
	
	@Check for a winner
	bl getWinner	 @Subroutine on Game Script (game.s)  	
	mov winner, r0
	cmp winner, #0
	bne printWinner

/**************************

		Player 2 Input

**************************/
playerTwoInput:
	mov r1, #0
	mov r0, #2
	bl input
	
	@Get the inputs, and then insert...
	mov r1, r0		@Column entered
	mov r0, #2		@Player	
	bl insertInput

	@Printing game board
	bl printBoard
	
	@Check for a winner
	bl getWinner			@Subroutine on Game Script (game.s)  		
	mov winner, r0
	cmp winner, #0	@If there's a tie
	bne printWinner

	add cont, #1
	b verifyTie

/*****************************************

		Verify Game State
		cont == 8 means there's a tie!

*****************************************/
verifyTie:
	cmp cont, #8	
	bne playerOneInput
	beq printTie

printTie:
	ldr r0, =tieMessage
	bl printf


printWinner:
	ldr r0, =winnerMessage
	mov r1, winner
	bl printf 

/*		END		*/
exit:
	@unlink variables
	.unreq winner
	.unreq cont
	@OS exit
	mov r0,#0
	mov r3,#0

	ldmfd sp!,{lr}
	bx lr
