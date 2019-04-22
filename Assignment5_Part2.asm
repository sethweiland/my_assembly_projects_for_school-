; //Irvine32 template	(irvine32_template.asm)

; //include Irvine32.inc

INCLUDE Irvine32.inc

.data
str1 BYTE 101 DUP (0), 0
.code
main PROC
	mov ecx, 20    ;outer loop counter now on stack
	mov eax, 101    ;random range for length range
	push eax
L1:
	pop eax          ;pop our Randomrangeform 0-100
	push ecx
	call RandomRange              ;   eax = random integer between 0-100
	mov esi, OFFSET str1
	call RandomString
	pop ecx
	push 101
    loop L1	
	exit
main ENDP

;receives length value in eax as a paraemeter, offset of a string array
RandomString proc
mov ecx, eax    ;ecx now holds how many random character it has to write
L2:
mov ebx, 65
mov eax, 91
call BetterRandomRange ;eax now hold the random ascii value between A-Z(65-90)
mov [esi],eax
inc esi
loop L2
mov edx, OFFSET str1
call WriteString
call crlf
ret
RandomString ENDP
 

BetterRandomRange PROC
sub eax, ebx
call RandomRange
add eax, ebx
ret
BetterRandomRange ENDP



END main
