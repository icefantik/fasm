format PE console

entry start

include 'win32a.inc'

; Begin1. Дана строка квадрата a. Найти его периметор P = 4 * a

section '.data' data readable writable

        strEnterA db "Entry A: ", 0
        strResult db "Result: %d", 0
        scanInt db "%d", 0
        NULL = 0

        A dd ?

section '.code' code readable executable

        start:
                push strEnterA
                call [printf]

                push A
                push scanInt
                call [scanf]

                mov eax, [A]
                imul eax, 4

                push eax
                push strResult
                call [printf]

                jmp finish
        finish:
                call [getch]
                push NULL
                call [ExitProcess]

section '.idata' import data readable

        library kernel, 'kernel32.dll',\
                msvcrt, 'msvcrt.dll'

        import kernel,\
               ExitProcess, 'ExitProcess'

        import msvcrt,\
               printf, 'printf',\
               getch, '_getch',\
               scanf, 'scanf'