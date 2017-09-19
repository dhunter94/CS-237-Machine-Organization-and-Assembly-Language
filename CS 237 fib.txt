*----------------------------------------------------------------------
* Programmer: Daniel Hernandez
* Class Account: cssc0687
* Assignment or Title: Programming Assignment #4
* Filename: fib.s
* Date completed: 12/13/16
*----------------------------------------------------------------------
* long fib(int n)

	ORG	$7000			* Start at address 7000
fib:	link		A6,#0
	movem.l		D1-D3,-(SP)
	move.w		8(A6),D1	* Value of n
	move.w		D1,D3
	tst.w		D1		* if(n == 0)
	BNE		test
	clr.l		D0		* return 0
	BRA		done
test:	cmpi.w		#1,D1		* if(n == 1)
	BNE		rec
	move.l		#1,D0		* return 1
	BRA		done
rec:	subq.w		#1,D1		* n-1
	move.w		D1,-(SP)
	jsr		fib		* fib(n-1)
	adda.l		#2,SP
	move.l		D0,D2		* copy fib(n-1)
	subq.w		#2,D3		* n-2
	move.w		D3,-(SP)
	jsr		fib		* fib(n-2)
	adda.l		#2,SP
	add.l		D2,D0		* fib(n-1) + fib(n-2)
done:	movem.l		(SP)+,D1-D3
	unlk		A6
	rts
	end
