;logic for this is very similar to task1
;so we know rating sits at offset 8-15
;we know n is number of books and sits in rsi

global average_rating

section .text
BITS 64

    average_rating:
        xor rax, rax ;this will be our running total of averages
        xor rcx, rcx ;this will be our running total of books

        .loop:
            movsxd rdx, dword [rsi + 8] ;get average of next book

            add rax, rdx ;add it to the running total

            add rcx, 1 ;add book to running total

            add rdi, 24 ;go to next book

            sub rsi, 1 ;keep going until 0 books left

            cmp rsi, 0 ;if all books are done(rsi <= 0), we can exit and return

            jg .loop ;else go to next book

        ret ;return
