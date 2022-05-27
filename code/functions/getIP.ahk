; gets hosts public IP address
getIP() {
	rqst := comObject("WinHttp.WinHttpRequest.5.1")
	rqst.open("GET", "https://api.ipify.org")
	rqst.send()
	return rqst.responseText
}
