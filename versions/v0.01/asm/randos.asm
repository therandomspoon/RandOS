org 0x7C00

section .bss
    buffer resb 100
    buffer_size equ 100

section .text
start:
    mov ax, 0x0000
    mov ss, ax
    mov sp, 0xFFFF
    mov ah, 0x0E
    mov al, 'R'
    int 0x10
    mov al, 'a'
    int 0x10
    mov al, 'n'
    int 0x10
    mov al, 'd'
    int 0x10
    mov al, 'O'
    int 0x10
    mov al, 'S'
    int 0x10
    mov al, ' '
    int 0x10
    mov al, 'v'
    int 0x10
    mov al, '0'
    int 0x10
    mov al, '.'
    int 0x10
    mov al, '0'
    int 0x10
    mov al, '1'
    int 0x10
    mov ah, 0x0E
    mov al, 0x0A
    int 0x10
    mov ah, 0x0E
    mov al, 'K'
    int 0x10
    mov al, 'e'
    int 0x10
    mov al, 'r'
    int 0x10
    mov al, 'n'
    int 0x10
    mov al, 'e'
    int 0x10
    mov al, 'l'
    int 0x10
    mov ah, 0x0E
    mov al, 0x0A
    int 0x10
    mov si, buffer
    call get_user_input
    mov si, buffer

display_input:
    mov al, [si]
    cmp al, 0
    je .display_done
    mov ah, 0x0E 
    int 0x10
    inc si
    jmp display_input
.display_done:
    mov ah, 0x0E
    mov al, 0x0A
    int 0x10
    cli
hlt_loop:
    hlt
    jmp hlt_loop
get_user_input:
    mov byte [si], 0 
    mov ah, 0       
    int 0x16

.read_key:
    mov ah, 0      
    int 0x16
    cmp al, 0x0D
    je .input_done
    cmp al, 0x08
    je .handle_backspace
    cmp byte [si], buffer_size
    jae .read_key
    mov ah, 0x0E
    int 0x10
    mov [si], al
    inc si
    jmp .read_key
.handle_backspace:
    cmp byte [si], 0
    je .read_key
    mov ah, 0x0E
    mov al, 0x08
    int 0x10
    mov al, ' '
    int 0x10
    ; Move cursor back again
    mov ah, 0x0E
    mov al, 0x08
    int 0x10
    dec si
    jmp .read_key
.input_done:
    ret
times 510-($-$$) db 0
dw 0xAA55
