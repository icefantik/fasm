format PE console

include 'win32a.inc'

entry start

; Даны целые числа K и N (N > 0). Вывести N раз число K.

section '.data' readable writable

        strEnterN db 'Enter N: ', 0
        strEnterK db 'Enter K: ', 0
        res db 'res = %d', 10, 13, 0
        formatInt db '%d', 0

        N dd ?
        K dd ?

        NULL = 0

section '.code' readable executable

        start:
                push strEnterN
                call [printf]

                push N
                push formatInt
                call [scanf]

                push strEnterK
                call [printf]

                push K
                push formatInt
                call [scanf]
                lp:
                        push [K]
                        push formatInt
                        call [printf]

                        dec [N]
                        cmp [N], 0
                jne lp

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
               scanf, 'scanf',\
               getch, '_getch'