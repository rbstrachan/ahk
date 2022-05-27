; credit @axlefublr
; changes by @rbstrachan
; a faster send(). send() can take faaaaar too long. copy-pasting it is much faster.
clipSend(toSend, endChar := "", persistent := False, untilRevert := 200) {	; sets 'persistent' and 'endChar' parameters to 'false' by default
	  prevClip := A_Clipboard												; stores the current clipboard in a temporary variable
	, A_Clipboard := (endChar ? toSend endChar : toSend)					; appends requested 'endChar' to 'toSend' string and stores result in clipboard
	, send("^v")															; pastes the clipboard
	, (!persistent ? clipBack() : False)									; restores the clipboard if 'persistent' parameter is 'false'

	; restores the keyboard after it has been hijacked
	clipBack() => setTimer(() => A_Clipboard := prevClip, -untilRevert)	
}
