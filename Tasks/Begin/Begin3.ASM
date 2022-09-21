format PE console

entry start

include 'win32a.inc'

;Begin3. Даны стороны прямоугольника a и b. Найти его площадь S = a * b и периметор P = 2 * (a + b)

section '.data' data readable writable

        strEnterA db 'Enter A: ', 0
        strEnterB db 'Enter B: ', 0

        scanInt db '%d', 0

        resSquare db 'Square: %d', 10, 13, 0
        resPerimeter db 'Perimeter: %d', 0

        A dd ?
        B dd ?

        NULL = 0

section '.code' code readable executable

        start:
                push strEnterA
                call [printf]

                push A
                push scanInt
                call [scanf]

                push strEnterB
                call [printf]

                push B
                push scanInt
                call [scanf]

                ; S = a * b
                mov eax, [A]
                mul [B]

                push eax
                push resSquare
                call [printf]

                ; P = 2 * (a + b)
                mov ecx, [A]
                add ecx, [B]
                imul ecx, 2

                push ecx
                push resPerimeter
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
