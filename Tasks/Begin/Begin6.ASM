format PE console

include 'win32a.inc'

entry start

;Даны длины ребер a, b, c прямоуголього параллепипеда. Найти его объём V = a * b * c и площадь поверхности S = 2 * (a * b + b * c + a * c).

section '.data' readable writable

        strEnterA db 'Enter A: ', 0
        strEnterB db 'Enter B: ', 0
        strEnterC db 'Enter C: ', 0

        res db 'S = %d', 0

        scanInt db '%d', 0

        A dd ?
        B dd ?
        C dd ?

section '.code' readable executable

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

                push strEnterC
                call [printf]

                push C
                push scanInt
                call [scanf]

                ;a * b
                mov eax, [A]
                mul [B]
                mov ebx, eax

                ;b * c
                mov eax, [B]
                mul [C]
                mov ecx, eax

                ;a * c
                mov eax, [A]
                mul [C]

                ;a * b + b * c
                add ebx, ecx

                ;a * b + b * c + a * c
                add eax, ebx

                ;2 * (a * b + b * c + a * c)
                mov ebx, 2
                mul ebx

                push eax
                push res
                call [printf]

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
