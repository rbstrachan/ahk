; change the behaviour of individual keys
; replaces PowerToys Keyboard Manager

; open window switcher when Insert key pressed
Insert::^!Tab

; ideally the following hotkeys would only affect the ENG keyboard layout - so when getLang() = "en", however, getLang() function doesn't yet work
+2::send("@")
+3::send("{#}")
+'::send("`"")

; idea - windows don't align to the side of the screen properly if they are moved while maximized
; make #Left and #Right press #Down first to make it work properly

; xp-pen monitor virtual keys
 F2::return										; XP-PEN Virtual Key 2	- Unset
 F1::return										; XP-PEN Virtual Key 1	- Unset
 F3::omnibox()									; XP-PEN Virtual Key 3	- Omnibox
 F4::setTrans(False)							; XP-PEN Virtual Key 4	- Decrease Window Transparency
 F5::setTrans()									; XP-PEN Virtual Key 5	- Increase Window Transparency
 F6::fileSearch()								; XP-PEN Virtual Key 6	- File Search
 F7::setVideoSizeSpeed()						; XP-PEN Virtual Key 7	- Set YouTube Video Size & Speed
 F8::setLang("ja")								; XP-PEN Virtual Key 8	- Set Lang to Japanese
 F9::setLang("fr")								; XP-PEN Virtual Key 9	- Set Lang to French
F10::setLang("en")								; XP-PEN Virtual Key 10	- Set Lang to English
F11::copySearch()								; XP-PEN Virtual Key 11	- Copy & Search
F12::copyTranslate()							; XP-PEN Virtual Key 12	- Copy & Translate
F13::send("^!{Tab}")							; XP-PEN Virtual Key 13	- Change Windows
F14::send("^z")									; XP-PEN Virtual Key 14	- Undo
F15::send("^y")									; XP-PEN Virtual Key 15	- Redo
F16::volumeChange(10)							; XP-PEN Virtual Key 16	- Volume Up
F17::send("{Media_Play_Pause}")					; XP-PEN Virtual Key 17	- Pause
F18::volumeChange(-10)							; XP-PEN Virtual Key 18	- Volume Down
F19::winActivate("Discord"), send("^+m{Esc}")	; XP-PEN Virtual Key 19	- Mute (Discord)
F20::winActivate("Discord"), send("^+d{Esc}")	; XP-PEN Virtual Key 20	- Deafen (Discord)

; function-based hotkeys
CapsLock::setLang("ja"), send("^+h")	; set the language to Japanese and switch to Hiragana input
Shift::setLang("en")					; set the language to English
MButton::send("^!{Tab}")				; show the window switcher
!d::toggleDiscord()
!w::openWordle() 
!y::setVideoSizeSpeed()
^+c::copySearch()
#WheelDown::setTrans()
#WheelUp::setTrans(False,, 50)
#r::omnibox()

; individual hotkeys
; refresh the 'PenTablet' process after it hangs
!p:: {
	processClose(processExist("PenTablet.exe"))	; identify current session and close it
	run("C:\Program Files\Pentablet\PenTablet.exe",, "min")
	winClose(winWait("Pentablet",, 3))
}

#HotIf winActive("Google Chrome") ; runs `+*` and `+-` hotkeys in Chrome only
+NumpadSub::fixBlockedURLs()

; switch to libredd.it
+NumpadMult:: {
	A_Clipboard := ""
	send("^l")
	sleep(15)
	send("^c")
	clipWait
	A_Clipboard := "libreddit.silkky.cloud" subStr(A_Clipboard, 23)
	send("^v{Enter}")
}
#HotIf

:x:date.today::send(formatTime(, "d/M/yyyy"))									; sends today's date in d/m/yyyy (1/5/2022) format
:x:date.today.int::send(formatTime(, "yyyy-MM-dd"))								; sends today's date in yyyy/mm/dd (2022-05-01) format
:x:date.today.long::send(formatTime(, "dddd, MMMM d, yyyy"))					; sends today's date in *day, month d, yyyy (Sunday, May 1, 2022) format
:x:date.today.file::send(formatTime(, "yyyyMMddHHmmss"))						; sends today's date in yyyymmddhhmiss (20220501231535) format
:x:date.today.file.hex::send(format("{:X}", formatTime(, "yyyyMMddHHmmss")))	; sends today's date in yyyymmddhhmiss base 16 (1263F3CB07AF) format
:x:date.yesterday::send(formatTime(dateAdd(A_Now, -1, "days"), "d/M/yyyy"))		; sends yesterday's date in d/m/yyyy (30/4/2022) format
:x:date.tomorrow::send(formatTime(dateAdd(A_Now, 1, "days"), "d/M/yyyy"))		; sends tomorrow's date in d/m/yyyy (2/5/2022) format
;:x:date.plus::																	; sends the current date plus the provided number of days in d/m/yyyy format
;:x:date.minus::																; sends the current date minus the provided number of days in d/m/yyyy format
:x:time.now::send(formatTime(, "HH:mm") " ")									; sends the current time in hh:mm (23:15) format
:x:time.now.sec::send(formatTime(, "HH:mm:ss"))									; sends the current time in hh:mm:ss (23:15:35) format
:x:time.now.xm::send(formatTime(, "h:mm tt"))									; sends the current time in h:mm tt (11:15 PM) format
:x:time.now.xm.sec::send(formatTime(, "h:mm:ss tt"))							; sends the current time in h:mm:ss tt (11:15:35 PM) format
