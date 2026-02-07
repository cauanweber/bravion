FORMAT ELF64 EXECUTABLE

    ENTRY Start

MACRO Input Buffer, Counter
{
    MOV     RAX, 0
    MOV     RDI, 0
    MOV     RSI, Buffer
    MOV     RDX, Counter
    SYSCALL
}

MACRO Print Buffer, Counter
{
    MOV     RAX, 1
    MOV     RDI, 1
    MOV     RSI, Buffer
    MOV     RDX, Counter
    SYSCALL
}

SEGMENT READABLE EXECUTABLE
Start:
    Print       TEXT_Title, TEXT_Title_LENGTH
    Print       TEXT_Main_Menu, TEXT_Main_Menu_LENGTH

    Input       INPUT_Buffer, INPUT_Buffer_LENGTH

    MOV     BL, [INPUT_Buffer]

    CMP     BL, 49      ; ASCII ('1')
    JE      OPTION_Sum

    CMP     BL, 50      ; ASCII ('2')
    JE      OPTION_Subtract

    CMP     BL, 51      ; ASCII ('3')
    JE      OPTION_Multiply

    CMP     BL, 52      ; ASCII ('4')
    JE      OPTION_Divisor

    Print       TEXT_Invalid_Option, TEXT_Invalid_Option_LENGTH

Exit:
    MOV     RAX, 60
    XOR     RDI, RDI
    SYSCALL

OPTION_Sum:
    Print       TEXT_Sum_Selected, TEXT_Sum_Selected_LENGTH
    JMP         Exit

OPTION_Subtract:
    Print       TEXT_Subtract_Selected, TEXT_Subtract_Selected_LENGTH
    JMP         Exit

OPTION_Multiply:
    Print       TEXT_Multiply_Selected, TEXT_Multiply_Selected_LENGTH
    JMP         Exit

OPTION_Divisor:
    Print       TEXT_Divisor_Selected, TEXT_Divisor_Selected_LENGTH
    JMP         Exit

SEGMENT READABLE WRITEABLE

    INPUT_Buffer_LENGTH = 2
    INPUT_Buffer RB INPUT_Buffer_LENGTH

    TEXT_Title DB "Bravion Calculator", 10
    TEXT_Title_LENGTH = $ - TEXT_Title

    TEXT_Main_Menu DB 10, "Choose operation:", 10
                   DB     "1) Sum", 10
                   DB     "2) Subtract", 10
                   DB     "3) Multiply", 10
                   DB     "4) Divisor", 10

    TEXT_Main_Menu_LENGTH = $ - TEXT_Main_Menu

    TEXT_Sum_Selected DB "Sum selected", 10
    TEXT_Sum_Selected_LENGTH = $ - TEXT_Sum_Selected

    TEXT_Subtract_Selected DB "Subtract selected", 10
    TEXT_Subtract_Selected_LENGTH = $ - TEXT_Subtract_Selected

    TEXT_Multiply_Selected DB "Multiply selected", 10
    TEXT_Multiply_Selected_LENGTH = $ - TEXT_Multiply_Selected

    TEXT_Divisor_Selected DB "Divisor selected", 10
    TEXT_Divisor_Selected_LENGTH = $ - TEXT_Divisor_Selected

    TEXT_Invalid_Option DB "Invalid option", 10
    TEXT_Invalid_Option_LENGTH = $ - TEXT_Invalid_Option
