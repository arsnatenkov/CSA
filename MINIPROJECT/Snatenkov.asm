format PE console
entry start

include 'win32a.inc'
;------------------------------------------------
section '.data' data readable writable
    strWasted db 'Not collinear', 10, 0 
    strGood db 'Collinear', 10, 0
    strx1 db 'Input x1: ', 0
    stry1 db 'Input y1: ', 0
    strx2 db 'Input x2: ', 0
    stry2 db 'Input y2: ', 0
    strx3 db 'Input x3: ', 0
    stry3 db 'Input y3: ', 0
    strx4 db 'Input x4: ', 0
    stry4 db 'Input y4: ', 0
    strx5 db 'Input x5: ', 0
    stry5 db 'Input y5: ', 0
    x1 dd ?
    y1 dd ?
    x2 dd ?
    y2 dd ?
    x3 dd ?
    y3 dd ?
    x4 dd ?
    y4 dd ?
    x5 dd ?
    y5 dd ?
    temp1 dd ?
    temp2 dd ?
    temp3 dd ?
    tempLeft dd ?
    formatD db '%d'
;------------------------------------------------
section '.code' code readable executable
start:
; Input coordinates
        push strx1
        call [printf]
        invoke scanf, formatD, x1

        push stry1
        call [printf]
        invoke scanf, formatD, y1

        push strx2
        call [printf]
        invoke scanf, formatD, x2

        push stry2
        call [printf]
        invoke scanf, formatD, y2

        push strx3
        call [printf]
        invoke scanf, formatD, x3

        push stry3
        call [printf]
        invoke scanf, formatD, y3

        push strx4
        call [printf]
        invoke scanf, formatD, x4

        push stry4
        call [printf]
        invoke scanf, formatD, y4

        push strx5
        call [printf]
        invoke scanf, formatD, x5

        push stry5
        call [printf]
        invoke scanf, formatD, y5

        jmp calcColl1

calcColl1:
;checking first three points
        mov eax, [x1]
        mul [y2]
        mov [temp1], eax

        mov eax, [x2]
        mul [y3]
        mov [temp2], eax

        mov eax, [x3]
        mul [y1]
        add eax, [temp2]
        add eax, [temp1]

        mov [tempLeft], eax

        mov eax, [x2]
        mul [y1]
        mov [temp1], eax

        mov eax, [x3]
        mul [y2]
        mov [temp2], eax

        mov eax, [x1]
        mul [y3]
        add eax, [temp2]
        add eax, [temp1]  

        sub [tempLeft], eax

        cmp [tempLeft], 0
        je calcColl2 ;if tempLeft equals zero we check second three point
        jne wasted ;else they don't collinear

calcColl2:
;checking second three points
        mov eax, [x2]
        mul [y3]
        mov [temp1], eax

        mov eax, [x3]
        mul [y4]
        mov [temp2], eax

        mov eax, [x4]
        mul [y2]
        add eax, [temp2]
        add eax, [temp1]

        mov [tempLeft], eax

        mov eax, [x3]
        mul [y2]
        mov [temp1], eax

        mov eax, [x4]
        mul [y3]
        mov [temp2], eax

        mov eax, [x2]
        mul [y4]
        add eax, [temp2]
        add eax, [temp1]  

        sub [tempLeft], eax     

        cmp [tempLeft], 0
        je calcColl3 ;if tempLeft equals zero we check third three point
        jne wasted ;else they don't collinear

calcColl3:
;checking third three points
        mov eax, [x3]
        mul [y4]
        mov [temp1], eax

        mov eax, [x4]
        mul [y5]
        mov [temp2], eax

        mov eax, [x5]
        mul [y3]
        add eax, [temp2]
        add eax, [temp1]

        mov [tempLeft], eax

        mov eax, [x4]
        mul [y3]
        mov [temp1], eax

        mov eax, [x5]
        mul [y4]
        mov [temp2], eax

        mov eax, [x3]
        mul [y5]
        add eax, [temp2]
        add eax, [temp1]  

        sub [tempLeft], eax

        cmp [tempLeft], 0
        je good ;if last three point collinear we go to good
        jne wasted ;else they don't collinear

wasted: 
; Not collinear
        push strWasted
        call [printf]
        jmp finish

good:
; Collinear
        push strGood
        call [printf]
        jmp finish

finish:
; Finish of programm
        call [getch]
        push 0
        call [ExitProcess]




;------------------------------------------------
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