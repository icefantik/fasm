format PE console

entry start

include 'win32a.inc'
;include 'proc16.inc'

section '.data' data readable writable

        strPrtInt db 'result: %d', 10, 13, 0
        emptyStr db '%d', 0
        point db ',', 0

        A dd ?
        B dd ?
        C dd ?

        NULL = 0

section '.code' code readable executable

        start:
                mov [A], 12
                mov [B], 5

                ;sum A and B
                mov ecx, [A]
                add ecx, [B]

                push ecx
                push strPrtInt
                call [printf]

                ;subtraction A and B
                mov ecx, [A]
                sub ecx, [B]

                push ecx
                push strPrtInt
                call [printf]

                ;multiplication A and B
                mov eax, [A]
                mul [B]

                push eax
                push strPrtInt
                call [printf]

                ;division A and B
                mov eax, [A]
                mov ecx, [B]
                mov edx, 0

                div ecx
                mov [C], edx ;remainder of the division

                ;print integer
                push eax
                push strPrtInt
                call [printf]

                push point
                call [printf]

                        mov ebx, 0 ;counter
                        lp:
                                ;multiplication remainder on 10
                                mov eax, [C]
                                mov ecx, [B]
                                imul eax, 10

                                ;countinue to divide
                                mov edx, 0
                                div ecx
                                mov [C], edx

                                ;print remainder
                                push eax
                                push emptyStr
                                call [printf]

                                add ebx, 1 ;increment
                                cmp ebx, 3 ;while ebx < 3
                        jne lp ;jump not equals. if cmp true program goes further(program ends)

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