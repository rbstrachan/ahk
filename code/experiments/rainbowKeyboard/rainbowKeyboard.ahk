#SingleInstance Force
A_MaxHotkeysPerInterval := 1000
SetWorkingDir A_WorkingDir

prevHWND := winExist("A")

rainbowGUI := gui("AlwaysOnTop")
rainbowGUI.backColor := "0fff00" ; make the gui background a specific colour of green so it can be made transparent later
rainbowGUI.add("picture", "x0 y0 backgroundTrans", "rainbow-kb-sans-cles.png")
winSetExStyle("0x08000000L", rainbowGUI) ; prevent the window from ever being in focus

; todo - make a seperate "top" image so that the gui can be moved using postmessage
; todo - make the keyboard react when physical keyboard buttons are pressed - hard!

; add each key to the gui at it's appropriate position
; row 1
k11	 := rainbowGUI.add("picture", "x19 y19 v11", "1k1.png")
k12	 := rainbowGUI.add("picture", "x117 y19 v12", "1k2.png")
k13	 := rainbowGUI.add("picture", "x214 y19 v13", "1k3.png")
k14	 := rainbowGUI.add("picture", "x312 y19 v14", "1k4.png")
k15	 := rainbowGUI.add("picture", "x409 y19 v15", "1k5.png")
k16	 := rainbowGUI.add("picture", "x506 y19 v16", "1k6.png")
k17	 := rainbowGUI.add("picture", "x604 y19 v17", "1k7.png")
k18	 := rainbowGUI.add("picture", "x700 y19 v18", "1k8.png")
k19	 := rainbowGUI.add("picture", "x799 y19 v19", "1k9.png")
k110 := rainbowGUI.add("picture", "x896 y19 v110", "1k10.png")
k111 := rainbowGUI.add("picture", "x992 y19 v111", "1k11.png")
k112 := rainbowGUI.add("picture", "x1090 y19 v112", "1k12.png")
k113 := rainbowGUI.add("picture", "x1187 y19 v113", "1k13.png")
k114 := rainbowGUI.add("picture", "x1285 y19 v114", "1k14.png")

; row 2
k21  := rainbowGUI.add("picture", "x19 y118 v21", "2k1.png")
k22  := rainbowGUI.add("picture", "x167 y118 v22", "2k2.png")
k23  := rainbowGUI.add("picture", "x264 y118 v23", "2k3.png")
k24  := rainbowGUI.add("picture", "x361 y118 v24", "2k4.png")
k25  := rainbowGUI.add("picture", "x459 y118 v25", "2k5.png")
k26  := rainbowGUI.add("picture", "x556 y118 v26", "2k6.png")
k27  := rainbowGUI.add("picture", "x654 y118 v27", "2k7.png")
k28  := rainbowGUI.add("picture", "x751 y118 v28", "2k8.png")
k29  := rainbowGUI.add("picture", "x847 y118 v29", "2k9.png")
k210 := rainbowGUI.add("picture", "x946 y118 v210", "2k10.png")
k211 := rainbowGUI.add("picture", "x1042 y118 v211", "2k11.png")
k212 := rainbowGUI.add("picture", "x1141 y118 v212", "2k12.png")
k213 := rainbowGUI.add("picture", "x1237 y118 v213", "2k13.png")
k214 := rainbowGUI.add("picture", "x1334 y118 v214", "2k14.png")

