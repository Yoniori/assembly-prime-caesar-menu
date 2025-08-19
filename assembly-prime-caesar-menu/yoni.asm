data segment
	firstMsg db 'Please choose one of the following options : $'
	secondMsg db '1. Prime number checker $'
	thirdMsg db '2. Caesars shift coder  $'
	fourthMsg db '3. Exit  $'	
	ifPrimeMsg db 'Enter a positive integer inputPrime N(255>N>2): $'	
	ThisIsPrime db 'The number is prime $'
	ThisIsNotPrime db 'The number is not prime$'
	firstCaesarsMsg db 'Type a string (only small characters in English): $'
	secondCaesarsMsg db 'Enter one decimal digit (between 2 to 9): $'	
	thirdCaesarsMsg db 'The new string is:'
	SavedPrimeNumber dw 30 dup (0) 
	firstString db 30 dup (0)
	secondString db 30 dup (0)
	Number dw ?
	firstSign db '@$'
	secondSign db '*$'
	Revah db ' $'
	offset1 db  ?
data ends
code segment
assume cs:code, ds:data
start:
    mov ax, data
    mov ds, ax    

TheMenu:
	mov dl, 10 
	mov ah, 2
	int 21h
	mov dx, offset firstMsg
	mov ah, 9
	int 21h
	mov dl, 10 
	mov ah, 2
	int 21h
	mov dx, offset secondMsg
	mov ah, 9
	int 21h	
	mov dl, 10 
	mov ah, 2
	int 21h
	mov dx, offset thirdMsg
	mov ah, 9
	int 21h	
	mov dl, 10
	mov ah, 2
	int 21h
	mov dx, offset fourthMsg
	mov ah, 9
	int 21h
	mov dl, 10 
	mov ah, 2
	int 21h	
	mov ah, 7
	int 21h


	cmp al, '3'
	je ThirdOption	
	cmp al , '1'
	jbe FirstOption
	jmp SecondOption

	
ThirdOption:
	    mov ah,4ch
        int 21h	
FirstOption:
	call ifPrime
	jmp firstTest
ifPrime proc
	mov dl, 10 ;רווח
	mov ah, 2
	int 21h	
	mov dx, offset ifPrimeMsg
	mov ah, 9
	int 21h	
	mov dl, 10 ;רווח
	mov ah, 2
	int 21h			
	mov si, offset SavedPrimeNumber
	mov bx, 0
	
keletPrime:	

	mov ah, 1
	int 21h
	cmp al , '.'
	je Length1
	sub al, '0'
	sub ah, ah
	mov SavedPrimeNumber[bx], ax

	inc bx
	jmp keletPrime	


Length1:	
	cmp bx, 2
	jge Length2
	mov ax, SavedPrimeNumber[0]
	mov Number, ax
	jmp firstTest
	
	
Length2:
	cmp bx, 3
	jge Length3
	mov bx, 0
	mov ax, 10
	mul SavedPrimeNumber[bx]
	sub ah, ah
	mov di, ax
	inc bx	
	add di, SavedPrimeNumber[bx]
	mov Number, di	
	jmp firstTest


Length3:	
	mov bx, 0
	mov ax, 100
	mul SavedPrimeNumber[bx]
	sub ah, ah
	mov di, ax
	inc bx
	mov ax, 10
	mul SavedPrimeNumber[bx]	
	sub ah,ah
	add di,ax
	inc bx
	add di, SavedPrimeNumber[bx]
	mov Number, di
	ret
ifPrime endp	


firstTest: 
	call secondTest
	cmp al,0
	jg PrintPrimeNumber
	jmp PrintNotPrimeNumber
	
secondTest proc
	mov bx, 2
	mov cx, Number
	
thirdTest:
		mov ax, bx
		mul bx
		cmp ax, cx
		ja endThirdTest

		mov ax, cx
		mov dx, 0
		div bx
		cmp dx, 0
		je NotPrime

		inc bx
		jmp thirdTest

NotPrime:

		mov dl, 10 
		mov ah, 2
		int 21h
		mov dx, offset ThisIsNotPrime
		mov ah, 9
		int 21h
		mov al, 0
		ret
		
endThirdTest:

		mov dl, 10 ;רווח
		mov ah, 2
		int 21h
		mov dx, offset ThisIsPrime
		mov ah, 9
		int 21h
		mov al, 1
		ret
	
secondTest endp
		mov dl, 10 ;רווח
		mov ah, 2
		int 21h
PrintPrimeNumber:
	call firstprint
	jmp TheMenu
firstprint proc
	mov dl, 10 ;רווח
	mov ah, 2
	int 21h
	mov cx, Number; כמות שורות
	mov bx, 0	
RowLoopT:
		mov ax, cx

	LineLoopT:	
		dec ax	
		mov dx, offset Revah; מדפיס רווח
		mov ah, 9
		int 21h	
		sub ah,ah		
		cmp ax,0
		jne LineLoopT
		mov si, bx
		inc si
	firstSignprinter:	
		mov dx, offset firstSign; מדפיס שטורדל
		mov ah, 9
		int 21h
		dec si		
		cmp si, 0		
		jne firstSignprinter
		mov dl, 10 ;מוריד שורה
		mov ah, 2
		int 21h	
		sub ah,ah
	inc bx	
	dec cx	
	cmp cx,0   
	je EndTrianglePrint
	jmp RowLoopT
	EndTrianglePrint:
	ret
firstprint endp

PrintNotPrimeNumber:
	call PrintNotPrimeNumber1
	jmp TheMenu
PrintNotPrimeNumber1 proc
	mov cx, Number; כמות שורות
	mov bx, Number
	inc cx
secondSignLoop1:
	mov dl, 10 ;רווח
	mov ah, 2
	int 21h
	dec cx
	cmp cx, 0
	je EndSquarePrint
	mov bx, Number	
	secondSignLoop2:
		mov dx, offset secondSign;  מדפיס כוכבית
		mov ah, 9
		int 21h	
		dec bx
		cmp bx, 0
		jne secondSignLoop2
		jmp secondSignLoop1
	EndSquarePrint:
	ret
PrintNotPrimeNumber1 endp

SecondOption:
	call keletCaesar
	jmp DigitInput
	keletCaesar proc
	mov dl, 10 ;רווח
	mov ah, 2
	int 21h
	mov dx, offset firstCaesarsMsg
	mov ah, 9
	int 21h
	mov bx, 0
	
CaesarsInput:	
	mov ah, 1
	int 21h
	cmp al , '.'
	je DigitInput
	mov firstString[bx], al
	inc bx
	jmp CaesarsInput
	ret
	keletCaesar endp
DigitInput:
    mov firstString[bx], '$'
    mov dl, 10 
    mov ah, 2        
    int 21h
    mov dx, offset secondCaesarsMsg
    mov ah, 9
    int 21h
    mov ah, 7
    int 21h 
    
    sub al, '0'
    mov offset1, al
    mov bx, 0
    mov si, offset firstString
    mov di, offset secondString
	
stringShifter:
    mov al, firstString[bx]
    add al, offset1
    cmp al, 'z'
    jle stringPrinter
    sub al, 26
stringPrinter:    	
    mov [di], al
    inc bx
    inc di
    cmp firstString[bx], '$'
    jne stringShifter	
    mov byte ptr [di], '$'  
    mov dx, offset secondString
    mov ah, 9
    int 21h
	mov dl, 10 
	mov ah, 2
	int 21h
    jmp TheMenu
finish:
	    mov ah,4ch
        int 21h	

code ends
end start