; //Irvine32 template	(irvine32_template.asm)

; //include Irvine32.inc

INCLUDE Irvine32.inc

.data
menu_prompt BYTE "Boolean Calculator",0dh,0ah   ;menu options
			BYTE "1. x AND y",0dh,0ah
			BYTE "2. x OR y",0dh,0ah
			BYTE "3. NOT x",0dh,0ah
			BYTE "4. x XOR y",0dh,0ah
			BYTE "5. Exit program",0
prompt1 BYTE "Enter the first hexadecimal integer: ",0
prompt2 BYTE "Enter the second hexadecimal integer: ",0
choice1 BYTE "Performing AND_op", 0    ;operation to be displayed after user choice
choice2 BYTE "Performing OR_op", 0
choice3 BYTE "Performing NOT_op", 0
choice4 BYTE "Performing XOR_op", 0
choice5 BYTE "Goodbye", 0
result BYTE "The result is:   ",0

;create a lookup table for procedures after receiving user input
;will use OFFSET and NEAR PTR to call these procedures, using the proc chooseProc

NumberEntries=5
Table BYTE '1'
DWORD AND_op
BYTE '2'
DWORD OR_op
BYTE '3'
DWORD NOT_Op
BYTE '4'
DWORD XOR_op
BYTE '5'
DWORD exitProgram

.code
main PROC
Menu:
	mov edx, OFFSET menu_prompt    ;display menu 41-42
	call WriteString
	call Crlf
userInput:
	call ReadChar
	cmp al, '5'     ;checks to make sure user input is not out of bounds(1-5)
	ja userInput
	cmp al, '1'
	jb userInput
	call Crlf

	call chooseProc
	jc quit
	call Crlf
	jmp Menu
quit:
	exit
main ENDP

;compare user input with the values in the lookup table to select correct op. from the menu
chooseProc PROC
	push ebx
	push ecx
	mov ebx, OFFSET Table
	mov ecx,5
L1:
	cmp al, [ebx]
	jne L2
	call NEAR PTR [ebx+1]
	jmp L3

L2:
	add ebx, 5    ;advance to next procedure number in lookup table
	loop L1
L3:
	pop ecx       ;restore registers
	pop ebx

ret
chooseProc ENDP

AND_Op PROC
	pushad    ;save register state for later
	mov edx, OFFSET choice1   ;write selected proc
	call WriteString   
	call Crlf
	
	mov edx, OFFSET prompt1    ;write out prompts
	call WriteString
	call ReadDec
	mov ebx, eax

	mov edx, OFFSET prompt2
	call WriteString
	call ReadDec

	and eax, ebx

	mov edx, OFFSET result
	call WriteString
	call WriteDec   ;write and'ed value currently in eax
	call Crlf

popad
ret
AND_op ENDP

OR_Op PROC
	pushad    ;save register state for later
	mov edx, OFFSET choice2
	call WriteString
	call Crlf
	mov edx, OFFSET prompt1
	call WriteString
	call ReadDec
	mov ebx, eax

	mov edx, OFFSET prompt2
	call WriteString
	call ReadDec

	or eax, ebx

	mov edx, OFFSET result
	call WriteString
	call WriteDec   ;write or'ed value currently in eax
	call Crlf

popad
ret
OR_op ENDP

NOT_Op PROC
	pushad    ;save register state for later
	mov edx, OFFSET choice3
	call WriteString
	call Crlf
	mov edx, OFFSET prompt1
	call WriteString
	call ReadDec
	

	not eax

	mov edx, OFFSET result
	call WriteString
	call WriteDec   ;write not'ed value currently in eax
	call Crlf

popad
ret
NOT_op ENDP

XOR_Op PROC
	pushad    ;save register state for later
	mov edx, OFFSET choice4
	call WriteString
	call Crlf
	mov edx, OFFSET prompt1
	call WriteString
	call ReadDec
	mov ebx, eax

	mov edx, OFFSET prompt2
	call WriteString
	call ReadDec

	xor eax, ebx

	mov edx, OFFSET result
	call WriteString
	call WriteDec   ;write xor'ed value currently in eax
	call Crlf

popad
ret
XOR_op ENDP

exitProgram PROC
mov edx,OFFSET choice5
call WriteString
stc    ;sets the carry flag

ret     

exitProgram ENDP

END main





