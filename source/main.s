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
    JMP         Menu

Menu:
    Print       TEXT_Menu, TEXT_Menu_LENGTH
    Input       INPUT_Buffer, INPUT_Buffer_LENGTH

    MOV         BL, [INPUT_Buffer]

    CMP         BL, 49      ; ASCII ('1')
    JE          OPTION_Sum

    CMP         BL, 50      ; ASCII ('2')
    JE          OPTION_Subtract

    CMP         BL, 51      ; ASCII ('3')
    JE          OPTION_Multiply

    CMP         BL, 52      ; ASCII ('4')
    JE          OPTION_Divisor

    CMP         BL, 53      ; ASCII ('5')
    JE          OPTION_Exit

    Print       DEBUG_TEXT_Invalid, DEBUG_TEXT_Invalid_LENGTH
    JMP         Menu

Exit:
    MOV     RAX, 60
    XOR     RDI, RDI
    SYSCALL

OPTION_Sum:
    Print       DEBUG_TEXT_A, DEBUG_TEXT_A_LENGTH
    JMP         Menu
OPTION_Subtract:
    Print       DEBUG_TEXT_B, DEBUG_TEXT_B_LENGTH
    JMP         Menu
OPTION_Multiply:
    Print       DEBUG_TEXT_C, DEBUG_TEXT_C_LENGTH
    JMP         Menu
OPTION_Divisor:
    Print       DEBUG_TEXT_D, DEBUG_TEXT_D_LENGTH
    JMP         Menu
OPTION_Exit:
    Print       DEBUG_TEXT_E, DEBUG_TEXT_E_LENGTH
    JMP         Exit

SEGMENT READABLE WRITEABLE

    INPUT_Buffer_LENGTH = 2
    INPUT_Buffer RB INPUT_Buffer_LENGTH

    TEXT_Title DB "Bravion Calculator", 10
    TEXT_Title_LENGTH = $ - TEXT_Title

    TEXT_Menu DB 10, "Choose operation:"    , 10
              DB     "1) Sum"               , 10
              DB     "2) Subtract"          , 10
              DB     "3) Multiply"          , 10
              DB     "4) Divisor"           , 10
              DB     "5) Exit"              , 10

    TEXT_Menu_LENGTH = $ - TEXT_Menu

    DEBUG_TEXT_A DB "[DEBUG] Option '1' Selected.", 10
    DEBUG_TEXT_A_LENGTH = $ - DEBUG_TEXT_A

    DEBUG_TEXT_B DB "[DEBUG] Option '2' Selected.", 10
    DEBUG_TEXT_B_LENGTH = $ - DEBUG_TEXT_B

    DEBUG_TEXT_C DB "[DEBUG] Option '3' Selected.", 10
    DEBUG_TEXT_C_LENGTH = $ - DEBUG_TEXT_C

    DEBUG_TEXT_D DB "[DEBUG] Option '4' Selected.", 10
    DEBUG_TEXT_D_LENGTH = $ - DEBUG_TEXT_D

    DEBUG_TEXT_E DB "[DEBUG] Option '5' Selected.", 10
    DEBUG_TEXT_E_LENGTH = $ - DEBUG_TEXT_E

    DEBUG_TEXT_Invalid DB "[DEBUG] Invalid Option.", 10
    DEBUG_TEXT_Invalid_LENGTH = $ - DEBUG_TEXT_Invalid
