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
