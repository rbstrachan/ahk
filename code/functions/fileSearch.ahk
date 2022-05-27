; credit @axlefublr
FileSearch(shouldOpen := True, caseSense := "Off") {
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
