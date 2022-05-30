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
; changes @rbstrachan
; recursively searches the target folder and all subfolders for a specified string
fileSearch(caseSense := False) {
	folder := dirSelect("*C:", 0, "Select a target folder.") ; display a standard dialogue to allow user to select target folder 
	if !folder ; exit if no or invalid folder selected
		return

	defaults := [".pdf"] ; ".ahk", ".dll", "chrome.exe", "images" list of default options to be displayed in seach box

	; note: display chosen folder in search inputBox and add button to change folder
	search := inputBox("Specify a file name, extension or part thereof to search the taget folder for...", "File Search", "W300 H110", defaults[random(1, defaults.length)]) ; prompts user for string to search for

	if search.result = "Cancel" || !search.value ; exit if cancel button pushed or no search string provided
		return

	if regExMatch(search.value, "[^\w.-]") ; set caseSense to "locale" if search request contains non-standard characters
		caseSense := "locale"

	container := gui("+resize", "Search Results") ; declare the container GUI window
	foundList := container.add("ListView", "-redraw count50", ["Name", "Folder", "Type"]) ; add ListView GUI object to display results 
	Loop Files folder "\*.*", "FDR" { ; recurively loops through all files and directories within target folder
		if inStr(A_LoopFileName, search.value, caseSense) ; if requested search string is found 
			foundList.add(, A_LoopFileName, A_LoopFileDir, A_LoopFileExt) ; add it's name, location and extension to a new row in foundList ListView object
	}

	if !foundList.getCount() { ; give information message then immediately exit if search finishes with no results
		msgBox("The search for `"" search.value "`" in`ndirectory " folder "`nobtained no results.", "fileSearch | Info — No Results Found", 48)
		return
	}

	container.show("W" A_ScreenWidth/2 " H" 2/3*A_ScreenHeight)				; set the size of the container gui window
	container.onEvent("Close", (*) => container.destroy())					; destroy the container when closed
	container.onEvent("Escape", (*) => container.destroy())					; destroy the container when escaped
	container.onEvent("Size", guiSize)										; call guiSize() when container window is resized or has it's minMax state toggled
	foundList.onEvent("DoubleClick", runFileFolder)							; call runFileFolder() if and item it double-clicked
	foundList.onEvent("ContextMenu", showContextMenu)						; call showContextMenu() if an item is right-clicked
	foundList.modifyCol(), foundList.modifyCol(3, "AutoHdr")				; resize columns to fit data and header lengths
	foundList.move(,, (A_ScreenWidth/2) - 20, (2/3*A_ScreenHeight) - 15)	; set initial ListView GUI size relative to container size
	foundList.opt("+redraw")												; draw the ViewList containing search results

	runFileFolder(foundList, rowNumber) {
		try run(path := foundList.getText(rowNumber, 2) "\" foundList.getText(rowNumber)) ; attempt to run the path of the selected row's file or folder
		container.destroy() ; destroy the container GUI and everything in it
		
		if A_LastError ; give a warning message if try clause fails
			msgBox("The process was abandoned because an error`nwas encountered while attempting to open`n`"" path "`".", "fileSearch | runFileFolder Error", 16)
	}

	showContextMenu(foundList, item, isRightClick, x, y) {
		contextMenu := menu() ; create a menu GUI object
		contextMenu.add("Open", cmExecute) ; run or open the selected file or folder
		contextMenu.add ; add a separation line
		contextMenu.add("Show in folder", cmExecute) ; open the folder in which the file is located and highlight file
		contextMenu.add("Copy as path", (*) => A_Clipboard := foundList.getText(item, 2) "\" foundList.getText(item)) ; copy the file path to the clipboard
		contextMenu.add
		contextMenu.add("Properties", cmExecute) ; show the file or folder's properties window
		contextMenu.default := "Open" ; sets the default option to "Open" and makes it bold to show that double-clicking would have the same effect
		contextMenu.show(x, y) ; show the context menu at the cursors current coordinates

		; contextMenuExecute() — sets the switch based on the selected menu option, then runs the switch with the path of the selected file
		cmExecute(itemName, *) { ; '*' is used because cmExecute() expects multiple mandatory parameters which are not needed here
			flag := (itemName ~= "S" ? "explorer.exe /select," : (itemName ~= "P" ? "properties " : "")) ; flag is used here as 'switch' is a reserved keyword

			try run(flag path := foundList.getText(item, 2) "\" foundList.getText(item))
			container.destroy() ; destroy the container GUI and everything in it
			
			if A_LastError ; give a warning message if try clause fails
				msgBox("The process was abandoned because an error`nwas encountered while attempting to open`n`"" path "`".", "fileSearch | cmExecute Error", 16)
		}
	}

	; set the size of the ViewList GUI relative to contextMenu GUI's dimensions
	guiSize(thisGui, minMax, width, height) { ; note: `thisGui` is used instead of `contextMenu` for speed and reliability
		foundList.move(,, width - 20, height - 15)
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

getSUTOMList(wordLength, startingLetter) {
	rqst := comObject("WinHttp.WinHttpRequest.5.1")
	rqst.open("GET", "https://www.liste-de-mots.com/mots-nombre-lettre/" wordLength "/" startingLetter "/")
	rqst.send(), rqst.waitForResponse()
	reponseArray := strSplit(rqst.responseText, "`n")
	return strReplace(subStr(reponseArray[83], 3, -4), ", ", "`n")
}

; force a given window to have active status
makeActiveWindow(window) => (winExist(window) ? winActivate(window) : False)

; open wordle links in a new Chrome
openWordle() {
	winWait(run("chrome.exe https://sutom.nocle.fr/ --new-window"))
	run("https://taximanli.github.io/kotobade-asobou/")
	run("https://www.nytimes.com/games/wordle/index.html")
	run("https://logle.app/previous.php")
	run("https://flaggle.app/")
	run("https://worldle.teuteuf.fr/")
	run("https://swag.github.io/evil-wordle/")
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
