format PE console

entry start

include 'win32a.inc'

section '.data' data readable writable

        resStr db 'result: %d', 10, 13, 0

        A dw ?
        B dw ?
        C dw ?

        NULL = 0

section '.code' code readable executable

        start:
                mov ecx, 110b ;6 decimal
                shl ecx, 1

                push ecx
                push resStr
                call [printf]

                mov ecx, 110b
                shr ecx, 1

                push ecx
                push resStr
                call [printf]

                mov eax, 0b ;write zero
                mov al, 11111010b
                rol al, 1

                push eax
                push resStr
                call [printf]

                call [getch]
                call exit
        exit:
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