local tClass = class("KeyboardController")
function tClass:ctor()
end

local KEY_NONE = 0
local KEY_PAUSE = 1
local KEY_SCROLL_LOCK = 2
local KEY_PRINT = 3
local KEY_SYSREQ = 4
local KEY_BREAK = 5
local KEY_ESCAPE = 6
local KEY_BACK = 6
local KEY_BACKSPACE = 7
local KEY_TAB = 8
local KEY_BACK_TAB = 9
local KEY_RETURN = 10
local KEY_CAPS_LOCK = 11
local KEY_SHIFT = 12
local KEY_CTRL = 13
local KEY_ALT = 14
local KEY_MENU = 15
local KEY_HYPER = 16
local KEY_INSERT = 17
local KEY_HOME = 18
local KEY_PG_UP = 19
local KEY_DELETE = 20
local KEY_END = 21
local KEY_PG_DOWN = 22
local KEY_LEFT_ARROW = 23
local KEY_RIGHT_ARROW = 24
local KEY_UP_ARROW = 25
local KEY_DOWN_ARROW = 26
local KEY_NUM_LOCK = 27
local KEY_KP_PLUS = 28
local KEY_KP_MINUS = 29
local KEY_KP_MULTIPLY = 30
local KEY_KP_DIVIDE = 31
local KEY_KP_ENTER = 32
local KEY_KP_HOME = 33
local KEY_KP_UP = 34
local KEY_KP_PG_UP = 35
local KEY_KP_LEFT = 36
local KEY_KP_FIVE = 37
local KEY_KP_RIGHT = 38
local KEY_KP_END = 39
local KEY_KP_DOWN = 40
local KEY_KP_PG_DOWN = 41
local KEY_KP_INSERT = 42
local KEY_KP_DELETE = 43
local KEY_F1 = 44
local KEY_F2 = 45
local KEY_F3 = 46
local KEY_F4 = 47
local KEY_F5 = 48
local KEY_F6 = 49
local KEY_F7 = 50
local KEY_F8 = 51
local KEY_F9 = 52
local KEY_F10 = 53
local KEY_F11 = 54
local KEY_F12 = 55
local KEY_SPACE = 56
local KEY_EXCLAM = 57
local KEY_QUOTE = 58
local KEY_NUMBER = 59
local KEY_DOLLAR = 60
local KEY_PERCENT = 61
local KEY_CIRCUMFLEX = 62
local KEY_AMPERSAND = 63
local KEY_APOSTROPHE = 64
local KEY_LEFT_PARENTHESIS = 65
local KEY_RIGHT_PARENTHESIS = 66
local KEY_ASTERISK = 67
local KEY_PLUS = 68
local KEY_COMMA = 69
local KEY_MINUS = 70
local KEY_PERIOD = 71
local KEY_SLASH = 72
local KEY_0 = 73
local KEY_1 = 74
local KEY_2 = 75
local KEY_3 = 76
local KEY_4 = 77
local KEY_5 = 78
local KEY_6 = 79
local KEY_7 = 80
local KEY_8 = 81
local KEY_9 = 82
local KEY_COLON = 83
local KEY_SEMICOLON = 84
local KEY_LESS_THAN = 85
local KEY_EQUAL = 86
local KEY_GREATER_THAN = 87
local KEY_QUESTION = 88
local KEY_AT = 89
local KEY_CAPITAL_A = 90
local KEY_CAPITAL_B = 91
local KEY_CAPITAL_C = 92
local KEY_CAPITAL_D = 93
local KEY_CAPITAL_E = 94
local KEY_CAPITAL_F = 95
local KEY_CAPITAL_G = 96
local KEY_CAPITAL_H = 97
local KEY_CAPITAL_I = 98
local KEY_CAPITAL_J = 99
local KEY_CAPITAL_K = 100
local KEY_CAPITAL_L = 101
local KEY_CAPITAL_M = 102
local KEY_CAPITAL_N = 103
local KEY_CAPITAL_O = 104
local KEY_CAPITAL_P = 105
local KEY_CAPITAL_Q = 106
local KEY_CAPITAL_R = 107
local KEY_CAPITAL_S = 108
local KEY_CAPITAL_T = 109
local KEY_CAPITAL_U = 110
local KEY_CAPITAL_V = 111
local KEY_CAPITAL_W = 112
local KEY_CAPITAL_X = 113
local KEY_CAPITAL_Y = 114
local KEY_CAPITAL_Z = 115
local KEY_LEFT_BRACKET = 116
local KEY_BACK_SLASH = 117
local KEY_RIGHT_BRACKET = 118
local KEY_UNDERSCORE = 119
local KEY_GRAVE = 120
local KEY_A = 121
local KEY_B = 122
local KEY_C = 123
local KEY_D = 124
local KEY_E = 125
local KEY_F = 126
local KEY_G = 127
local KEY_H = 128
local KEY_I = 129
local KEY_J = 130
local KEY_K = 131
local KEY_L = 132
local KEY_M = 133
local KEY_N = 134
local KEY_O = 135
local KEY_P = 136
local KEY_Q = 137
local KEY_R = 138
local KEY_S = 139
local KEY_T = 140
local KEY_U = 141
local KEY_V = 142
local KEY_W = 143
local KEY_X = 144
local KEY_Y = 145
local KEY_Z = 146
local KEY_LEFT_BRACE = 147
local KEY_BAR = 148
local KEY_RIGHT_BRACE = 149
local KEY_TILDE = 150
local KEY_EURO = 151
local KEY_POUND = 152
local KEY_YEN = 153
local KEY_MIDDLE_DOT = 154
local KEY_SEARCH = 155
local KEY_DPAD_LEFT = 156
local KEY_DPAD_RIGHT = 157
local KEY_DPAD_UP = 158
local KEY_DPAD_DOWN = 159
local KEY_DPAD_CENTER = 160
local KEY_ENTER = 161
local KEY_PLAY = 162

