.386
.model flat, stdcall
option casemap:none
.nolist
include \masm32\include\windows.inc
include \masm32\include\kernel32.inc
include \masm32\include\masm32.inc
include \masm32\include\user32.inc

.list
includelib \masm32\lib\kernel32.lib
includelib \masm32\lib\masm32.lib
includelib \masm32\lib\user32.lib

.data
msgInput db "Ingrese una cadena (max 127 caracteres):",0
buffer db 127 dup (0),0 ; Buffer para leer la cadena
output db 127 dup (0),0 ; Buffer para cadena convertida
msg1 db "Cadena original: ",0
msg2 db "Total de MAYUSCULAS: ",0
contM dd 0
carlee dd 0

.code
start:
invoke ClearScreen
invoke locate,10,10

invoke StdOut, addr msgInput
invoke locate, 10,11
invoke StdIn, addr buffer, 127

mov carlee, eax

mov esi, offset buffer
mov edi, offset output

mov ecx, carlee

L1:
    mov al, byte ptr [esi]

contMayus:
    cmp al, 'A'
    jb guardar
    cmp al, 'Z'
    ja guardar
    inc dword ptr contM

guardar:
    inc esi
    inc edi
    loop L1
    
; Mostrar resultados
invoke locate,10,14
invoke StdOut, addr msg1

invoke locate,10,15
invoke StdOut, addr buffer

invoke locate,10,16
invoke StdOut, addr msg2

invoke locate,10,17
mov eax, contM
invoke dwtoa, eax, addr output
invoke StdOut, addr output

invoke ExitProcess, 0
end start