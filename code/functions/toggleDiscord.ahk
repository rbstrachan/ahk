; toggle discord process
toggleDiscord() {
	if (PID := processExist("Discord.exe"))
		processClose(PID)
	else {
		run("Discord.exe")
		winWait("Discord",, 15)
		sleep(2000)
		winActivate("Discord")
		send("#{Up} & #+{Left}")
	}
}
