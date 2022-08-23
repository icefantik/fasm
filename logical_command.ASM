format PE console

entry start

include 'win32a.inc'

section '.data' data readable writable

        resStr db 'result: %d', 10, 13, 0
        str1 db 'ZF = 1, op result is FALSE', 0
        str2 db 'ZF = 0, op result is TRUE', 0

        A dw ?
        B dw ?
        C dw ?

        NULL = 0

section '.code' code readable executable

        start:
                mov eax, 110b
                and eax, 101b

                push eax
                push resStr
                call [printf]

                mov eax, 1000b
                or eax, 1010b

                push eax
                push resStr
                call [printf]

                mov eax, 1010b
                xor eax, 111b

                push eax
                push resStr
                call [printf]

                xor eax, eax
                mov al, 11111110b
                not al

                push eax
                push resStr
                call [printf]

                mov eax, 1010b
                test eax, 101b

                jz ifZFTrue

                push str2
                call [printf]
                jmp exit

                ifZFTrue:
                        push str1
                        call [printf]

                call exit

        print:
                push eax
                push resStr
                call [printf]
                ret

        exit:
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
