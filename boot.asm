[org 0x7c00]

start:
    mov si, mensaje

.loop:
    lodsb
    cmp al, 0
    je esperar
    cmp al, 10
    jne .print
    mov ah, 0x0E
    mov al, 13
    int 0x10
    mov al, 10
    int 0x10
    jmp .loop

.print:
    mov ah, 0x0E
    int 0x10
    jmp .loop

esperar:
    mov ah, 0x00
    int 0x16
    cmp al, '1'
    je opcion1
    cmp al, '2'
    je opcion2
    jmp halt

opcion1:
    mov si, msg1
    call imprimir
    call delay
    mov si, msg1ok
    call imprimir
    jmp halt

opcion2:
    mov si, msg2
    call imprimir
    call delay
    mov si, msg2ok
    call imprimir
    jmp halt

imprimir:
    lodsb
    cmp al, 0
    je .ret
    cmp al, 10
    jne .char
    mov ah, 0x0E
    mov al, 13
    int 0x10
    mov al, 10
    int 0x10
    jmp imprimir
.char:
    mov ah, 0x0E
    int 0x10
    jmp imprimir
.ret:
    ret

delay:
    mov cx, 0FFFFh
.delay_loop1:
    mov dx, 0FFFFh
.delay_loop2:
    nop
    dec dx
    jnz .delay_loop2
    dec cx
    jnz .delay_loop1
    ret

halt:
    jmp $

mensaje db 10
        db "+----------------------------+", 10
        db "|    BIENVENIDO AL SISTEMA   |", 10
        db "|                            |", 10
        db "|    1. Iniciar sistema      |", 10
        db "|    2. Apagar               |", 10
        db "+----------------------------+", 10
        db "Seleccione una opcion: ", 0

msg1 db 10, "Sistema iniciando...", 0
msg1ok db 10, "Sistema iniciado exitosamente!", 0
msg2 db 10, "Apagando...", 0
msg2ok db 10, "Apagado exitoso.", 0

times 510 - ($ - $$) db 0
dw 0xAA55


