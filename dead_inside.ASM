format PE console

entry start

include 'win32a.inc'

section '.data' data readable writable

        strPrintInts db '%d', 10, 13, 0
        strImAGhoul db 'I am a Ghoul', 0


        A dd 1000
        B dd 7

        NULL = 0

section '.code' code readable executable

        start:
                lp:
                        push [A]
                        push strPrintInts
                        call [printf]

                        sub [A], 7
                        cmp [A], 0
                jg lp

                push strImAGhoul
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
               getch, '_getch'