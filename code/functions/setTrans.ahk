; set a window's transparency
setTrans(polarity := True, window := "A", amount := 20) {
	; get the current window transparency
	howTrans(window) => (!winGetTransparent(window) ? 255 : winGetTransparent(window)) ; winGetTransparent returns `""` if the window has no transparency level

	amount := howTrans(window) + (!winActive("Google Chrome") ? (polarity ? (-amount) : (amount)) : (polarity ? (-2) : (5)))
	winSetTransparent((amount <= 0 ? 1 : amount), window)
}
