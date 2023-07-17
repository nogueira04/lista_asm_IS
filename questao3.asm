org 0x7c00            
jmp main
  data:
    x times 10 db 0
    y times 10 db 0
    z times 4 db 0
    w times 4 db 0
    result times 4 db 0
;;;;;;;;;;;;;;;;;;;;;; FUNÇÃO DE RECEBER STRING
  getchar:               
    mov ah, 0x00
    int 16h
  ret
    
  delchar:                
    mov al, 0x08          
    call putchar
    mov al, ' '
    call putchar
    mov al, 0x08
    call putchar
  ret
    
  endl:                  
    mov al, 0x0a
    call putchar
    mov al, 0x0d
    call putchar
  ret
  gets:                  
    xor cx, cx        
    .loop1:
      call getchar
      cmp al, 0x08
      je .backspace
      cmp al, 0x0d
      je .done
      
      stosb
      inc cl
      mov ah, 0xe
      mov bh, 0
      mov bl, 15       
      call putchar
      
      jmp .loop1
      .backspace:
        cmp cl, 0
        je .loop1
        dec di
        dec cl
        mov byte[di], 0
        call delchar
      jmp .loop1
    .done:
    mov al, 0
    stosb
    call endl
  ret
  putchar:
      mov ah, 0xe
      int 10h
  ret
;;;;;;;;;;;;;; FUNÇÃO DE TRANSFORMAR STRING EM NÚMERO:
  stoi:                
    xor cx, cx
    xor ax, ax
    .loop1:
      push ax
      lodsb
      mov cl, al
      pop ax
      cmp cl, 0       
      je .endloop1
      sub cl, 48       
      mov bx, 10
      mul bx           
      add ax, cx       
      jmp .loop1
    .endloop1:
  ret
  totransform: 
    ;transformar w em numero 
    mov si, w
    call stoi
    push ax

    ;transformar z em numero  
    mov si, z
    call stoi
    push ax

    ; transformar y em numero

    mov si, y
    call stoi
    push ax

    ; transformar x em numero 
    mov si, x
    call stoi
    push ax

    
    pop ax ;vai ser x
    pop bx ;vai ser y
    pop cx ;vai ser w
    pop dx ;vai ser z
    
    ret
;;;;;;;;;;
reverse:              
  mov di, si
  xor cx, cx          
  .loop1:             
    lodsb
    cmp al, 0
    je .endloop1
    inc cl
    push ax
    jmp .loop1
  .endloop1:
  .loop2:             
    pop ax
    stosb
    loop .loop2
  ret
;;;;;;;;;;;;;;;;;;; FUNÇÃO TRANSFORMA NÚMERO EM STRING 
  tostring:              
    push di
    .loop1:
      cmp ax, 0
      je .endloop1
      xor dx, dx
      mov bx, 10
      div bx            
      xchg ax, dx     
      add ax, 48        
      stosb
      xchg ax, dx
      jmp .loop1
    .endloop1:
    pop si
    cmp si, di
    jne .done
    mov al, 48
    stosb
    .done:
    mov al, 0
    stosb
    call reverse
  ret
;;;;;;;;;;;; FUNÇÃO PRINT
  _print:                   
      .loop1:       
        lodsb	          
    cmp al, 0         
    je .fim		  
    call putchar      
    jmp .loop1         
    
      .fim:
  ret  

par:                   ; imprime par
    .print:
        mov al, 'p'
        mov ah, 0xe
        mov bl, 15
        int 10h
        mov al, 'a'
        mov ah, 0xe
        mov bl, 15
        int 10h
        mov al, 'r'
        mov ah, 0xe
        mov bl, 15
        int 10h
        ret  

impar:                   ; imprime impar
    .print:
        mov al, 'i'
        mov ah, 0xe
        mov bl, 15
        int 10h
        mov al, 'm'
        mov ah, 0xe
        mov bl, 15
        int 10h
        mov al, 'p'
        mov ah, 0xe
        mov bl, 15
        int 10h
        mov al, 'a'
        mov ah, 0xe
        mov bl, 15
        int 10h
        mov al, 'r'
        mov ah, 0xe
        mov bl, 15
        int 10h
        ret  

  main:
    xor ax, ax
    mov ds, ax
    mov es, ax
    mov ah, 0xe 
    ;Recebe x , y , w , z  como strings::

    mov di, x 
      call gets
    mov di, y 
      call gets
    mov di, z
      call gets
    mov di, w 
      call gets

    ;Transforma as quatro strings(x,y,z,w) em números::::
    ; (x*y) + (z*w) - (x/z)+(w/y)
    call totransform ; x ficará no ax e y no bx z no cx e w no dx
    
    push bp
    mov bp, sp
  
    push ax
    push bx
    push cx
    push dx

    mul bx
    push ax ; x * y
    
    mov ax, [bp - 8]
    mul cx
    push ax ; z * w

    mov ax, [bp - 2]
    div cx
    push ax ; x / z

    xor dx, dx
    mov ax, [bp - 8]
    div bx
    push ax ; w /y

    pop ax
    pop bx
    add ax, bx ; (x/z) + (w/y)

    pop bx
    pop cx
    add bx, cx ; (x*y) + (z*w)
    
    sub bx, ax ; (x*y) + (z*w) - (x/z) + (w/y)
    mov ax, bx 

    mov bx, 2
    div bx
    mov ax, dx
        
    cmp ax, 0
    jne .impar
    call par
    jmp _fim
        

    .impar:
      call impar
      jmp _fim
  
    ;Printa o resultado::::::
    mov di,x
       call tostring
    mov si,x
        call _print 



	  call _fim
  
  _fim:
    jmp $

times 510-($-$$) db 0
dw 0xaa55
