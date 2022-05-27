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
			"fixBlockedURls | Error",
			277
		)
		(result = "retry" ?	fixBlockedURLs() : False)
	}
}
