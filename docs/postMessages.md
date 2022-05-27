# wm_command messages
A list of wm_command messages that I use

## `WM_INPUTLANGCHANGEREQUEST` (winuser) (0x0050)
### posted to the active window when the user chooses, or requests a new input language.

request the input language be changed to french
```ahk
postMessage(0x0050,, "0x0c0c",, "A")
```
