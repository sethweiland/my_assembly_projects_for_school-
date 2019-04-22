; //Irvine32 template	(irvine32_template.asm)

; //include Irvine32.inc

INCLUDE Irvine32.inc

.data
buf BYTE 51 DUP(0) ;this array will hold our string
byteCOUNT DWORD ?  ;we will use this to keep track of length of user string

.code
;this procedure reverses a string that the user input, we call function ReadString 
;in order to accomplsih this, and then WriteString to output to the console
;these are both part of the Irvine 32 library
main PROC
	mov edx, OFFSET buf   
	mov ecx, SIZEOF buf
	CALL ReadString
	mov byteCOUNT, eax
	mov esi, 0
	mov ecx,byteCOUNT
L1:
	movzx eax,buf[esi]
	push eax
	inc esi
	loop L1
	
	mov ecx,byteCOUNT
	mov esi, 0
L2:
	pop eax
	mov buf[esi], al
	inc esi
	loop L2
mov edx, OFFSET buf
call WriteString


	;CALL DUMPRegs
	;call WriteHex
	;call Crlf
	
	exit
main ENDP

END main