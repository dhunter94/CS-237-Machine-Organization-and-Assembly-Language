*----------------------------------------------------------------------
* Programmer: Daniel Hernandez
* Class Account: cssc0687
* Assignment or Title: Programming Assignment #2
* Filename: prog2.s
* Date completed: 10/27/2016 
*----------------------------------------------------------------------
* Problem statement: Calculate the solution to the equation
* ((aX^3 + 2bY^3 + cZ^2 - dX^2Y)/(dX^2 + eY^2 +fXb) + 3Z^2 - 2ad) % 100
* using the fewest number of instructions possible.
*
* Input: None.
*
* Output: "The answer is: XXX"
* 
* Error conditions tested: None.
* 
* Included files: /home/ma/cs237/bsvc/iomacs.s
*                 /home/ma/cs237/bsvc/casemacs.c
* 
* Method and/or pseudocode: Allocate memory for data variables of the
* data file,  calculate each term individually, add them
* appropriately, and mod 100 at the very end. 
*
* 
* References: None.
*----------------------------------------------------------------------
*
        ORG     $0
        DC.L    $3000           * Stack pointer value after a reset
        DC.L    start           * Program counter value after a reset
        ORG     $3000           * Start at location 3000 Hex
*
*----------------------------------------------------------------------
*
#minclude /home/cs/faculty/riggins/bsvc/macros/iomacs.s
#minclude /home/cs/faculty/riggins/bsvc/macros/evtmacs.s
*
*----------------------------------------------------------------------
*
* Register use
*
*----------------------------------------------------------------------
*
DATA:	EQU	$6000		* Allocation of each variable
a:	EQU	DATA
b:	EQU	a+2
c:	EQU	b+2
d:	EQU	c+2
e:	EQU	d+2
f:	EQU	e+2
X:	EQU	f+2
Y:	EQU	X+2
Z:	EQU	Y+2
	
start:  initIO                  * Initialize (required for I/O)
	setEVT			* Error handling routines
*	initF			* For floating point macros only
	
	move.w		X,D1	* Term aX^3 to D1
	muls		D1,D1
	muls		X,D1
	muls		a,D1
	move.w		Y,D2	* Term 2bY^3 to D2
	muls		D2,D2
	muls		Y,D2
	muls		b,D2
	asl.w		#1,D2	
	move.w		Z,D3	* Term cZ^2 to D3
	muls		D3,D3
	muls		c,D3
	move.w		X,D4	* Term dX^2Y to D4
	muls		D4,D4
	muls		Y,D4
	muls		d,D4
	add.w		D3,D2	* Term cZ^2 + 2bY^3 to D2 
	add.w		D2,D1	* Term aX^3 + cZ^2 + 2bY^3 to D1
	sub.w		D4,D1	* Term aX^3 + cZ^2 + 2bY^3 - dX^2Y to D1
	move.w		X,D2	* Term dX^2 to D2
	muls		D2,D2
	muls		d,D2
	move.w		Y,D3	* Term eY^2 to D3
	muls		D3,D3
	muls		e,D3
	move.w		X,D4	* Term fXb to D4
	muls		b,D4
	muls		f,D4
	add.w		D4,D3	* Term eY^2 + fXb to D3
	add.w		D3,D2	* Term dX^2 + eY^2 + fXb to D2
	DIVS		D2,D1	* Term (aX^3 + 2bY^3 + cZ^2 - dX^2Y)/
				* (dX^2 + eY^2 +fXb) to D1
	move.w		Z,D3	* Term 3Z^2 to D3
	muls		D3,D3	
	muls		#3,D3	
	move.w		a,D4	* Term 2ad to D4
	muls.w		d,D4
	asl.w		#1,D4
	sub.w		D4,D3	* Term 3Z^2 - 2ad to D3
	add.w		D3,D1	* Finish equation
	move.w		D1,D0
	ext.l		D0
	DIVS		#100,D0	* Modulus 100
	swap		D0
	ext.l		D0
	cvt2a		num,#6
	stripp		num,#6	*Strip leading numbers
	lea		num,A0
	adda.w		D0,A0
	clr.b		(A0)	* Null terminate 
	lineout		title
	lineout 	answer
	
        break                   * Terminate execution
*
*----------------------------------------------------------------------
*       Storage declarations
title:		dc.b	'Program #2, Daniel Hernandez, cssc0687',0
answer:		dc.b	'The answer is: '
num:		ds.b	8
        end
