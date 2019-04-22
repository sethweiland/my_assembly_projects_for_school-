; Calculates the expression sum = (A+B) - (C+D)
; Assignment 3
;Seth Weiland, ID:1764446

.386
.model flat,stdcall
.stack 4096
ExitProcess proto,dwExitCode:dword
.data
valueA DWORD 1000
valueB DWORD 500
valueC DWORD 450
valueD DWORD 100
sum DWORD 0
svalueA SDWORD -2000
svalueB SDWORD 100
svalueC SDWORD 1000
svalueD SDWORD -500
ssum SDWORD 0

.code
main proc
 	mov eax,svalueA				
	add	eax,svalueB
	mov ecx,svalueC
	add ecx,svalueD
	sub eax,ecx
	add ssum,eax

	invoke ExitProcess,0
main endp
end main
