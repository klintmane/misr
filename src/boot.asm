ORG 0x7c00  ; Load code at the bootloader address
BITS 16     ; Generate 16 bit code [real mode]

message: db 'Hello World!', 0  ; Create a variable, a char array + null (0) termination

start:
    mov si, message  ; set the `si` register to start the address of the `message` label
    call print       ; call the print label instructions
    jmp $            ; jump infinitely here, so we don't run boot sign below

print:

.loop:
    lodsb            ; sets `al` to value of `si` and increments `si`
    cmp al, 0        ; check if at last char (null / 0)  
    je .done         ; if equal, we're at the end, we call .done
    call print_char  
    jmp .loop        ; loop

.done:   ; labels starting with `.` are private to the label above them
    ret  ; return to calling scope if called with `call`

print_char:
    mov ah, 0eh  ; teletypeOutput
    int 0x10     ; video [teletypeOutput] [al]
    ret

; Set boot signature 
times 510-($ - $$) db 0
dw 0xAA55