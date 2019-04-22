; //Irvine32 template	(irvine32_template.asm)

; //include Irvine32.inc

INCLUDE Irvine32.inc

.data
prompt BYTE "Please enter one letter you would like to print: ", 0
char BYTE ?

.code
main PROC
mov edx, OFFSET	prompt
call WriteString
call ReadChar
call crlf
mov char,al
mov ecx, 16 
mov eax,black + (black SHL 4)
L1:
     push ecx
	 push eax
	 mov ecx, 16

L2:
	call SetTextColor
	push eax
	mov al, char
	call WriteChar
	pop eax
	inc eax
loop L2
call crlf
pop eax
add eax,16
pop ecx
loop L1
	
	exit
main ENDP

END main
