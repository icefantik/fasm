format PE console

include 'win32a.inc'

entry start

section '.data' readable writable

        strEnterA db 'Enter A: ', 0
        strEnterB db 'Enter B: ', 0
        strEnterC db 'Enter C: ', 0

        scanInt db '%d', 0

        res db 'res = %d', 0

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

                cmp A, B
                jg elMore
                elMore:
                        cmp A, C
                        jg moreA
                        push C
                        push res
                        call [printf]
                        jmp finish

                jmp finish

        moreA:
                push A
                push res
                call [printf]
                jmp finish

        max:


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