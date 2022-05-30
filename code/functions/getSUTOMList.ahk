getSUTOMList(wordLength, startingLetter) {
	rqst := comObject("WinHttp.WinHttpRequest.5.1")
	rqst.open("GET", "https://www.liste-de-mots.com/mots-nombre-lettre/" wordLength "/" startingLetter "/")
	rqst.send(), rqst.waitForResponse()
	reponseArray := strSplit(rqst.responseText, "`n")
	return strReplace(subStr(reponseArray[83], 3, -4), ", ", "`n")
}
