
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
buffer  db 127 dup (0),0           ; Buffer para leer la cadena 
output  db 127 dup (0),0           ; Buffer para cadena convertida 
guiones db 127 dup (0),0           ; Buffer para cadena con guines
vocales db 16 dup(0),0         ; Buffer para cantidad de vocales
msg1  db "Cadena original: ",0 
msg2  db "Cadena convertida: ",0 
msg3 db "Cadena con _:",0
msg4 db "Cantidad de vocales:",0
carlee  dd 0 
cont dd 0
 
.code 
start: 
    invoke ClearScreen ;Limpia la ventana CMD
    invoke locate,10,10 ; Localiza en columna,fila
    ; Mostrar mensaje de entrada 
    invoke StdOut, addr msgInput 
 
    invoke locate,10,12 ; Localiza en columna,fila
 
    ; Leer cadena desde teclado (máx. 127 caracteres) 
    invoke StdIn, addr buffer, 127 
 
    mov carlee, eax 
 
 
    ; Procesar cada carácter de la cadena 
    mov esi, offset buffer     ; Puntero a la cadena original 
    mov edi, offset output     ; Puntero a la cadena convertida 
    mov edx, offset guiones    ; Puntero a la cadena con guiones

    mov ecx, carlee 
 
L1: 
    mov al, byte ptr [esi]
    mov bl, al
    jmp contVocales
 
contVocales:
    cmp al,'A'
    je esvocal
    cmp al,'a'
    je esvocal
    cmp al,'E'
    je esvocal
    cmp al,'e'
    je esvocal
    cmp al,'I'
    je esvocal
    cmp al,'i'
    je esvocal
    cmp al,'O'
    je esvocal
    cmp al,'o'
    je esvocal
    cmp al,'U'
    je esvocal
    cmp al,'u'
    je esvocal
    jmp mayuscula

esvocal:
    inc dword ptr cont
    ; Verificar si es mayúscula (A-Z) 
mayuscula:
    cmp al, 'A' 
    jb minuscula              
    cmp al, 'Z' 
    ja minuscula 
    add al, 20h                 
    jmp guardar 
 
minuscula: 
    cmp al, 'a' 
    jb guion                
    cmp al, 'z' 
    ja guion 
    sub al, 20h
    jmp guardar

guion:
    cmp al, ' '
    mov bl, '_'

guardar: 
    mov [edi], al 
    mov [edx], bl
    inc esi 
    inc edi 
    inc edx
    loop L1 
 
    mov byte ptr [edi], 0       
 
    ; Mostrar resultados 
    invoke locate,10,14 
    invoke StdOut, addr msg1 
 
    invoke locate,10,15 
    invoke StdOut, addr buffer 
 
    invoke locate,10,16 
    invoke StdOut, addr msg2 
 
    invoke locate,10,17 
    invoke StdOut, addr output 

    invoke locate,10,18 
    invoke StdOut, addr msg3
 
    invoke locate,10,19 
    invoke StdOut, addr guiones

    invoke locate,10,18 
    invoke StdOut, addr msg3
 
    invoke locate,10,19 
    invoke StdOut, addr guiones

    invoke locate,10,20 
    invoke StdOut, addr msg4
 
    invoke locate,10,21
    mov eax, cont
    invoke dwtoa, eax, addr vocales ; Convierte número a texto
    invoke StdOut, addr vocales
 
    invoke ExitProcess, 0 
end start 