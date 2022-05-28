; a faster send(). send() can take faaaaar too long. copy-pasting it is much faster. credit @axlefublr.
clipSend(toSend, endChar := "", persistent := False, fastReplace := True, untilRevert := 5000) {
	prevClip := A_Clipboard												; stores the current clipboard in a temporary variable
	A_Clipboard := (endChar ? toSend endChar : toSend A_EndChar)		; appends appropriate ending character to 'toSend' and stores result in clipboard
	send((fastReplace ? "^+{Left}^v" : "^v"))							; selects the previous word and pastes the clipboard
	(!persistent ? clipBack() : False)									; restores the clipboard if 'persistent' parameter is 'false'

	; restores the keyboard after it has been hijacked
	clipBack() => setTimer(() => A_Clipboard := prevClip, -untilRevert)
}

; separately convert the current date and time to hex then format them with a delimeter. to be used as version numbers.
convHexDateTimeToVersionNumber(delimeter := "-") {
	rawStr := format("{:X}" delimeter "{:03X}", formatTime(, "yyyyMMdd"), formatTime(, "HHmm"))
	return subStr(rawStr, 1, 4) delimeter subStr(rawStr, 5)
}

; send copied text to search engine
copySearch(site := "https://duckduckgo.com/?q=") {
	clipTemp := A_Clipboard
	A_Clipboard := ""
	send("^c")
	clipWait
	InStr(A_Clipboard, "http") ? run(A_Clipboard) : run(site A_Clipboard)
	A_Clipboard := clipTemp
}

; send copied text to translator
copyTranslate(translator := "https://translate.google.com/?text=") => copySearch(translator)

; credit @axlefublr
fileSearch(shouldOpen := True, caseSense := "Off") {
	folder := dirSelect("C:\",, "Choose a folder to search...")
	if !folder 
		return

	search := inputBox("What file would you like to search for?", "File Search")
	if search.Result = "Cancel" 
		return

	found := Gui("AlwaysOnTop", "These files match your search:")
	foundList := found.Add("ListView", "W1480 H500", ["Full file path"])

	found.OnEvent("Close", (*) => found.Destroy())
	foundList.OnEvent("DoubleClick", openFolder.Bind(shouldOpen))

	foundList.Opt("-redraw")

	Loop Files folder . "\*.*", "R" {
		if InStr(A_LoopFileName, search.Value, caseSense)
			foundList.Add(, A_LoopFileFullPath)
	}

	foundList.Opt("+redraw")

	found.Show("W1500 H500")

	openFolder(shouldOpen, foundList, rowNumber) {
		path := foundList.getText(rowNumber)
		A_Clipboard := path
		found.destroy()

		if shouldOpen {
			splitPath(path,, &dir)  
			run(dir)
		}
	}
}

; fix insecure URLs blocked by HTTPS Everywhere and uBlock Origin
fixBlockedURLs() {
	A_Clipboard := ""
	send("^l")
	sleep(15)
	send("^c")
	clipWait
	ext := subStr(A_Clipboard, 1, 24)
	if (ext = "chrome-extension://gcbom") {							; if extension is HTTPS Everywhere
		temp := subStr(A_Clipboard, 100)							; cut relevant section of url 
		A_Clipboard := "https://" strReplace(temp, "%2F", "/")		; reparse url and copy it to clipboard
		send("^v{Enter}")
	} else if (ext = "chrome-extension://cjpal") {					; if extension is uBlock Origin
		click("75 365")												; select relevant url
	} else {
		result := msgBox("
			(
				Unable to convert URL.
				Reason: Extension ID could not be identified.

				Please ensure you are on a chrome-extensions block page.
			)",
			"AutoHotkey Error | Reiwa Main",
			277
		)
		(result = "retry" ?	fixBlockedURLs() : False)
	}
}

; gets hosts public IP address
getIP() {
	rqst := comObject("WinHttp.WinHttpRequest.5.1")
	rqst.open("GET", "https://api.ipify.org")
	rqst.send()
	return rqst.responseText
}

; get current input language
getLang() => subStr(format("{:x}", dllCall("GetKeyboardLayout", "int", 0)), -4)

; returns the raw hotkey pressed. equivalent to A_ThisHotkey without modifiers.
getRawHotkey(hotkey) {
	regExMatch(hotkey, "([\w\d]+)$", &rawHotkey)	; uses regex to match only the hotkey and saves the capture group in a match object
	return str(rawHotkey[1])						; accesses the capture group and returns it as a string
}

; force a given window to have active status
makeActiveWindow(window) => (winExist(window) ? winActivate(window) : False)

; open wordle links in a new Chrome
openWordle() {
	run("chrome.exe https://sutom.nocle.fr/ --new-window")
	run("https://taximanli.github.io/kotobade-asobou/")
	run("https://www.nytimes.com/games/wordle/index.html")
	run("https://swag.github.io/evil-wordle/")
	run("https://logle.app/previous.php")
	run("https://flaggle.app/")
	run("https://worldle.teuteuf.fr/")
}

; set input language
setLang(lang) {
	langs := map(
		"ja", "0x0411",
		"fr", "0x0c0c",
		"en", "0x0809"
	)

	postMessage(0x0050,, langs[lang],, "A")
}

; set a window's transparency
setTrans(polarity := True, window := "A", amount := 20) {
	; get the current window transparency
	howTrans(window) => (!winGetTransparent(window) ? 255 : winGetTransparent(window))

	amount := howTrans(window) + (!winActive("Google Chrome") ? (polarity ? (-amount) : (amount)) : (polarity ? (-2) : (5)))
	winSetTransparent((amount <= 0 ? 1 : amount), window)
}

; note - the vimium 'ignore keyboard layout' option must be enabled for this function to work reliably
; resets vimium, puts it into input mode, then maximizes and changes the playback speed of the yt video
setVideoSizeSpeed() => (winActive("YouTube") ? send("{Escape}if{> 4}") : False)

; rename the built-in string() function to str()
str(value) => string(value)

; toggle discord process
toggleDiscord() {
	if (PID := processExist("Discord.exe"))
		processClose(PID)
	else {
		run("C:\Users\Ross Strachan\AppData\Local\Discord\app-1.0.9004\Discord.exe")
		winWait("Discord",, 15)
		sleep(2000)
		winActivate("Discord")
		send("#{Up} & #+{Left}")
	}
}

; changes the default volume button change step
volumeChange(amount) {
	send("{Volume_Up}")										; changes the volume in order to show the volume box
	soundSetVolume(round(soundGetVolume(), -1) + amount)	; rounds the volume to the nearest 10, then changes the volume by the specified amount
}
