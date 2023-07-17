org 0x7c00           
jmp _start

  _data:    
  string times 100 db 0      
  letra times 1 db 0
  result times 4 db 0
  resultado db 'Oi'
  _start:
  xor ax, ax     
  mov ds, ax
  mov es, ax
  mov di,string
    call gets
  mov di,letra
    call gets
  mov di, letra
  mov si, string
    call strcmp
    call _fim

  strcmp:               
          
      xor cx,cx
      xor bx,bx
        
      .loop1:
          lodsb   
          inc cx; cx = número de dígitos da string          
          cmp al, byte[di]      
          je .equal      
          cmp al, 0        
          je .result   
          jmp .loop1        

      .equal:             
          inc bx; bx = número de vezes que a letra aparece
              
          cmp al, 0
          jne .loop1
          jmp .result
      .result:  
      dec cx
      push cx
      push bx
      pop ax
      call 2digitsnum
      mov al,'/'
      call putchar
      pop ax
      call 2digitsnum



      
  ret
;FUNÇÃO NÚMERO P STRING::::::::::::::::::::::::::::::::::::::::::::;
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


; FUNÇÃO PARA RECEBER STRING::::::::::::::::::::::::::::::::::::::::::
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
;FUNÇÃO PARA PRINTAR STRING :::::::::::::::::::::::::::::::::::::::::
  putchar:
      mov ah, 0xe
      int 10h
  ret
  _print:                    
        .loop1:       
          lodsb	         
      cmp al, 0          
      je .fim		   
      call putchar      
      jmp .loop1         
      
        .fim:
  ret  
;FUNÇÃO PARA PRINTAR NÚMERO::::::::::::::::::::::::::::::::::::::::::::::
  2digitsnum:
    cmp ax,10
    ja .nzero
    jna .zero
    ret
    .zero:

    add ax,48
    call putchar
    ret
    .nzero:
    mov bx,10
    xor dx,dx
    div bx
    add ax,48
    call putchar
    mov ax,dx
    add ax,48
    call putchar
    ret
    
;;;;;;;;;;;;
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
  

_fim:
    jmp $                  

times 510-($-$$) db 0
dw 0xaa55

push ax
mov bx,10
