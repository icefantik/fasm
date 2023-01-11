format PE console

include 'win32a.inc'

;include 'include/macro/import32.inc'

entry start

section '.data' readable writable

        msg db '%i', 0dh, 0ah, 0

section '.code' readable executable

        start:
                mov eax, 5
                loop1:
                        inc eax
                        push eax
                        push msg
                        call [printf]
                        add esp, 8
                        pop eax
                        cmp eax, 10
                        jb loop1
                jmp finish

        finish:
                call [getch]
                push 0
                call [exit]

section '.idata' import data readable

        library msvcrt, 'msvcrt.dll'

        import msvcrt,\
        printf, 'printf',\
        scanf, 'scanf',\
        getch, '_getch',\
        exit, 'exit'