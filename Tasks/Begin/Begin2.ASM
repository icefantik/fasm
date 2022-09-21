format PE console

entry start

include 'win32a.inc'

;Begin2. Дана сторона квадрата a. Найти его площадь P = a^2

section '.data' data readable writable

        strEnterA db "Enter A: ", 0
        scanInt db "%d", 0
        strResult db "Result: %d", 0

        A dd ?

        NULL = 0

section '.code' code readable executable

        start:
                push strEnterA
                call [printf]

                push A
                push scanInt
                call [scanf]

                mov eax, [A]
                imul eax, eax

                push eax
                push strResult
                call [printf]

                jmp finish

        finish:
                call [getch]
                push NULL
                call [ExitProcess]

section '.idata' import data readable

        library kernel, "kernel32.dll",\
                msvcrt, "msvcrt.dll"

        import kernel,\
               ExitProcess, "ExitProcess"

        import msvcrt,\
               printf, "printf",\
               getch, "_getch",\
               scanf, "scanf"