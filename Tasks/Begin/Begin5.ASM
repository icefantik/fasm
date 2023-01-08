format PE console

include 'win32a.inc'

entry start

;Дана длина ребра куба a. Найти объем куба V = a^3 и площадь его поверхности S = 6 * a^2.

section '.data' readable writable

        strEnterA db 'Enter a: ', 0
        scanInt db '%d', 0
        printRes db 'V = %d, S = %d', 10, 13, 0

        A dd ?
        V dd ?
        S dd ?

section '.code' readable executable

        start:
                push strEnterA
                call [printf]

                push A
                push scanInt
                call [scanf]

                mov eax, [A]
                mov ebx, 1
                lp:
                        mul [A]
                        add ebx, 1
                        cmp ebx, 3
                jne lp

                mov [V], eax
                mov eax, [A]
                mul [A]

                mov ebx, 6
                mul ebx

                mov [S], eax

                push [S]
                push [V]
                push printRes
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
               scanf, 'scanf',\
               getch, '_getch'