; row 3
k31  := rainbowGUI.add("picture", "x19 y214 v31", "3k1.png")
k32  := rainbowGUI.add("picture", "x190 y214 v32", "3k2.png")
k33  := rainbowGUI.add("picture", "x288 y214 v33", "3k3.png")
k34  := rainbowGUI.add("picture", "x385 y214 v34", "3k4.png")
k35  := rainbowGUI.add("picture", "x483 y214 v35", "3k5.png")
k36  := rainbowGUI.add("picture", "x580 y214 v36", "3k6.png")
k37  := rainbowGUI.add("picture", "x677 y214 v37", "3k7.png")
k38  := rainbowGUI.add("picture", "x775 y214 v38", "3k8.png")
k39  := rainbowGUI.add("picture", "x872 y214 v39", "3k9.png")
k310 := rainbowGUI.add("picture", "x970 y214 v310", "3k10.png")
k311 := rainbowGUI.add("picture", "x1067 y214 v311", "3k11.png")
k312 := rainbowGUI.add("picture", "x1163 y214 v312", "3k12.png")
k313 := rainbowGUI.add("picture", "x1262 y214 v313", "3k13.png")

; row 4
k41  := rainbowGUI.add("picture", "x19 y312 v41", "4k1.png")
k42  := rainbowGUI.add("picture", "x239 y312 v42", "4k2.png")
k43  := rainbowGUI.add("picture", "x338 y312 v43", "4k3.png")
k44  := rainbowGUI.add("picture", "x434 y312 v44", "4k4.png")
k45  := rainbowGUI.add("picture", "x531 y312 v45", "4k5.png")
k46  := rainbowGUI.add("picture", "x629 y312 v46", "4k6.png")
k47  := rainbowGUI.add("picture", "x726 y312 v47", "4k7.png")
k48  := rainbowGUI.add("picture", "x824 y312 v48", "4k8.png")
k49  := rainbowGUI.add("picture", "x921 y312 v49", "4k9.png")
k410 := rainbowGUI.add("picture", "x1018 y312 v410", "4k10.png")
k411 := rainbowGUI.add("picture", "x1116 y312 v411", "4k11.png")
k412 := rainbowGUI.add("picture", "x1213 y312 v412", "4k12.png")

; row 5
k51 := rainbowGUI.add("picture", "x19 y408 v51", "5k1.png")
k52 := rainbowGUI.add("picture", "x143 y408 v52", "5k2.png")
k53 := rainbowGUI.add("picture", "x264 y408 v53", "5k3.png")
k54 := rainbowGUI.add("picture", "x385 y408 v54", "5k4.png")
k55 := rainbowGUI.add("picture", "x993 y408 v55", "5k5.png")
k56 := rainbowGUI.add("picture", "x1116 y408 v56", "5k6.png")
k57 := rainbowGUI.add("picture", "x1237 y408 v57", "5k7.png")
k58 := rainbowGUI.add("picture", "x1358 y408 v58", "5k8.png")

winSetTransColor("0fff00", rainbowGUI) ; make the gui background transparent
rainbowGUI.show("y" 19*(A_ScreenHeight - 524)/20 " H524 W1498 NA") ; show the gui without it taking focus
winActivate(prevHWND) ; just incase something went wrong, ensure the previous window has focus

setHotkeys(state) { ; set temporary hotkeys
	hotkey("Escape", destroyGUI, state)
}

onClick(thisCtrl, *) { ; show click animation and send clicked key
	thisCtrl.visible := False
	send(keyMap[thisCtrl.name])
	setTimer(() => thisCtrl.visible := True, -80) ; make the animation last 80ms
}

reactToPKP(wParam, *) { ; react to physical key press - non functional
	toolTip(wParam)
}

destroyGUI(*) { ; destroy the gui when either physical or virtual Escape key is pressed
	setHotkeys("off")
	rainbowGUI.destroy()
	ExitApp()
}

