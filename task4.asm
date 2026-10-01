; again, similar logic
; what we need: storage for current book: rdi.
; storage for highest rated book: rcx.
; storage for current book rating: xmm0
; storage for highest book rating: xmm1
; number of books left to check(n): rsi

global best_book

section .text
BITS 64

    best_book:
        xor rcx, rcx ;clear highest book storage
        pxor xmm1, xmm1 ;clear storage for highest rating

        .loop:
            cmp rsi, 0 ;check to see if we have any books left
            jle .done ;no books left--> we're done here

            movsd xmm0, qword [rdi + 8] ;get rating of current book

            comisd xmm0, xmm1 ;is current book > higest book?

            ja .replace ;yes--> replace

            sub rsi, 1 ;one book down
            add rdi, 24 ;next book
            jmp .loop ;on to the next

            .replace:
                movsd xmm1, xmm0 ;get new highest book rating
                mov rcx, rdi ;get new highest book pointer
                sub rsi, 1 ;one book down
                add rdi, 24 ;next book
                jmp .loop ;on to the next



        .done:
            ret