;Variant 2
;Array B of A elements whose value does not match the first and last A elements
format PE console
entry start

include 'win32a.inc'
;------------------------------------------------------------------
section '.data' data readable writable

        strVecSize db 'Size of vector A: ', 0
        strIncorSize db 'Incorrect size of the vector = %d', 10, 0
        strVecElemI db 'A[%d]: ', 0
        strScanInt db '%d', 0
        o db '%d', 10, 0
        strVecElemOut db '[%d] = %d', 10, 0
        strResultB db 'B: ', 10, 0

        vec_size dd 0
        vec_size2 dd 0
        i dd ?
        tmpA dd ?
        tmpB dd ?
        vecA rd 100
        vecB rd 100
        k dd ?
        first_element dd 0
        second_element dd 0

        NULL = 0
;------------------------------------------------------------------
section '.code' code readable executable

        initArrayA:
                mov eax, [vec_size]

                cmp eax, 0
                jg getVector

                push [vec_size]
                push strIncorSize
                call [printf]
                jmp finish

                getVector:
                        xor ecx, ecx
                        mov ebx, vecA
        ret

        initArrayB:
                mov eax, [vec_size2]
                xor ecx, ecx
                mov edx, vecB
                mov ebx, vecA
        ret

        loop1:
                xor ecx, ecx
                mov edx, vecB
                mov ebx, vecA

                mov eax, [vec_size]
                mov [vec_size2], eax

                getVecLoop2:

                        mov [tmpA], ebx
                        cmp ecx, [vec_size]
                        jge endInputVector2
                        mov [i], ecx

                        mov eax, [ebx]
                        cmp eax, [first_element]
                        je hat1
                        jmp hat2
                        hat1:
                                dec [vec_size2]
                                jmp hat_exit
                        hat2:
                                cmp eax, [second_element]
                                je hat3
                                jmp hat_exit
                                hat3:
                                    dec [vec_size2]
                                    jmp hat_exit
                        hat_exit:

                        mov ecx, [i]
                        inc ecx
                        mov ebx, [tmpA]
                        add ebx, 4
                        jmp getVecLoop2

                endInputVector2:

        ret

        enteringElementsA:
                mov eax, [vec_size]
                mov [k], eax
                dec [k]

                getVecLoop:

                        mov [tmpA], ebx
                        cmp ecx, [vec_size]
                        jge endInputVector


                        mov [i], ecx
                        push ecx
                        push strVecElemI
                        call [printf]
                        add esp, 8


                        push [tmpA]
                        push strScanInt
                        call [scanf]
                        add esp, 8

                        cmp [i], 0
                        je firstElement
                        jmp endFirstElement
                        firstElement:
                                mov eax, [ebx]
                                mov [first_element], eax
                        endFirstElement:

                        mov eax, [k]
                        cmp [i], eax
                        je secondElement
                        jmp endSecondElement
                        secondElement:
                                mov eax, [ebx]
                                mov [second_element], eax
                        endSecondElement:

                        mov ecx, [i]
                        inc ecx
                        mov ebx, [tmpA]
                        add ebx, 4
                        jmp getVecLoop

                endInputVector:
        ret

        enteringElementsB:
                xor ecx, ecx
                mov edx, vecB
                mov ebx, vecA

                getVecLoop3:
                        mov [tmpB], edx
                        mov [tmpA], ebx
                        cmp ecx, [vec_size]
                        jge endInputVector3


                        mov [i], ecx

                        mov eax, [ebx]

                        cmp eax, [first_element]
                        jne hat11
                        jmp hat_exitt
                        hat11:
                                cmp eax, [second_element]
                                jne hat33
                                jmp hat_exitt
                                hat33:
                                        mov dword [edx], eax
                                        mov edx, [tmpB]
                                        add edx, 4
                                        jmp hat_exitt
                        hat_exitt:


                        mov ecx, [i]
                        inc ecx
                        mov ebx, [tmpA]
                        add ebx, 4
                        jmp getVecLoop3
                endInputVector3:
        ret

        outputingElementsB:
                xor ecx, ecx
                mov edx, vecB

                putVecLoop4:
                        mov [tmpB], edx
                        cmp ecx, [vec_size2]
                        je endOutputVector4
                        mov [i], ecx


                        push dword [edx]
                        push ecx
                        push strVecElemOut
                        call [printf]

                        mov ecx, [i]
                        inc ecx
                        mov edx, [tmpB]
                        add edx, 4
                        jmp putVecLoop4

                endOutputVector4:
        ret

        start:
                push strVecSize
                call [printf]
                add esp, 4

                push vec_size
                push strScanInt
                call [scanf]
                add esp, 8

                call initArrayA

                call enteringElementsA

                call loop1

                call initArrayB

                call enteringElementsB

                call outputingElementsB

                call [printf]

        finish:

                call [getch]
                push NULL
                call [ExitProcess]
;----------------------------------------------------------------------------
section '.idata' import data readable
        library kernel, 'kernel32.dll',\
                msvcrt, 'msvcrt.dll',\
                user32,'USER32.DLL'

        include 'api\user32.inc'
        include 'api\kernel32.inc'

        import kernel,\
               ExitProcess, 'ExitProcess',\
               HeapCreate,'HeapCreate',\
               HeapAlloc,'HeapAlloc'

        include 'api\kernel32.inc'

        import msvcrt,\
               printf, 'printf',\
               scanf, 'scanf',\
               getch, '_getch'