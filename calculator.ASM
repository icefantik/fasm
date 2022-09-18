format PE console

entry start

include 'win32a.inc'

section '.data' data readable writable

        ; It marks is pointers whitch the points to an address
        strA db 'Enter A: ', 0
        strB db 'Enter B: ', 0
        strOp db 'Enter operation: ', 10, 13, 0

        resStr db 'Result: %d', 0
        resMod db '/%d', 0

        spaceStr db ' %d', 0
        opStr db '%c', 0
        emptyStr db '%d', 0

        infinity db 'infinity', 0
        point db ',', 0

        opNotDefined db 'operation not defined', 0

        ;definet double
        A dd ?
        B dd ?
        C dd ?

        NULL = 0

section '.code' code readable executable

        start:
                push strA
                call [printf]

                push A
                push spaceStr
                call [scanf]

                push strB
                call [printf]

                push B
                push spaceStr
                call [scanf]

                push strOp
                call [printf]

                call[getch]

                cmp eax, '+'
                jne notAdd  ; if in cmp not equals symbol '+'
                    mov ecx, [A]
                    add ecx, [B]

                    push ecx
                    push resStr
                    call [printf]

                    jmp finish

                notAdd:
                        cmp eax, '-'
                        jne notSub
                            mov ecx, [A]
                            sub ecx, [B]

                            push ecx
                            push resStr
                            call [printf]

                            jmp finish

                notSub:
                        cmp eax, '*'
                        jne notMul
                            mov ecx, [A]
                            imul ecx, [B]

                            push ecx
                            push resStr
                            call [printf]

                            jmp finish

                notMul:
                        cmp eax, '%'
                        jne notMod
                            mov eax, [A]
                            mov ecx, [B]
                            mov edx, 0

                            cmp [B], 0
                            jne notNullMod
                                push infinity
                                call [printf]

                                jmp finish

                            notNullMod:
                                div ecx
                                mov [C], edx

                                ; the integer part of number
                                push eax
                                push resStr
                                call [printf]

                                push [C]
                                push spaceStr
                                call [printf]

                                push [B]
                                push resMod
                                call [printf]

                                jmp finish

                notMod:
                        cmp eax, '/'
                        jne notDiv
                            mov eax, [A]
                            mov ecx, [B]
                            mov edx, 0

                            cmp [B], 0
                            jne notNullDiv
                                push infinity
                                call [printf]

                                jmp finish

                            notNullDiv:
                                div ecx
                                mov [C], edx

                                push eax
                                push resStr
                                call [printf]

                                push point
                                call [printf]

                                mov ebx, 0 ; counter
                                lp:

                                        mov eax, [C]
                                        mov ecx, [B]
                                        imul eax, 10

                                        mov edx, 0
                                        div ecx
                                        mov [C], edx

                                        push eax
                                        push emptyStr
                                        call [printf]

                                        inc ebx
                                        cmp ebx, 3
                                jne lp

                                jmp finish

                notDiv:
                        push opNotDefined
                        call [printf]

                        jmp finish

        finish:
                call [getch]
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