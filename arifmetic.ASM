format PE console

entry start

include 'win32a.inc'
;include 'proc16.inc'

section '.data' data readable writable

        strPrtInt db 'result: %d', 10, 13, 0

        A dd ?
        B dd ?
        C dd ?

        NULL = 0

section '.code' code readable executable

        start:
                mov [A], 12
                mov [B], 10

                mov ecx, [A]
                add ecx, [B]

                call print

                ;push ecx
                ;push strPrtInt
                ;call [printf]

                mov ecx, [A]
                sub ecx, [B]

                ;push ecx
                ;push strPrtInt
                ;call [printf]

                call [getch]
                jmp exit

        ; | input
        ; ecx = result
        print:
                push ecx
                push strPrtInt
                call [printf]
                ret
        ;endp

        exit:
                push NULL
                call ExitProcess

section '.idata' import data readable

        library kernel, 'kernel32.dll',\
                msvcrt, 'msvcrt.dll'

        import kernel,\
               ExitProcess, 'ExitProcess'

        import msvcrt,\
               printf, 'printf',\
               getch, '_getch',\
               scanf, 'scanf'