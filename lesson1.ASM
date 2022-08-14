format PE64 console
entry _start
new_line equ 0xA
msg db "hello world", new_line, 0
len = $-msg

_start:
        ; mov rax, 4 ; 4 - write
        ; mov rbx, 1 ; 1 - stdout
        ; mov rcx, msg
        ; mov rdx, len
        ; int 0x80
        mov rax, msg
        call print_string
        call exit
; | input
; rax = message
print_string:
        push rax
        push rbx
        push rcx
        push rdx
        mov rcx, rax
        call length_string
        mov rdx, rax
        mov rax, 4
        mov rbx, 1
        int 0x80
        pop rdx
        pop rcx
        pop rbx
        pop rax
        ret

; | input
; rax = string
; | output
; rax = length
length_string:
        push rdx
        xor rdx, rdx ; 0
        .next_iter:
                cmp [rax+rdx], byte 0 ; comparions and search \0 symbol
                je .close ; called close
                inc rdx ; increment
                jmp .next_iter
        .close:
                mov rax, rdx
                pop rdx
                ret ; return to call site


exit:
        mov rax, 1 ; 1 - exit
        mov rbx, 0 ; 0 - return, no error
        int 0x80
