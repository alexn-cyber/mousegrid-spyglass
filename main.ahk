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

; Define screen dimensions
SysGet, screenWidth, 78 ; Get screen width
SysGet, screenHeight, 79 ; Get screen height

; Calculate dimensions of each top-level grid
segmentWidth := screenWidth / 3
segmentHeight := screenHeight / 3

return

FollowMouse:
    MouseGetPos, mouseX, mouseY  ; Get the current mouse position
    ; Determine which top-level grid the mouse is in
    topGridX := Floor(mouseX / segmentWidth) + 1
    topGridY := Floor(mouseY / segmentHeight) + 1
    gridNumber := (topGridY - 1) * 3 + topGridX

    sub1relativeMouseX := Mod(mouseX, segmentWidth)
    sub1relativeMouseY := Mod(mouseY, segmentHeight)
    sub1W := segmentWidth / 3
    sub1H := segmentHeight / 3
    sub1X := Floor(sub1relativeMouseX / sub1W) + 1
    sub1Y := Floor(sub1relativeMouseY / sub1H) + 1
    sub1N := (sub1Y - 1) * 3 + sub1X

    ; Update the text to show the current grid number
    GuiControl, , MyText, %gridNumber% %sub1N%

    ; Adjust the GUI position to follow the mouse cursor
    xPos := mouseX + 20
    yPos := mouseY + 20
    Gui, Show, x%xPos% y%yPos% NoActivate AutoSize
return

Esc::ExitApp  ; Press Escape to exit the script