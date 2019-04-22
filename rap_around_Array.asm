; //Irvine32 template	(irvine32_template.asm)

; //include Irvine32.inc

INCLUDE Irvine32.inc

.data
array DWORD 11, 12, 13, 14, 15, 16, 17, 18, 19, 20

.code

main PROC
mov esi, OFFSET array
mov ecx, LENGTHOF array
mov ebx, TYPE array
call DumpMem
push [esi+SIZEOF array-TYPE array]
mov eax, [esi]
mov ecx, LENGTHOF array-1
L1:
push [esi+4]
mov [esi+4], eax
pop eax
add esi, 4
loop L1
pop eax
mov esi, OFFSET array
mov [esi],eax
mov ecx, LENGTHOF array
mov ebx, TYPE array
call DumpMem




main ENDP

END main
