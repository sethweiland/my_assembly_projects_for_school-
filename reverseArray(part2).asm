; 

.386
.model flat,stdcall
.stack 4096
ExitProcess proto,dwExitCode:dword
.data
array WORD 1, 2, 3, 4, 5, 6, 7,
           8, 9, 10, 11, 12, 13
size_arr WORD 0d
length_arr WORD 0d
loop_cnt DWORD LENGTHOF array / 2
size_a WORD TYPE array
.code
main proc
mov length_arr, LENGTHOF array
MOV esi,OFFSET array                             ;now points to first element in array
MOV edi,OFFSET array + SIZEOF array -TYPE array   ;now points to last element in array
mov ecx, loop_cnt
;first loop will reverse the array, while incrementing esi and decrementing edi
lp1: 
   mov ax, [esi]
   xchg ax,[edi]
   mov [esi], ax
   add esi, TYPE array
   sub edi, TYPE array
   loop lp1
;restore esi, edi, and ecx values prior to first loop, and reuse same technique
mov esi,OFFSET array
mov edi,OFFSET array + SIZEOF array -TYPE array
mov ecx, loop_cnt
;first loop will reverse the array, while incrementing esi and decrementing edi
lp2:	
   mov ax, [esi]
   xchg ax,[edi]
   mov [esi], ax
   add esi, TYPE array
   sub edi, TYPE array
   loop lp2
	
main endp
end main
