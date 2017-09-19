*----------------------------------------------------------------------
* Programmer: Daniel Hernandez
* Class Account: cssc0687
* Assignment or Title: Programming Assignment #4
* Filename: prog4.s
* Date completed: 12/13/16
*----------------------------------------------------------------------
* Problem statement: Use a subroutine to implement a recursive 
* 		     Fibonacci	algorithm, and print the fib(n) number.	     
* Input: Fibonacci number to be calculated.
* Output: "The fibonacci number is" fib(n)
* Error conditions tested: None.
* Included files: fib.s
*		  /home/ma/cs237/bsvc/iomacs.s
*                 /home/ma/cs237/bsvc/casemacs.c
* Method and/or pseudocode: 
*	print fib(n)
* 	long fib(int n){
*		if(n==0) return 0;
*		if(n==1) return 1;
*		return fib(n-1)+fib(n-2);
*		}
* References: None.
*----------------------------------------------------------------------
*
fib:	EQU	$7000
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
start:  initIO                  * Initialize (required for I/O)
	setEVT			* Error handling routines
*	initF			* For floating point macros only	
	lineout		title
	lineout		skipln		* Skip line
	lineout		input
	linein		buffer
	cvta2		buffer,D0
	move.w		D0,-(SP)	* Send n as a parameter
	jsr		fib		* Call fib subroutine
	adda.l		#2,SP		* Pop garbage off
	cvt2a		num,#6
	stripp		num,#6		* Constrain to 6 digits
	lea		num,A0
	adda.w		D0,A0
	clr.b		(A0)
	lineout		skipln		* Skip line
	lineout		output
        break                   * Terminate execution
*
*----------------------------------------------------------------------
*       Storage declarations
skipln:		dc.b	0
buffer:		ds.b	80
title:		dc.b	'Program #4. cscc0687, Daniel Hernandez',0
input:		dc.b	'Enter a number:',0
output:		dc.b	'The fibonacci number is '
num:		ds.b	8
        end
