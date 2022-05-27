; send copied text to search engine
copySearch(site := "https://duckduckgo.com/?q=") {
	clipTemp := A_Clipboard
	A_Clipboard := ""
	send("^c")
	clipWait
	(InStr(A_Clipboard, "http") ? run(A_Clipboard) : run(site A_Clipboard))
	A_Clipboard := clipTemp
}
