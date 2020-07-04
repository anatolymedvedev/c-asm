global factor

section .text
    factor:

    push eax
    push ebx
    push ecx
    push edi

    mov eax, [esp+20]
    mov edi, [esp+24]
    
    mov ebx, 2

    .factorization: 
    xor edx, edx 
    mov ecx, eax     
    div ebx  
    cmp edx, 0   
    je .output            


    mov eax, ecx 
    inc ebx       
    jmp .factorization    
    
    .output:
    push eax
    push ebx
    call edi
    add esp, 4
    pop eax
    cmp eax, 1  
    jne .factorization 

    pop edi
    pop ecx
    pop ebx
    pop eax

    ret
