org 0x7c00
jmp 0x0000:main


putchar:
    mov ah, 0x0e
    int 0x10
    ret


getchar:
    mov ah, 0x00
    int 0x16
    ret




endl:
    mov al, 0x0a
    call putchar
    mov al, 0x0d
    call putchar
    ret


prints:
    push cx
    .loop:
        lodsb
        cmp al, 0
        je .endloop
        call putchar
        jmp .loop
    .endloop:
    pop cx
    ret




tostring:
    xor bx, bx
    mov bx, 10


    .divide:
        xor dx, dx
        div bx
        push dx
        inc cx
        test ax, ax
        jnz .divide


    .print:
        pop dx
        add dl, 0x30
        call putchar
        loop .print


    ret




stoi:
    xor bx, bx


    .loop:
        call getchar
        cmp al, 0x0d
        je .done


        sub al, 0x30
        mov ah, 0
        mov bl, 10
        mul bx
        add ax, bx
        jmp .loop


    .done:
        ret




reverse:
    push cx
    mov si, cx
    dec si


    .loop:
        mov al, byte [si]
        mov dl, byte [cx]
        mov byte [cx], al
        mov byte [si], dl
        inc si
        dec cx
        cmp cx, si
        jg .loop


    pop cx
    ret




gets:
    xor cx, cx
    lea di, [string]


    .loop1:
        call getchar


        cmp al, 0x08
        je .backspace

org 0x7c00
jmp 0x0000:main


putchar:
    mov ah, 0x0e
    int 0x10
    ret


getchar:
    mov ah, 0x00
    int 0x16
    ret




endl:
    mov al, 0x0a
    call putchar
    mov al, 0x0d
    call putchar
    ret


prints:
    push cx
    .loop:
        lodsb
        cmp al, 0
        je .endloop
        call putchar
        jmp .loop
    .endloop:
    pop cx
    ret




tostring:
    xor bx, bx
    mov bx, 10


    .divide:
        xor dx, dx
        div bx
        push dx
        inc cx
        test ax, ax
        jnz .divide


    .print:
        pop dx
        add dl, 0x30
        call putchar
        loop .print


    ret




stoi:
    xor bx, bx


    .loop:
        call getchar
        cmp al, 0x0d
        je .done


        sub al, 0x30
        mov ah, 0
        mov bl, 10
        mul bx
        add ax, bx
        jmp .loop


    .done:
        ret




reverse:
    push cx
    mov si, cx
    dec si


    .loop:
        mov al, byte [si]
        mov dl, byte [cx]
        mov byte [cx], al
        mov byte [si], dl
        inc si
        dec cx
        cmp cx, si
        jg .loop


    pop cx
    ret




gets:
    xor cx, cx
    lea di, [string]


    .loop1:
        call getchar


        cmp al, 0x08
        je .backspace


        cmp al, 0x0d
        je .done


        cmp cl, 15
        je .loop1


        mov byte [di], al
        inc di
        inc cl


        mov ah, 0x0e
        mov al, al
        int 0x10


        jmp .loop1


    .backspace:
        cmp cl, 0
        je .loop1
        dec di
        dec cl
        mov byte [di], 0
        mov ah, 0x0e
        mov al, ' '
        int 0x10
        mov al, 0x08
        int 0x10
        jmp .loop1


    .done:
    mov byte [di], 0
    call endl
    ret


calculate_number:
    push cx
    xor ax, ax
    xor cx, cx
    mov si, string


    .loop:
        lodsb
        cmp al, '-'
        je .continue


        sub al, 0x30
        add ax, al


    .continue:
        cmp si, 10
        jne .loop


    .done:
        add cl, ch
        mov ch, 0
        xor ah, ah
        div byte [magic_number]
        add cl, ah
        xor ah, ah
        pop cx
        ret


main:
   
    call gets


    
    mov si, string
    call calculate_number


  
    mov cx, 4
    call tostring


  
    mov si, 4
    call reverse


  
    mov si, 4
    call prints


    jmp $


string: times 16 db 0
magic_number: db 10


times 510-($-$$) db 0
dw 0xaa55
        cmp al, 0x0d
        je .done


        cmp cl, 15
        je .loop1


        mov byte [di], al
        inc di
        inc cl


        mov ah, 0x0e
        mov al, al
        int 0x10


        jmp .loop1


    .backspace:
        cmp cl, 0
        je .loop1
        dec di
        dec cl
        mov byte [di], 0
        mov ah, 0x0e
        mov al, ' '
        int 0x10
        mov al, 0x08
        int 0x10
        jmp .loop1


    .done:
    mov byte [di], 0
    call endl
    ret


calculate_number:
    push cx
    xor ax, ax
    xor cx, cx
    mov si, string


    .loop:
        lodsb
        cmp al, '-'
        je .continue


        sub al, 0x30
        add ax, al


    .continue:
        cmp si, 10
        jne .loop


    .done:
        add cl, ch
        mov ch, 0
        xor ah, ah
        div byte [magic_number]
        add cl, ah
        xor ah, ah
        pop cx
        ret


main:
   
    call gets


    
    mov si, string
    call calculate_number


  
    mov cx, 4
    call tostring


  
    mov si, 4
    call reverse


  
    mov si, 4
    call prints


    jmp $


string: times 16 db 0
magic_number: db 10


times 510-($-$$) db 0
dw 0xaa55
