; Window Spy for AHKv2

#SingleInstance Ignore
#NoTrayIcon
SetWorkingDir A_ScriptDir
coordMode "Pixel", "Screen"

winGetTextFast(window, detect_hidden) {
	; winGetText ALWAYS uses the "fast" mode - titleMatchMode only affects
	; winText/excludeText parameters.  In Slow mode, getWindowText() is used
	; to retrieve the text of each control.
	try {
		controls := winGetControlsHwnd(window)
	} catch targetError as e {
		return "Get controls fail: " e.message
	}
	static WINDOW_TEXT_SIZE := 32767 ; defined in AutoHotkey source
	buf := buffer(WINDOW_TEXT_SIZE * 2) ; *2 for Unicode
	local text := ""
	for control in controls
	{
		if !detect_hidden && !dllCall("IsWindowVisible", "ptr", control)
			continue
		if !dllCall("GetWindowText", "ptr", control, "ptr", buf, "int", WINDOW_TEXT_SIZE)
			continue
		text .= strGet(buf) . "`n"
	}
	return text
}

screenToClientPos(hWnd, &x, &y) {
	try {
		winGetPos(&wX, &wY,,, hWnd)
	} catch targetError {
		return false
	}
	x += wX
	y += wY
	pt := buffer(8)
	numPut("int", x, "int", y, pt)
	if !dllCall("ScreenToClient", "ptr", hWnd, "ptr", pt)
		return false
	x := numGet(pt, 0, "int")
	y := numGet(pt, 4, "int")
	return true
}

textMangle(text) {
	elli := false
	pos := inStr(text, "`n")
	if (pos) {
		text := subStr(text, 1, pos-1)
		elli := true
	}
	if (strLen(text) > 40) {
		text := subStr(text, 1, 40)
		elli := true
	}
	if (elli) 
		text .= " …"
	return text
}

getMouseInfo() {
	coordMode("Mouse", "Screen")
	mouseGetPos(&msX, &msY)
	coordMode "Mouse", "window"
	mouseGetPos(&mrX, &mrY)
	coordMode "Mouse", "Client"
	mouseGetPos(&mcX, &mcY)
	return (
		"Screen:`t" msX ", " msY "`n"
		"Window:`t" mrX ", " mrY "`n"
		"Client:`t" mcX ", " mcY "`n"
		"Color:`t#" subStr(pixelGetColor(msX, msY), 3)
	)
}

getWindowInfo(window) {
	try {
		return (
			winGetTitle(window) "`n"
			"ahk_class " winGetClass(window)  "`n"
			"ahk_exe " winGetProcessName(window)  "`n"
			"ahk_pid " winGetPID(window)
		)
	} catch targetError as e {
		return "Get window info fail: " e.message
	}
}

getWindowPosInfo(window) {
	try {
		winGetPos(&wX, &wY, &wW, &wH, window)
		winGetClientPos(&wcX, &wcY, &wcW, &wcH, window)
		return (
			"`tX: " wX 
			"`tY: " wY 
			"`tW: " wW 
			"`tH: " wH 
			"`nClient:`tX: " wcX "`tY: " wcY "`tW: " wcW "`tH: " wcH
		)
	} catch targetError as e {
		return "Get window position fail: " e.message
	}
}

getStatusBarText(window) {
	text := ""
	loop {
		try {
			text .= "[" A_Index "]`t" textMangle(statusBarGetText(A_Index, window)) "`n"
		} catch as e {
			break
		}
	}
	return subStr(text, 1, -1)
}

getControlInfo(window, control) {
	try {
		controlGetPos(&screenX, &screenY, &screenWidth, &screenHeight, control)
		clientX := screenX
		clientY := screenY
		screenToClientPos(window, &clientX, &clientY)
		winGetClientPos(,, &clientWidth, &clientHeight, controlGetHwnd(control))
		return (
			"ClassNN:`t" controlGetClassNN(control) "`n"
			"Text:`t" textMangle(controlGetText(control)) "`n"
			"Screen:`tX: " screenX "`tY: " screenY "`tW: " screenWidth "`tH: " screenHeight "`n"
			"Client:`tX: " clientX "`tY: " clientY "`tW: " clientWidth "`tH: " clientHeight
		)
	} catch targetError as e {
		return "Get control info fail: " e.message
	}
}

getVisibleText(window, slowMode) {
	if slowMode {
		try {
			detectHiddenText(False)
			return winGetText(window)
		} catch targetError as e {
			return "Get visible text fail: " e.message
		}
	} else {
		return winGetTextFast(window, false)
	}
}

getAllText(window, slowMode) {
	if slowMode {
		try {
			detectHiddenText(True)
			return winGetText(window)
		} catch targetError as e {
			return "Get text fail: " e.message
		}
	} else {
		return winGetTextFast(window, true)
	}
}

class mainWindow {
	window := 0
	control := 0
	textCache := Map()
	autoUpdateEnabled := false

	textList := Map(
		"NotFrozen", "Updating...",
		"Frozen", "update suspended",
		"MouseCtrl", "Control Under Mouse Position",
		"FocusCtrl", "Focused Control",
	)

	onOptionUpdateChange(*) {
		this.updateAutoupdateTimer()
	}

	onOptionAlwaysonTopChanged(checkbox, *) {
		this.gui.opt(
			(checkbox.value ? "+" : "-")
			"AlwaysOnTop"
		)
	}

	onOptionTargetChange(*) {
		this.setText(
			"CtrlLabel", 
			this.textList[this.gui["GetCursor"].value ? "MouseCtrl" : "FocusCtrl"] ":"
		)
	}

