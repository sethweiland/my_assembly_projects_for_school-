; This program reverses the bytes in bigEndian order by moving the bytesoriginally stored in the bigEndian variable, and
;storing them in a temporary variable so as not to destroy the bigEndian variable, and then uses a DWORD PTR to move the order 
;stored inthe temporary variable to eax, and then finally to little Endian variable.
;As could be inferred from the order of the data declaration, the first four bytes in the above memory debug window are the 
;littleEndian final values, and the last four bytes are the tempEndian final values. 

.386
.model flat,stdcall
.stack 4096
ExitProcess proto,dwExitCode:dword
.data
bigEndian BYTE 12h, 34h, 56h, 78h
littleEndian DWORD ?
tempEndian BYTE ?
.code
main proc
 	mov al, [bigEndian]	
	mov ah, [bigEndian+3]
    mov [tempEndian], ah
	mov [tempEndian+3], al
	mov al, [bigEndian+1]
	mov ah, [bigEndian+2]
	mov [tempEndian+2], al
	mov [tempEndian+1], ah
	mov eax, DWORD PTR tempEndian
	mov littleEndian, eax	
	invoke ExitProcess,0
main endp
end main
