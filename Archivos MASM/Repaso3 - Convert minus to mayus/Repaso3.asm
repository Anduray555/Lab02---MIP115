; Codigo de convertir minusculas a mayusculas.
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
; Inicio de programa, limpia la consola y se localiza en la colum 10 fila 10
invoke ClearScreen
invoke locate,10,10

; Impresión de mensaje, localiza en la colum 10 fila 11, lee los caracteres por medio de teclado
invoke StdOut, addr msgInput
invoke locate, 10,11
invoke StdIn, addr buffer, 127

; Asignación de valor a la variable carlee, cantidad total de caracteres introducidos
mov carlee, eax

mov esi, offset buffer ; ESI Apunta al inicio de la cadena guardada en buffer
mov edi, offset output ; EDI Apunta al inicio de la ouput para guardar en ella

; Asignación de valor al contador ECX de los loops
mov ecx, carlee

L1:
    mov al, byte ptr [esi]

verMinus:
    cmp al, 'a'
    jb guardar
    cmp al, 'z'
    ja guardar
    sub al, 20h

guardar:
    mov [edi], al
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
invoke StdOut, addr output

invoke ExitProcess, 0
end start