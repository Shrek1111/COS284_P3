;logic for this is very similar to task1
;so we know rating sits at offset 8-15
;we know n is number of books and sits in rsi

global average_rating

section .text
BITS 64

    average_rating:
        pxor xmm0, xmm0 ;this will be our running total of averages
        pxor xmm1, xmm1 ;this will be our running total of books

        cvtsi2sd xmm1, rsi

        .loop:
            addsd xmm0, [rdi + 8] ;add average to running total


            add rdi, 24 ;go to next book

            sub rsi, 1 ;keep going until 0 books left

            cmp rsi, 0 ;if all books are done(rsi <= 0), we can exit and return

            jg .loop ;else go to next book

        divsd xmm0, xmm1

        ret ;return
