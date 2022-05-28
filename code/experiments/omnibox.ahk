omnibox() {
	displayOmnibox() {
		omnibox := gui("AlwaysOnTop", "omnibox")
		omnibox.setFont("s14 q5", "Inter")
		omniInput := omnibox.add("edit", "limit x10 W" A_ScreenWidth/3)
		omnibox.onEvent("Close", destroyGUI) ; destroy the omnibox when closed
		omnibox.show("y-30 W" A_ScreenWidth/3 + 20)

		hotkey("Escape", destroyGUI, "on") ; destroy the omnibox when escaped
		hotkey("Enter", getInput, "on")

		output := ""

		destroyGUI(*) {
			hotkey("Escape", "off")
			hotkey("Enter", "off")
			omnibox.destroy()
		}

		getInput(*) {
			omnibox.submit()
			output := omniInput.value
			destroyGUI()
		}

		WinWaitClose(omnibox.hwnd)

		if !output
			return
		return output
	}
}
