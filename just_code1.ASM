format PE console

entry start

include 'win32a.inc'
include 'macro/proc32.inc'

section '.data' data readable writable

        mystr db 'Hello, World!', 0
        ptrStr db '%s', 0

        NULL = 0

section '.code' code readable executable

        start:
                call MyProc
                call [getch]
                call MyProc

                push NULL
                call [ExitProcess]

        MyProc:
                push mystr
                push ptrStr
                call [printf]
                ret

section '.idata' import data readable

        library kernel, 'kernel32.dll',\
                msvcrt, 'msvcrt.dll'

        import kernel,\
               ExitProcess, 'ExitProcess'

        import msvcrt,\
               printf, 'printf',\
               getch, '_getch',\
               scanf, 'scanf'