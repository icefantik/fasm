format PE console

include 'win32a.inc'

entry start

section '.data' readable writable

        strEntryR db 'Enter V: ', 0
        scanInt db '%d', 0
        res db 'L = %d', 0

        V dd ?
        R dd ?
        PI dd 3

section '.code' readable executable

        start:
                push strEntryR
                call [printf]

                push V
                push scanInt
                call [scanf]



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