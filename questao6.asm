org 0x7c00           
jmp _start

  _data:    
  string times 9 db 0      

    
  _start:
  xor ax, ax     
  mov ds, ax
  mov es, ax
    mov di,string
      call gets
      call totransform
    mov bx,0
    mov cx,1

    call FibonacciAlgorithms
    
 

    call _fim

FibonacciAlgorithms:
	.loop:
     

      sub ax,2 
    	cmp ax, 0   
    	jl .endloop	
	    jge .calc
    	
	.calc:
    add bx,cx 
    add cx,bx 
    jmp .loop 
	.endloop: 

    cmp ax,-1
    je .even
    jle .odd 

		
  .even:
  xor dx,dx
  mov ax,cx
  mov cx,11
  div cx
  mov ax,dx
  
  call print_number

  ret
  .odd:
  xor dx,dx
  mov ax,bx
  mov bx,11
  div bx
  mov ax,dx
  
  call print_number

  ret
  ret   
;FUNÇÃO PARA PRINTAR NÚMEROS 
 print_number:
    cmp ax,10
    jae .nzero
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
;FUNÇÃO TRANSFORMAR STRING EM NÚMERO:::::::::::::::::::::::::::::::::
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
    ;transformar string em numero 
    mov si, string
    call stoi
    push ax
    
    pop ax ;vai ser string
 
    
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


_fim:
    jmp $                  

times 510-($-$$) db 0
dw 0xaa55

push ax
mov bx,10