keyMap := map( ; map virtual key names to characters to send
	"11", "{Escape}",
	"12", "1",
	"13", "2",
	"14", "3",
	"15", "4",
	"16", "5",
	"17", "6",
	"18", "7",
	"19", "8",
	"110", "9",
	"111", "0",
	"112", "-",
	"113", "=",
	"114", "{Backspace}",
	"21", "{Tab}",
	"22", "q",
	"23", "w",
	"24", "e",
	"25", "r",
	"26", "t",
	"27", "y",
	"28", "u",
	"29", "i",
	"210", "o",
	"211", "p",
	"212", "[",
	"213", "]",
	"214", "#",
	"31", "{CapsLock}",
	"32", "a",
	"33", "s",
	"34", "d",
	"35", "f",
	"36", "g",
	"37", "h",
	"38", "j",
	"39", "k",
	"310", "l",
	"311", ";",
	"312", "'",
	"313", "{Enter}",
	"41", "{LShift}",
	"42", "z",
	"43", "x",
	"44", "c",
	"45", "v",
	"46", "b",
	"47", "n",
	"48", "m",
	"49", ",",
	"410", ".",
	"411", "/",
	"412", "{RShift}",
	"51", "{LCtrl}",
	"52", "{LWin}",
	"53", "{LAlt}",
	"54", "{Space}",
	"55", "{RAlt}",
	"56", "{Function}",
	"57", "{AppsKey}",
	"58", "{RCtrl}"
)

setHotkeys("on") ; activate the hotkeys
onMessage(0x0102, (*) => reactToPKP) ; when physical key pressed, call reactToPKP

; onPhysicalKeyPress(thisHotkey) {
; 	for i, j in keyMap {
; 		if j = thisHotkey {
; 			pKey := "k" i
; 			%pKey%.visible := False
; 			send(thisHotkey)
; 			setTimer(() => %pKey%.visible := True, -80)
; 		}
; 	}
; }

; set the onEvents that allow the keyboard to type when it's keys are clicked
; row 1
k11.onEvent("click", onClick)
k12.onEvent("click", onClick)
k13.onEvent("click", onClick)
k14.onEvent("click", onClick)
k15.onEvent("click", onClick)
k16.onEvent("click", onClick)
k17.onEvent("click", onClick)
k18.onEvent("click", onClick)
k19.onEvent("click", onClick)
k110.onEvent("click", onClick)
k111.onEvent("click", onClick)
k112.onEvent("click", onClick)
k113.onEvent("click", onClick)
k114.onEvent("click", onClick)

; row 2
k21.onEvent("click", onClick)
k22.onEvent("click", onClick)
k23.onEvent("click", onClick)
k24.onEvent("click", onClick)
k25.onEvent("click", onClick)
k26.onEvent("click", onClick)
k27.onEvent("click", onClick)
k28.onEvent("click", onClick)
k29.onEvent("click", onClick)
k210.onEvent("click", onClick)
k211.onEvent("click", onClick)
k212.onEvent("click", onClick)
k213.onEvent("click", onClick)
k214.onEvent("click", onClick)

; row 3
k31.onEvent("click", onClick)
k32.onEvent("click", onClick)
k33.onEvent("click", onClick)
k34.onEvent("click", onClick)
k35.onEvent("click", onClick)
k36.onEvent("click", onClick)
k37.onEvent("click", onClick)
k38.onEvent("click", onClick)
k39.onEvent("click", onClick)
k310.onEvent("click", onClick)
k311.onEvent("click", onClick)
k312.onEvent("click", onClick)
k313.onEvent("click", onClick)

; row 4
k41.onEvent("click", onClick)
k42.onEvent("click", onClick)
k43.onEvent("click", onClick)
k44.onEvent("click", onClick)
k45.onEvent("click", onClick)
k46.onEvent("click", onClick)
k47.onEvent("click", onClick)
k48.onEvent("click", onClick)
k49.onEvent("click", onClick)
k410.onEvent("click", onClick)
k411.onEvent("click", onClick)
k412.onEvent("click", onClick)

; row 5
k51.onEvent("click", onClick)
k52.onEvent("click", onClick)
k53.onEvent("click", onClick)
k54.onEvent("click", onClick)
k55.onEvent("click", onClick)
k56.onEvent("click", onClick)
k57.onEvent("click", onClick)
k58.onEvent("click", onClick)
