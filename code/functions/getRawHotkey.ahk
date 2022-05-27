; this function was created in response to a help request on the AHK discord server
; this function requires the str() function to work. alternatively, replace `str()` with `string()`.
; returns the raw hotkey pressed. equivalent to A_ThisHotkey without modifiers.
getRawHotkey(hotkey) {
	regExMatch(hotkey, "([\w\d]+)$", &rawHotkey)	; uses regex to match only the hotkey and saves the capture group in a match object
	return str(rawHotkey[1])						; accesses the capture group and returns it as a string
}