local KEY_NAME = {
    "KEY_NONE",
    "KEY_PAUSE",
    "KEY_SCROLL_LOCK",
    "KEY_PRINT",
    "KEY_SYSREQ",
    "KEY_BREAK",
    "KEY_ESCAPE",
    "KEY_BACKSPACE",
    "KEY_TAB",
    "KEY_BACK_TAB",
    "KEY_RETURN",
    "KEY_CAPS_LOCK",
    "KEY_SHIFT",
    "KEY_CTRL",
    "KEY_ALT",
    "KEY_MENU",
    "KEY_HYPER",
    "KEY_INSERT",
    "KEY_HOME",
    "KEY_PG_UP",
    "KEY_DELETE",
    "KEY_END",
    "KEY_PG_DOWN",
    "KEY_LEFT_ARROW",
    "KEY_RIGHT_ARROW",
    "KEY_UP_ARROW",
    "KEY_DOWN_ARROW",
    "KEY_NUM_LOCK",
    "KEY_KP_PLUS",
    "KEY_KP_MINUS",
    "KEY_KP_MULTIPLY",
    "KEY_KP_DIVIDE",
    "KEY_KP_ENTER",
    "KEY_KP_HOME",
    "KEY_KP_UP",
    "KEY_KP_PG_UP",
    "KEY_KP_LEFT",
    "KEY_KP_FIVE",
    "KEY_KP_RIGHT",
    "KEY_KP_END",
    "KEY_KP_DOWN",
    "KEY_KP_PG_DOWN",
    "KEY_KP_INSERT",
    "KEY_KP_DELETE",
    "KEY_F1",
    "KEY_F2",
    "KEY_F3",
    "KEY_F4",
    "KEY_F5",
    "KEY_F6",
    "KEY_F7",
    "KEY_F8",
    "KEY_F9",
    "KEY_F10",
    "KEY_F11",
    "KEY_F12",
    "KEY_SPACE",
    "KEY_EXCLAM",
    "KEY_QUOTE",
    "KEY_NUMBER",
    "KEY_DOLLAR",
    "KEY_PERCENT",
    "KEY_CIRCUMFLEX",
    "KEY_AMPERSAND",
    "KEY_APOSTROPHE",
    "KEY_LEFT_PARENTHESIS",
    "KEY_RIGHT_PARENTHESIS",
    "KEY_ASTERISK",
    "KEY_PLUS",
    "KEY_COMMA",
    "KEY_MINUS",
    "KEY_PERIOD",
    "KEY_SLASH",
    "KEY_0",
    "KEY_1",
    "KEY_2",
    "KEY_3",
    "KEY_4",
    "KEY_5",
    "KEY_6",
    "KEY_7",
    "KEY_8",
    "KEY_9",
    "KEY_COLON",
    "KEY_SEMICOLON",
    "KEY_LESS_THAN",
    "KEY_EQUAL",
    "KEY_GREATER_THAN",
    "KEY_QUESTION",
    "KEY_AT",
    "KEY_CAPITAL_A",
    "KEY_CAPITAL_B",
    "KEY_CAPITAL_C",
    "KEY_CAPITAL_D",
    "KEY_CAPITAL_E",
    "KEY_CAPITAL_F",
    "KEY_CAPITAL_G",
    "KEY_CAPITAL_H",
    "KEY_CAPITAL_I",
    "KEY_CAPITAL_J",
    "KEY_CAPITAL_K",
    "KEY_CAPITAL_L",
    "KEY_CAPITAL_M",
    "KEY_CAPITAL_N",
    "KEY_CAPITAL_O",
    "KEY_CAPITAL_P",
    "KEY_CAPITAL_Q",
    "KEY_CAPITAL_R",
    "KEY_CAPITAL_S",
    "KEY_CAPITAL_T",
    "KEY_CAPITAL_U",
    "KEY_CAPITAL_V",
    "KEY_CAPITAL_W",
    "KEY_CAPITAL_X",
    "KEY_CAPITAL_Y",
    "KEY_CAPITAL_Z",
    "KEY_LEFT_BRACKET",
    "KEY_BACK_SLASH",
    "KEY_RIGHT_BRACKET",
    "KEY_UNDERSCORE",
    "KEY_GRAVE",
    "KEY_A",
    "KEY_B",
    "KEY_C",
    "KEY_D",
    "KEY_E",
    "KEY_F",
    "KEY_G",
    "KEY_H",
    "KEY_I",
    "KEY_J",
    "KEY_K",
    "KEY_L",
    "KEY_M",
    "KEY_N",
    "KEY_O",
    "KEY_P",
    "KEY_Q",
    "KEY_R",
    "KEY_S",
    "KEY_T",
    "KEY_U",
    "KEY_V",
    "KEY_W",
    "KEY_X",
    "KEY_Y",
    "KEY_Z",
    "KEY_LEFT_BRACE",
    "KEY_BAR",
    "KEY_RIGHT_BRACE",
    "KEY_TILDE",
    "KEY_EURO",
    "KEY_POUND",
    "KEY_YEN",
    "KEY_MIDDLE_DOT",
    "KEY_SEARCH",
    "KEY_DPAD_LEFT",
    "KEY_DPAD_RIGHT",
    "KEY_DPAD_UP",
    "KEY_DPAD_DOWN",
    "KEY_DPAD_CENTER",
    "KEY_ENTER",
    "KEY_PLAY",
}
return tClass