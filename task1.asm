;id = 4 bytes, sits at offset 0
;rating = 8 bytes, sits at offset 8
;pages = 4 bytes, sits at offset 16
;each new book begins at multiple of 24: 0, 24, 48, 72
;padding at 4-7 and 20-23
;book gets read by rdi and n by rsi  




global total_pages

section .text
BITS 64
    

    total_pages:
        xor rax, rax ;set rax to 0, the running total

        .loop:
            movsxd rcx, dword [rdi + 16]; read number of pages of next book

            add rax, rcx; add it to the running total

            add rdi, 24 ;move to next book

            sub rsi, 1 ;1 book down, keep going through books until n(rsi) is 0

            cmp rsi, 0 ;check if we are done

            jg .loop ;not done--> on to the next book

        ret ;return


    
