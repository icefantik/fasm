format PE64 console
entry _start

section '.data' writable
        msg db "Hello, World!", 0xA, 0
        len = $-msg

section '.code' executable
_start:
        mov rax, 4
        mov rbx, 1
        mov rcx, msg
        mov rdx, len
        int 0x80

        call exit
exit:
        mov rax, 1
        xor rbx, rbx
        int 0x80