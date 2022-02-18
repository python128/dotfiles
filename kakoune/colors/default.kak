# Kakoune default color scheme

# For Code
face global value red
face global type yellow
face global variable green
face global module green
face global function rgba:fa8072aa
face global string magenta
face global keyword blue
face global operator yellow
face global attribute green
face global comment rgb:acdd7c+i
face global documentation comment
face global meta rgb:ee799f
face global builtin default+b

# For markup
face global title blue
face global header cyan
face global mono green
face global block magenta
face global link cyan
face global bullet cyan
face global list yellow

# builtin faces
face global Default default,default
face global LineNumbers rgb:606060,default
face global LineNumberCursor rgba:bbdd8820,default+b
face global MenuForeground white,blue
face global MenuBackground blue,white
face global MenuInfo cyan
face global Information black,yellow
face global Error black,red
face global StatusLine cyan,default
face global StatusLineMode yellow,default
face global StatusLineInfo blue,default
face global StatusLineValue green,default
face global StatusCursor black,cyan
face global Prompt yellow,default
face global MatchingChar cyan,default+b
face global Whitespace default,default+f
face global BufferPadding blue,default

# Shades of blue/cyan for normal mode
set-face global PrimarySelection white,blue+F
set-face global SecondarySelection black,blue+F
set-face global PrimaryCursor black,bright-cyan+F
set-face global SecondaryCursor black,bright-blue+F
set-face global PrimaryCursorEol black,bright-cyan
set-face global SecondaryCursorEol black,bright-blue

# Shades of green/yellow for insert mode.
hook global ModeChange (push|pop):.*:insert %{
    set-face window PrimarySelection white,green+F
    set-face window SecondarySelection black,green+F
    set-face window PrimaryCursor black,bright-yellow+F
    set-face window SecondaryCursor black,bright-green+F
    set-face window PrimaryCursorEol black,bright-yellow
    set-face window SecondaryCursorEol black,bright-green
}

# Undo colour changes when we leave insert mode.
hook global ModeChange (push|pop):insert:.* %{
    unset-face window PrimarySelection
    unset-face window SecondarySelection
    unset-face window PrimaryCursor
    unset-face window SecondaryCursor
    unset-face window PrimaryCursorEol
    unset-face window SecondaryCursorEol
}
