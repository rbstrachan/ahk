; note - this function is designed to be used with the Chrome extension 'Vimium' while on YouTube
; note - the vimium 'ignore keyboard layout' option must be enabled for this function to work reliably
; resets vimium, puts it into input mode, then maximizes and changes the playback speed of the video
setVideoSizeSpeed() => (winActive("YouTube") ? send("{Escape}if{> 4}") : False)
