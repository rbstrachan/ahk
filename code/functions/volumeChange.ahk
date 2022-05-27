; changes the default volume button change step
volumeChange(amount) {
	send("{Volume_Up}")										; changes the volume in order to show the volume box
	soundSetVolume(round(soundGetVolume(), -1) + amount)	; rounds the volume to the nearest 10, then changes the volume by the specified amount
}
