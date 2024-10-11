#Persistent
#SingleInstance Force
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
SysGet, screenWidth, 78
SysGet, screenHeight, 79
GuiVisible := true

Menu, Tray, Icon, shell32.dll, 1  ; Set an icon for the tray
Menu, Tray, Add
Menu, Tray, Add, Toggle Mousegrid Spyglass Visibility, ToggleVisibility


getSegmentNumber(mouseX, mouseY, segmentWidth, segmentHeight) {
    relativeMouseX := Mod(mouseX, segmentWidth)
    relativeMouseY := Mod(mouseY, segmentHeight)
    subWidth := segmentWidth / 3
    subHeight := segmentHeight / 3
    subX := Floor(relativeMouseX / subWidth) + 1
    subY := Floor(relativeMouseY / subHeight) + 1
    return (subY - 1) * 3 + subX
}

return

FollowMouse:
    MouseGetPos, mouseX, mouseY  ; Get the current mouse position
    grid1N := getSegmentNumber(mouseX, mouseY, screenWidth, screenHeight)
    grid2N := getSegmentNumber(mouseX, mouseY, screenWidth / 3 , screenHeight / 3)
    grid3N := getSegmentNumber(mouseX, mouseY, screenWidth / 3 / 3 , screenHeight / 3 / 3)
    grid4N := getSegmentNumber(mouseX, mouseY, screenWidth / 3 / 3 / 3 , screenHeight / 3 / 3 / 3)
    grid5N := getSegmentNumber(mouseX, mouseY, screenWidth / 3 / 3 / 3 / 3, screenHeight / 3 / 3 / 3 / 3)


    ; Update the text to show the current grid number
    GuiControl, , MyText, %grid1N% %grid2N% %grid3N% %grid4N% %grid5N%

    ; Adjust the GUI position to follow the mouse cursor
    xPos := mouseX + 20
    yPos := mouseY + 20
    if (GuiVisible == true) {
        Gui, Show, x%xPos% y%yPos% NoActivate AutoSize
    }
    else {
        Gui, Hide
    }

return

ToggleVisibility:
    GuiVisible := !GuiVisible
return

ExitScript:
    ExitApp