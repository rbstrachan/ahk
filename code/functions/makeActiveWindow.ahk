; force a given window to have active status
makeActiveWindow(window) => (winExist(window) ? winActivate(window) : False)
