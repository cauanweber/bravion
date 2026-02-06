FORMAT ELF64 EXECUTABLE

    ENTRY Start

SEGMENT READABLE EXECUTABLE
Start:
    MOV     RAX, 1
    MOV     RDI, 1
    MOV     RSI, TEXT_Title
    MOV     RDX, TEXT_Title_LENGTH
    SYSCALL

    MOV     RAX, 1
    MOV     RDI, 1
    MOV     RSI, TEXT_Main_Menu
    MOV     RDX, TEXT_Main_Menu_LENGTH
    SYSCALL

    MOV     RAX, 0
    MOV     RDI, 0
    MOV     RSI, INPUT_Buffer
    MOV     RDX, INPUT_Buffer_LENGTH
    SYSCALL

    MOV     BL, [INPUT_Buffer]
    CMP     BL, 49     ; ASCII ('1')
    JE      OPTION_Sum

Exit:
    MOV     RAX, 60
    XOR     RDI, RDI
    SYSCALL

OPTION_Sum:
    MOV     RAX, 1
    MOV     RDI, 1
    MOV     RSI, TEXT_Sum_Selected
    MOV     RDX, TEXT_Sum_Selected_LENGTH
    SYSCALL

    JMP     Exit

SEGMENT READABLE WRITEABLE

    INPUT_Buffer_LENGTH = 2
    INPUT_Buffer RB INPUT_Buffer_LENGTH

    TEXT_Title DB "Bravion Calculator", 10
    TEXT_Title_LENGTH = $ - TEXT_Title

    TEXT_Main_Menu DB 10
                   DB "Choose operation:", 10
                   DB "1) Sum", 10
                   DB "2) Subtract", 10
                   DB "3) Multiply", 10
                   DB "4) Divisor", 10

    TEXT_Main_Menu_LENGTH = $ - TEXT_Main_Menu

    TEXT_Sum_Selected DB "Sum selected", 10
    TEXT_Sum_Selected_LENGTH = $ - TEXT_Sum_Selected
