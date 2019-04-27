/**********************************
Universidad del Valle de Guatemala
Organizacion de computadoras y Assembler
Gustavo Mendez y Diego Estrada
- File: mais.s
***********************************/

.data
.align 2
@Message strings
welcomeMessage: .asciz "  ____  _                           _     _       \n"
welcomeMessage1: .asciz " |  _ \\(_)                         (_)   | |      \n"
welcomeMessage2: .asciz " | |_) |_  ___ _ ____   _____ _ __  _  __| | ___  \n"
welcomeMessage3: .asciz " |  _ <| |/ _ \\ '_ \\ \\ / / _ \\ '_ \\| |/ _` |/ _ \\ \n"
welcomeMessage4: .asciz " | |_) | |  __/ | | \\ V /  __/ | | | | (_| | (_) |\n"
welcomeMessage5: .asciz " |____/|_|\\___|_| |_|\\_/ \\___|_| |_|_|\\__,_|\\___/ \n"
playerOneMessageInfo: .asciz "- El jugador 1 es representado por la letra 'x'.\n"
playerTwoMessageInfo: .asciz "- El jugador 2 representado por la letra 'o'.\n"
emptyInputMessage: .asciz "- Espacio vacio representado por ' '.\n"
winnerMessage: .asciz "NUEVO GANADOR: Jugador %d!\n"
winnerMessage1: .asciz "   _____                       _         _ \n"
winnerMessage2: .asciz "  / ____|                     | |       | |\n"
winnerMessage3: .asciz " | |  __  __ _ _ __   __ _ ___| |_ ___  | |\n"
winnerMessage4: .asciz " | | |_ |/ _` | '_ \\ / _` / __| __/ _ \\ | |\n"
winnerMessage5: .asciz " | |__| | (_| | | | | (_| \\__ \\ ||  __/ |_|\n"
winnerMessage6: .asciz "  \\_____|\\__,_|_| |_|\\__,_|___/\\__\\___| (_)\n"
tieMessage: .asciz "Ha ocurrido un EMPATE!\n"

tieCounter:	.word 0

.text
.align 2
.global main
.type main,%function
main:
	stmfd sp!, {lr}

	winner .req r5
	cont .req r6
	tieCounter .req r7
	mov winner, #0

	/* Displaying welcome message  */
	ldr r0, =welcomeMessage
	bl printf
	mov r0, #0
    ldr r0, =welcomeMessage1
	bl printf
	mov r0, #0
    ldr r0, =welcomeMessage2
	bl printf
	mov r0, #0
    ldr r0, =welcomeMessage3
	bl printf
	mov r0, #0
    ldr r0, =welcomeMessage4
	bl printf
	mov r0, #0
    ldr r0, =welcomeMessage5
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

	ldr tieCounter, =tieCounter
	ldr cont, [tieCounter]
	add cont, #1
	str cont, [tieCounter]
	b verifyTie

/*****************************************
		Verify Game State
		cont == 8 means there's a tie!
*****************************************/
verifyTie:
	ldr tieCounter, =tieCounter
	ldr cont, [tieCounter]
	cmp cont, #8	
	bne playerOneInput
	beq printTie

printWinner:
	ldr r0, =winnerMessage
	mov r1, winner
	bl printf 
    ldr r0, =winnerMessage1
	bl printf
	mov r0, #0
    ldr r0, =winnerMessage2
	bl printf
	mov r0, #0
    ldr r0, =winnerMessage3
	bl printf
	mov r0, #0
    ldr r0, =winnerMessage4
	bl printf
	mov r0, #0
    ldr r0, =winnerMessage5
	bl printf
	mov r0, #0
    ldr r0, =winnerMessage6
	bl printf
	mov r0, #0
	b exit 

printTie:
	ldr r0, =tieMessage
	bl printf
	b exit
	
/*		END		*/
exit:
	@unlink variables
	.unreq winner
	.unreq cont
	.unreq tieCounter
	@OS exit
	mov r0,#0
	mov r3,#0

	ldmfd sp!,{lr}
bx lr
