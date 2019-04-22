; //Irvine32 template	(irvine32_template.asm)

; //include Irvine32.inc

INCLUDE Irvine32.inc

BUFMAX=128
.data
sPrompt BYTE "Enter a string: ",0
sKey BYTE "Enter a key: "
key BYTE BUFMAX+1 DUP(0)
sEncrypt BYTE "Cipher Text: ",0
sDecrypt BYTE "Decryped string: ",0
buffer BYTE BUFMAX+1 DUP(0)
bufSize DWORD ?
keySize DWORD ?

.code
main PROC
	call InputTheString   ;get user input for plain text string
	call InputTheKey      ;get user input for the key
	call TranslateBuffer  ;encrypt the key
	mov edx,OFFSET sEncrypt   
	call DisplayMessage     
	call TranslateBuffer      ;decrypt the key
	mov edx,OFFSET sDecrypt   
	call DisplayMessage   
exit
main ENDP

InputTheString Proc
	pushad
	mov edx,OFFSET sPrompt
	call WriteString
	mov ecx,BUFMAX           ;mov ecx max size of our string=128
	mov edx,OFFSET buffer    
	call ReadString          ;read user input into buffer
	mov bufSize,eax          ;record size of user string
	call Crlf
	popad
	ret
InputTheString Endp

InputTheKey proc	
	pushad                   
	mov edx, OFFSET skey     
	call WriteString          
	mov ecx,BUFMAX  
	mov edx,OFFSET key        
	call ReadString           ;record user key
	mov keySize,eax           ;record user key length
	call Crlf
	popad
	ret
InputTheKey endp
	
;assists with displaying the encrypted and decrypted texts
DisplayMessage Proc
	pushad
	call WriteString        
	mov edx, OFFSET buffer
	call WriteString
	call Crlf
	call Crlf
	popad
	ret
DisplayMessage ENDP

TranslateBuffer PROC
	pushad
	mov ecx, bufSize      ;loop counter for the user input string
	mov esi,0      
	mov eax,0
L1:	
	mov al, key[eax]      ;mov key value at position [eax] into al
	xor buffer[esi],al    ;xor value in user string with key value
	inc esi               
	inc eax               

	cmp keySize,EAX       ;check if exhausted key values and must go back through
	jb fullkey            ;if keysize<eax jump to fullkey label
	loop L1
	
	fullkey:
	mov eax,0             ;reset position in key to 0 if needed
	loop L1

	call crlf
	popad
	ret
TranslateBuffer ENDP

END main