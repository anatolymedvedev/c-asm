section .data
    hello db 'Введите число: ', 0xa
    len equ $-hello
    error db 'Ошибка', 0xa
    len1 equ $-error
 
section .bss
    string resb 200
    factor resb 200
    reverse resb 200
 
section .text
    global _start
    _start:
        mov eax, 4
        mov ebx, 1
        mov ecx, hello
        mov edx, len
        int 0x80
 
        call .read
        mov eax, [esp]          
 
        push eax
        call .translate
        mov ebx, [esp +4]       
 
        cmp eax, 0             
        jnz .n  
        call .error
        call .exit
        .n:
 
        push ebx
        call .fact
 
 
        call .write
 
    mov eax, 1
    mov ebx, 0
    int 0x80
 
.read:
    mov eax, 3
    mov ebx, 0
    mov ecx, string
    mov edx, 200
    int 0x80
    mov [esp+4], eax              
ret
 
.translate:                      
    mov ebx, 10
    mov ecx, [esp+4]
    dec ecx                    
    mov esi, string         
    xor eax, eax           
    .perevod:
        mul ebx             
        jc .b             
        mov dl, [esi]      
        sub dl, '0'       
        add eax, edx
        inc esi
    loop .perevod
    mov [esp+8], eax              
    jmp .end
        .b:              
        mov eax, 0
        mov [esp+8], eax
    .end:
ret
 
.fact:
    mov ecx, factor        
    mov eax, [esp+4]
    mov ebx, 2
    .e:
        xor edx, edx
        mov edi, eax       
        div ebx           
        cmp edx, 0
        jnz .r              
        push eax           
        push ebx
        push edx
        push edi
        push ecx
        mov eax, ebx      
        mov ebx, 10        
        xor edi, edi
        mov ecx, reverse
        .y:                    
            xor edx, edx
            div ebx
            add edx, '0'
            mov [ecx], dl
            inc ecx       
            inc edi        
            cmp eax, 0
        jnz .y
        push edi           
        mov eax, ecx
        dec eax           
        mov ecx, [esp+4]        
        .h:                
            mov bl, [eax]
            mov [ecx], bl
            dec eax
            inc ecx
            dec edi
            cmp edi, 0
        jnz .h
        pop edi
        pop ecx
        add ecx, edi          
        pop edi
        pop edx
        pop ebx
        pop eax
 
        mov byte [ecx], '*'
        inc ecx
        jmp .w
        .r:
        mov eax, edi 
        inc ebx     
        xor edx, edx            
        .w:
        cmp eax, 1
    jnz .e                
    mov byte [ecx-1], 0xa
 
ret
 
.write:
    mov eax, 4
    mov ebx, 1
    mov ecx, factor
    mov edx, 200
    int 0x80
ret
 
.error:
    mov eax, 4
    mov ebx, 1
    mov ecx, error
    mov edx, len1
    int 0x80
ret
 
.exit:
  mov ebx, 0
  mov eax, 1
  int 80h
ret