	onResize(window, minMax, width, height) {
		; stop auto update when minimized
		if (minMax == -1) {
			this.autoUpdate(false)
		} else {
			this.autoUpdate(true)
		}

		list := "Title,MousePos,Ctrl,Pos,SBText,VisText,AllText,Options"
		loop parse list, "," {
			window[A_LoopField].move(,, width - window.marginX*2)
		}
	}

	onClose(window) {
		exitApp
	}

	__New() {
		this.gui := gui("+AlwaysonTop +Resize +DPIScale MinSize")
		this.gui.add("Text", "xm", "window Title, Class and Process:")
		this.gui.add("Edit", "xm w320 r4 Readonly -Wrap vTitle")
		this.gui.add("Text",, "Mouse Position:")
		this.gui.add("Edit", "w320 r4 Readonly -Wrap vMousePos")
		this.gui.add("Text", "w320 vCtrlLabel", this.textList["FocusCtrl"] ":")
		this.gui.add("Edit", "w320 r4 Readonly -Wrap vCtrl")
		this.gui.add("Text",, "Active window Position:")
		this.gui.add("Edit", "w320 r2 Readonly -Wrap vPos")
		this.gui.add("Text",, "Status Bar Text:")
		this.gui.add("Edit", "w320 r2 Readonly -Wrap vSBText")
		this.gui.add("Checkbox", "vIsSlow", "Slow TitleMatchMode")
		this.gui.add("Text",, "Visible Text:")
		this.gui.add("Edit", "w320 r2 Readonly -Wrap vVisText")
		this.gui.add("Text",, "All Text:")
		this.gui.add("Edit", "w320 r2 Readonly -Wrap vAllText")

		this.gui.add("GroupBox", "w320 r3 vOptions", "Options")
		this.gui.add("Checkbox", "xm+8 yp+16 vAlwaysonTop checked", "Always on top?")
			.onEvent("Click", objBindMethod(this, "onOptionAlwaysonTopChanged"))
		this.gui.add("Text", "xm+8 y+m", "Update when Ctrl key is")
		this.gui.add("Radio", "yp vupdateWhenCtrlUp checked", "up")
			.onEvent("Click", objBindMethod(this, "onOptionUpdateChange"))
		this.gui.add("Radio", "yp vupdateWhenCtrlDown", "down")
			.onEvent("Click", objBindMethod(this, "onOptionUpdateChange"))
		this.gui.add("Text", "xm+8 y+m", "Report the")
		this.gui.add("Radio", "yp vGetActive checked", "active window")
			.onEvent("Click", objBindMethod(this, "onOptionTargetChange"))
		this.gui.add("Radio", "yp vGetCursor", "window under cursor")
			.onEvent("Click", objBindMethod(this, "onOptionTargetChange"))
		; update label once
		this.onOptionTargetChange()

		this.statusBar := this.gui.add("StatusBar",, this.textList["NotFrozen"])

		this.gui.onEvent("size", objBindMethod(this, "onResize"))
		this.gui.onEvent("close", objBindMethod(this, "onClose"))

		this.onUpdate := objBindMethod(this, "update")
	}

	setText(controlID, text) {
		; unlike using a pure guiControl, this function causes the text of the
		; controls to be updated only when the text has changed, preventing periodic
		; flickering, especially on older systems.
		if (!this.textCache.has(controlID) || this.textCache[controlID] != text) {
			this.textCache[controlID] := text
			this.gui[controlID].value := text
		}
	}

	updateTarget() {
		if this.gui["GetCursor"].value {
			mouseGetPos(,, &window, &control, 2)
			this.window := window
			this.control := control
		} else {
			this.window := winExist("A")
			try {
				this.control := controlGetFocus()
			} catch targetError {
				this.control := 0
			}
		}
	}

	update() {
		this.updateTarget()

		; our Gui || Alt-Tab
		try {
			if (this.window = this.gui.Hwnd || winGetClass() = "multitaskingViewFrame") {
				this.statusBar.setText(this.textList["Frozen"])
				return
			}
		} catch targetError {

		}

		if (this.window && this.control) {
			this.setText("Ctrl", getControlInfo(this.window, this.control))
		} else {
			this.setText("Ctrl", "")
		}

		this.statusBar.setText(this.textList["NotFrozen"])

		this.setText("Title", getWindowInfo(this.window))
		this.setText("MousePos", getMouseInfo())
		this.setText("Pos", getWindowPosInfo(this.window))
		this.setText("SBText", getStatusBarText(this.window))
		this.setText("VisText", getVisibleText(this.window, this.gui["IsSlow"].value))
		this.setText("AllText", getAllText(this.window, this.gui["IsSlow"].value))
	}

	autoUpdate(enable) {
		if (enable == this.autoUpdateEnabled) {
			return
		}
		if (enable) {
			setTimer(this.onUpdate, 100)
		} else {
			setTimer(this.onUpdate, 0)
			this.statusBar.setText(this.textList["Frozen"])
		}
		this.autoUpdateEnabled := enable
	}
	
	updateAutoupdateTimer() {
		local ctrlKeyDown := getKeyState("Ctrl", "P")
		local enable := (
			ctrlKeyDown == window.gui["updateWhenCtrlDown"].value
		)
		this.autoUpdate(enable)
	}

}

global window := mainWindow()
window.gui.show("noActivate")
window.autoUpdate(true)

~*Ctrl::
~*Ctrl Up:: {
	global window
	window.updateAutoupdateTimer()
}