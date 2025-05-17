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
msg2 db "Cadena convertida: ",0
carlee dd 0

.code
start:
invoke ClearScreen
invoke locate,10,10


; Mostrar resultados
invoke locate,10,14
invoke StdOut, addr msg1

invoke locate,10,15
invoke StdOut, addr buffer

invoke locate,10,16
invoke StdOut, addr msg2

invoke locate,10,17
invoke StdOut, addr output

invoke ExitProcess, 0
end start