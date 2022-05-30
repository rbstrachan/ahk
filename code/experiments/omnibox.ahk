omnibox() {
	omnibox := gui("AlwaysOnTop -caption")
	omnibox.backColor := "171717" ; required to prevent flashing on load
	omnibox.add("picture", "x0 y0", "C:\Users\Ross Strachan\Downloads\gui-bg.png")
	omnibox.setFont("s20 q5 ccf68e1", "DM Mono Medium")
	omniEdit := omnibox.add("edit", "lowercase background171717 -E0x200 x20 y15 H35 W" 3/8*A_ScreenWidth - 50)
	omnibox.onEvent("Close", destroyGUI) ; destroy the omnibox when closed
	omnibox.show("y" A_ScreenHeight/4 " H67 W" (3/8*A_ScreenWidth) + 32) ; the extra two pixels in H67 and W+32 are necessary to fit the background image

	winSetTransColor("0fff00", omnibox) ; make the corner pixels transparent to give the appearance of rounded corners

	hotkey("Escape", destroyGUI, "on")	; destroy the omnibox when escaped
	hotkey("Enter", getInput, "on")		; get the value of the edit box then destroy the gui when Enter is pressed

	destroyGUI(*) {
		hotkey("Escape", "off")
		hotkey("Enter", "off")
		omnibox.destroy()
	}

	editOut := ""
	getInput(*) {
		omnibox.submit()
		editOut := omniEdit.value
		destroyGUI()
	}

	winWaitClose(omnibox.hwnd)

	if !editOut
		return

	spaceCount := 0
	loop strLen(editOut) {
		if (subStr(editOut, A_Index, 1) = " ")
			spaceCount++
	}

	wordCount := spaceCount + 1

	regEx := "([\w\d'-àáâîïùûüèéêëôç.?!()]+)"
	regExPattern := A_Space regEx

	loop spaceCount {
		regEx .= regExPattern
	}

	regExMatch(editOut, "^" regEx "$", &parameter)
	
	rest := ""
	loop (wordCount - 2) { ; don't include the first two words in the loop
		rest .= A_Space parameter[A_Index + 2] ; starting from the third word, append to 'rest'
	}

	try {
		switch parameter[1] {
			case "syn", "synonym", "synonyms": run("https://www.thesaurus.com/browse/" parameter[2])
			case "mots": ; the following ternary always ensures getSUTOMList's parameters are passed in the correct order
				listeMots := (isInteger(parameter[2]) ? getSUTOMList(parameter[2], parameter[3]) : getSUTOMList(parameter[3], parameter[2]))
				winActivate("Visual Studio Code")
				send("^n")
				clipSend(listeMots)

			case "d", "discord", "togglediscord", "togglediscord()": toggleDiscord()

			case "o", "open":
				switch parameter[2] {
					case "dl", "download", "downloads":	run("explore C:\Users\Ross Strachan\Downloads")
				}

			case "gh", "github":
				switch parameter[2] {
					case "ahk", "rbstrachan/ahk":			run("https://github.com/rbstrachan/ahk")
					case "personal", "axlefublr/personal":	run("https://github.com/axlefublr/personal")
				}

			case "t", "tl", "tr", "gt":
				switch parameter[2] {
					case "en", "e":			run("https://translate.google.com/?sl=auto&tl=en&text=" rest)
					case "fr", "f":			run("https://translate.google.com/?sl=auto&tl=fr&text=" rest)
					case "jp", "ja", "j":	run("https://translate.google.com/?sl=auto&tl=ja&text=" rest)
					case "ru", "r":			run("https://translate.google.com/?sl=auto&tl=ru&text=" rest)

					case "enfr", "ef":			run("https://translate.google.com/?sl=en&tl=fr&text=" rest)
					case "enjp", "enja", "ej":	run("https://translate.google.com/?sl=en&tl=ja&text=" rest)
					case "enru", "er":			run("https://translate.google.com/?sl=en&tl=ru&text=" rest)
					case "fren", "fe":			run("https://translate.google.com/?sl=fr&tl=en&text=" rest)
					case "frjp", "frja", "fj":	run("https://translate.google.com/?sl=fr&tl=ja&text=" rest)
					case "frru":				run("https://translate.google.com/?sl=fr&tl=ru&text=" rest)
					case "jpen", "jaen", "je":	run("https://translate.google.com/?sl=ja&tl=en&text=" rest)
					case "jpfr", "jafr", "jf":	run("https://translate.google.com/?sl=ja&tl=fr&text=" rest)
					case "jpru", "jaru", "jr":	run("https://translate.google.com/?sl=ja&tl=ru&text=" rest)
					case "ruen", "re":			run("https://translate.google.com/?sl=ru&tl=en&text=" rest)
					case "rufr", "rf":			run("https://translate.google.com/?sl=ru&tl=fr&text=" rest)
					case "rujp", "ruja", "rj":	run("https://translate.google.com/?sl=ru&tl=ja&text=" rest)
				}
				default: msgBox("The process was abandoned because the input`n   flag could not be matched to a switch case.", "omnibox | Error — Match Not Found", "54 T4")
		}
	}
}
