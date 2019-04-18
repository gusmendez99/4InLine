/***********************************************
	Universidad del Valle de Guatemala
	Organizacion de computadoras y Assembler
	Gustavo Mendez y Diego Estrada

	- File: game.s
***********************************************/

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
matrixRow: .asciz "|%d|"
enter: .asciz "\n"


.text
.align 2


.global printBoard
printBoard:
    /*inefficient way of printing, improve this part later*/
	push {lr} @store the link register
	column1 .req r5 
	column2 .req r6 
	column3 .req r7 
	column4 .req r8 
	countColumns .req r10	@Count, in this case, 4
    
	ldr column1, =column1
	ldr column2, =column2
	ldr column3, =column3
	ldr column4, =column4
    
	/*
	*	We always have to print matrix in reverse (down to up)
	*	cause player always put his answer on the top (up to down)
	*/

	add column1, #16
	add column2, #16
	add column3, #16
	add column4, #16
	mov countColumns, #4

	loopColumns:	@Printing all the rows

		sub column1, #4
		sub column2, #4
		sub column3, #4
		sub column4, #4
		@Printing
		ldr r0, =matrixRow
		ldr r1, [column1]
		bl printf
		ldr r0, =matrixRow
		ldr r1, [column2]
		bl printf
		ldr r0, =matrixRow
		ldr r1, [column3]
		bl printf
		ldr r0, =matrixRow
		ldr r1, [column4]
		bl printf
		ldr r0, =enter
		bl printf

		subs countColumns, #1	@contador
		bne loopColumns	@si no es 0 regresa

	.unreq column1
	.unreq column2
	.unreq column3
	.unreq column4
	.unreq countColumns

	pop {lr}
	mov pc, lr

/*******************************

		Player inputs

*******************************/
/*
 * @param r0: player number (1 or 2), @return: col number on r0
 */
.global input
input:
 	player .req r5
 	column .req r6
 	push {lr} @Save the link register
 	mov player, r0 @movs param to variable player

inputBody:
 	ldr r0, =inputColumnMessage @Loads input column message
 	mov r1, player @Loads player
	bl printf @Display message

	ldr r0, =inputColumn @load input format
	ldr r1, =currentColumn @Load addres to store input
	bl scanf @Store the input
	ldr r0, =columnEntered @Load input column entered
	ldr column, [r0] @Load input value
	cmp column, #1 @if(column < 1)
	blt wrongInput 
	cmp column, #4 @else if(column > 4)
	bgt wrongInput
	ble finishedInput

wrongInput:
	ldr r0, =errorMessage @Load error message
	bl printf @Display error message
	b inputBody @Go back to input inputBody

finishedInput:
	mov r0, column @mov the column value to r0
	.unreq player @Unlink the player variable from r5
	.unreq column @Unlink the cplumn variable from r6
	pop {lr} @Retrieve link register
	mov pc, lr @Return r0


/*******************************

		Game inserts

*******************************/

/**
 * @params r0: player number (1 or 2),  r1: col number
 * @return r0: vector with players input
*/
.global insertInput
insertInput:
	@variables 
	column .req r5
	box	   .req r6
	player .req r7
	count  .req r8 
	columnInput .req r9

	push {lr} @store the link register
	mov player, r0 @store the player passed as a param
	mov column, r1 @store the column passed as a param

	@Switch cases for column in r1
	cmp column, #1 
	ldreq column, =column1 
	cmp column, #2 
	ldreq column, =column2
	cmp column, #3 
	ldreq column, =column3 
	cmp column, #4 
	ldreq column, =column4 
	mov columnInput, column @store column input

loopVector:
	ldr box, [column] @load the current column element
	cmp box, #0 @if element is empty
	streq player, [column] @store the player in such element
	beq finishedInsertInput @Go to finishedInsertInput
	add column, #4
	add count, #1
	cmp count, #4 @if count != 4
	bne loopVector @true go to loopVector
	ldr r0, =fullMatrixMessage @ else, load fullMatrixMessage message
	bl printf @displays message

finishedInsertInput:
	mov r0, columnInput @r0 = address of the vector
	@Unlink variables from registers
	.unreq column
	.unreq box
	.unreq player
	.unreq count
	pop {lr} @Retrieve the link register
	mov pc, lr @return r0


/*******************************

		Verify winner methods
		@Pending...

*******************************/
/*
 * @param nothing, @return: winner on r0 
 	0 = no winner yet
	1 = player 1 won
	2 = player 2 won
 */


