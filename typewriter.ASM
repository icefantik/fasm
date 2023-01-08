;
; 16-bit code, load from first disk sector

org 0x7C00
use16

; Set up 80x25 console graphic mode

jmp clrscr

; Main program loop
; Wait for a key and print it if need
; You can also press Escape if you want to execute some command

main:
        mov ah, 0x00
        int 0x16 ; Waiting for the user to press a key
        ; Keystroke processing
        cmp al, 13 ; Enter key
        je enterkey
        cmp al, 8 ; Backspace key
        je bckspkey
        cpm al, 27 ; Escape key
        je syscmd
        mov ah, 0x0E
        int 0x10 ; otherwise print ASCII key symbol
        jmp main

; Enter key press event

enterkey:
        mov ah, 0x0E
        mov al, 0x0D
        int 0x10
        mov ah, 0x0E
        mov al, 0x0D
        int 0x10
        jmp main

; Backspace key prees event

bckspkey:
        mov ah, 0x0E
        int 0x10
        sub dh, 1
        mov ah, 0x02
        int 0x10
        mov ah, 0x0E
        mov al, 0x20
        int 0x10
        jmp main

; Escape key press event - enter system command
; r = reboot, h = halt, s = clear console

syscmd:
        mov ah, 0x00
        int 0x16
        cmp al, 'r'
        je reboot
        cmp al, 'h'
        je halt
        cmp al, 's'
        je clrscr
        jmp main

; Reboot

reboot: int 0x19

halt:
        cli
        hlt

; Clear console

clrscr:
        mov ah, 0x00
        mov ax, 0x03
        int 0x10
        jmp main

; MBR signature + fill free bytes with zeroes

times 510-($-$$) db 0
dw 0xAA55