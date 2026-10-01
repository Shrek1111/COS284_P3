;again logic is very similar
;rdi stores books and rsi stores n, xmm0 will store the threshold
;we need to start at the first book, compare its rating (xmm1) with whatever is in the threshold (xmm1)
;if it is strictly greater than the threshold, we inc rax(our running total) with one, else we move on to the next book

global count_above

section .text
BITS 64

    count_above:
        xor rax, rax ;clear the running total

        .loop:
            cmp rsi, 0 ;check if we have any books left

            jle .done ;if not, we are done here

            addsd xmm1, [rdi + 8] ;get rating of book

            add rdi, 24 ;move to next book for next iteration

            sub rsi,1 ;one book done

            comisd xmm1, xmm0 ;compare books rating to threshold

            jbe .loop ;rating is not strictly greater than threshold, go to next book

            add rax, 1 ;if it is trictly greater, add to running total

            jmp .loop
        .done:
            ret



