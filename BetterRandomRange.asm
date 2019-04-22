; //Irvine32 template	(irvine32_template.asm)

; //include Irvine32.inc

INCLUDE Irvine32.inc

.data
prompt_lower BYTE "Please enter the lower bound: ",0
prompt_upper BYTE "Please enter the upper bound: ",0

.code
main PROC
mov ecx, 3
L1:
	push ecx
	mov edx, OFFSET prompt_lower
	call WriteString
	call ReadInt
	mov ebx, eax
	;push eax
	call Crlf
	mov edx, OFFSET prompt_upper
	call WriteString
	call ReadInt
	
	mov ecx,30
L2:
	push eax
	call BetterRandomRange
	call WriteInt
	call Crlf
	pop eax
	loop L2
	pop ecx
	call Crlf
	loop L1
main ENDP

BetterRandomRange proc
sub eax,ebx
call RandomRange
add eax, ebx
ret 
BetterRandomRange endp

END main
