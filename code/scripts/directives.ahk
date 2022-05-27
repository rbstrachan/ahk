SetWorkingDir A_ScriptDir		; ensures a consistent A_WorkingDir
#SingleInstance Force			; launches the new instance of the script always, instead of asking whether it should
#WinActivateForce				; forces windows to be activated, skipping the gentle method
#Hotstring EndChars ?!`n `t		; decides the characters that can finish a hotstring
#HotIf							; resolve "this hotkey already exists" conflicts
A_MaxHotkeysPerInterval := 1000	; removes the limitation of 70 hotkeys per 2 seconds
CoordMode "Mouse", "Screen"		; uses the coordinates of the screen rather than of the window's
SetControlDelay -1				; removes delays after control-modifying functions
SetTitleMatchMode 2				; common sense, really
#InputLevel 5					; tribute to Shambles
