format PE console

entry start

include 'win32a.inc'

section '.data' data readable writable

        strEnterD db 'Enter D: ', 0
        scanInt db '%f', 0
        strResult db 'Result: %f', 0

        D dd ?
        PI dd 3.14

        NULL = 0

section '.code' code readable executable

        start:
                push strEnterD
                call [printf]

                push D
                push scanInt
                call [scanf]

                ;mov eax,[D]
                ;imul eax, PI

                push [D]
                push strResult
                call [printf]

                jmp finish

        finish:
                call [getch]
                push NULL
                call [ExitProcess]

section '.idata' data import readable

        library kernel, 'kernel32.dll',\
                msvcrt, 'msvcrt.dll'

        import kernel,\
               ExitProcess, 'ExitProcess'

        import msvcrt,\
               printf, 'printf',\
               getch, '_getch',\
               scanf, 'scanf'