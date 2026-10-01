; we need a couple of things for this task
; we need a running total of pages --> xmm1
; a running total of rating * pages: xmm0
; rating * pages of current book: xmm2  
; pages of current book: xmm3
; rating of current book: xmm4  

global weighted_rating

section .text
BITS 64

    weighted_rating:
        ;clear all necessary registers
        xor rcx, rcx
        pxor xmm0, xmm0
        pxor xmm1, xmm1
        pxor xmm2, xmm2
        pxor xmm3, xmm3
        pxor xmm4, xmm4

        .loop:
            ;check if we have any books left
            cmp rsi, 0
            jle .done ;if not, we are done

            mov rcx, [rdi + 16] ;add pages to temporary storage
            cvtsi2sd xmm10, rcx ;convert to temp storage
            addsd xmm1, xmm10 ;add to running total

            mov rcx, [rdi + 16] ;get current book's pages in temp storage
            cvtsi2sd xmm3, rcx ;convert


            movsd xmm4, [rdi + 8] ;get rating of current book

            mulsd xmm3, xmm4 ;get current books pages*rating
            movsd xmm2, xmm3 ;store in xmm2 (unnecessary but cleaner for me)

            addsd xmm0, xmm2 ;add to running total

            add rdi, 24 ; next book
            sub rsi, 1 ;one book down
            jmp .loop




        .done:
            divsd xmm0, xmm1 ;sum of rating*pages / sum of pages
            ret ;return xmm0
