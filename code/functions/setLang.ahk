; note - this function uses a `postMessage()` call which may cause some programs to crash
; note - programs may ignore the WM_INPUTLANGCHANGEREQUEST message, in which case it will not work
; set input language via WM_INPUTLANGCHANGEREQUEST message
setLang(lang) {
	langs := map(
		"ja", "0x0411",
		"fr", "0x0c0c",
		"en", "0x0809"
	)

	postMessage(0x0050,, langs[lang],, "A")
}
