#Persistent
CoordMode, Mouse, Screen ; mouse is relative to entire screen
SetTimer, FollowMouse, 10  ; Update the position every 10ms
Gui, +AlwaysOnTop +ToolWindow -Caption ; Create a GUI window that is always on top and has no border
Gui, Font, s12, Arial  ; Set the font size and type
Gui, Add, Text, vMyText cRed, Follow Me!  ; Add a text control to the GUI
Gui, Color, EEAA99
Gui, Show, NoActivate ; Show the GUI without activating it (so it doesn't interfere with other windows)
Gui +LastFound
WinSet, TransColor, EEAA99

; Measure the size of the text
GuiControlGet, MyText, Pos, MyText
textWidth := MyTextW
textHeight := MyTextH

return

FollowMouse:
    MouseGetPos, mouseX, mouseY  ; Get the current mouse position
    ; Adjust the GUI position to center it around the mouse cursor
    xPos := mouseX + 20
    yPos := mouseY + 20
    Gui, Show, x%xPos% y%yPos% NoActivate AutoSize
return

Esc::ExitApp  ; Press Escape to exit the script