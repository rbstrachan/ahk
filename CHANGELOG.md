# changelog
notable changes to this repository are documented here

<!--
`### added` for new features
`### updated` for existing features that have new functionality
`### changed` for changes in existing functionality
`### deprecated` for soon-to-be removed features
`### removed` for now removed features
`### fixed` for any bug fixes
`### security` in case of vulnerabilities
-->

# upcoming releases
## `0.11.24`
### added
- `code/functions`
	- [`getSUTOMList.ahk`](code/functions/getSUTOMList.ahk) — gets a list of french words according to their length and starting character for use in the wordle-like game SUTOM

### updated
- `code/experiments/omnibox.ahk`
	- removed the title bar and window border with `-caption`
	- added a background image and set the `omnibox.backColor` to avoid flickering on load
	- the font
		- is now size 20
		- is pink
		- matches VS Code's font
	- the edit box
		- no longer has a word limit
		- now forces all lowercase letters
		- no longer has a border
		- now outputs to `omniEdit` instead of `omniInput`
	- the omnibox is now
		- wider to allow for longer queries to be easily entered
		- displayed dynamically at `A_ScreenHeight/4` instead of at the top of the screen
	- variable `output` renamed to `editOut`
	- added `spaceCount` and `wordCount` variables
	- added a dynamically-generated regEx pattern
	- added a switch which uses the regex output to implement
		- toggling discord
		- opening files and folders
		- opening github links
		- translating strings
- `code/scripts/autocorrect.ahk`
	- added `davoir` → `d'avoir`
	- added `japprends` → `j'apprends`
- `code/functions/all.ahk`
	- added `getSUTOMList.ahk`

### changed
- `code/hotkeys/hotkeys.ahk`
	- removed `#r` → `omnibox()` remap
	- added `!Space` → `omnibox()` remap 

### fixed
- `code/functions/openWorldle.ahk` and `all.ahk`
	- `openWordle()` now waits until a new chrome window exists before opening links to prevent bombarding the wrong window

<br>

# current release
## `0.10.5` — 2022-05-30
### added
- `code/experiments`
	- [`omnibox.ahk`](code/experiments/omnibox.ahk) — an experimental version of [@axlefublr](https://github.com/axlefublr)'s 'runner'.

### updated
- `code/scripts/autocorrect.ahk`
	- added `tetais` → `t'étais`

### changed
- `code/hotkeys/hotkeys.ahk`
	- added `#r` → `omnibox()` remap
	- remapped `F3` hotkey from `return` to `omnibox()`
	- remapped `F6` hotkey from `return` to `fileSearch()`

### fixed
- `code/hotkeys/hotkeys.ahk`
	- added missing virtual key comment labels for `setTrans()` hotkeys
- `code/scrips/autocorrect.ahk`
	- typing <code>e\`</code> once again correctly produces `è`

<br>

# previous releases
## `0.8.18` — 2022-05-28
### added
- `code/functions`
	- [`all.ahk`](code/functions/all.ahk) — all functions in one script for easy `#Import`ing

### updated
- `code/functions/clipSend.ahk`
	- added `fastReplace` function parameter. `clipSend` now highlights the target word before pasting the clipboard. faster than `send()`'s default replacement method. requires `b0` hotstring option.
- `code/functions/fileSearch.ahk`
	- added comments
	- added a context menu via `ListView.onEvent("ContextMenu", showContextMenu)`. replaces the `shouldOpen` function parameter.
	- `caseSense` is now set automatically if it's function parameter is set to `auto` and `search.value` contains non-stardard characters
	- `fileSearch` now also returns folders
	- the context menu option `Show in folder` now highlights the relevant file or folder

### changed
- `code/functions/clipSend.ahk`
	- `untilRevert` parameter default increased to `5000ms` to prevent the `clipBack()` function from inadvertantly interuppting keystrokes
	- `clipSend` is no longer written on a (pseudo) single line to prevent keystrokes from being interrupted if the execution of previous code is delayed
	- `clipSend` now appends the hotstring's `A_EndChar` if the `endChar` function parameter is not set
- `code/functions/fileSearch.ahk`
	- the `File Search` input box now
		- has preset dimentions, preventing it from creating unnecessarily large windows
		- gives example searches in the edit field
		- immediately returns if `input.value` is blank instead of showing an empty GUI
	- `caseSense` function parameter default changed to `auto`
	- renamed `found` GUI to `container` to more accurately represent it's function
	- the `container` GUI
		- is no longer `AlwaysOnTop`
		- now obtains it's initial dimentions dynamically from `A_ScreenWidth` and `A_ScreenHeight` 
		- can now be resized
		- can now be closed by pressing `Escape`
		- is now destroyed when closed instead of hidden
	- the `foundList` GUI now
		- has a minimum amount of memory permanantely allocated to improve performance
		- reports `A_LoopFileName`, `A_LoopFileDir` and `A_LoopFileExt` instead of just `A_LoopFileFullPath`
		- automatically resizes columns to fit the data they contain
	- an information message box is now displayed if `search.value` produces no matches instead of displaying an empty GUI
	- an error message is now displayed if `fileSearch` fails to open a file when requested, either by double-click or via the context menu

### removed
- `code/functions/fileSearch.ahk`
	- `shouldOpen` function parameter. replaced with `ContextMenu`.

## `0.1.0` — 2022-05-27
### added
- `code/hotkeys`
	- [`readme.md`](code/hotkeys/README.md)
	- [`hotkeys.ahk`](code/hotkeys/hotkeys.ahk)
- `code/experiments`
	- [`readme.md`](code/experiments/README.md)
	- [`conjugateFR.ahk`](code/experiments/conjugateFR.ahk)
- `code/scripts`
	- [`readme.md`](code/scripts/README.md)
	- [`autocorrect.ahk`](code/scripts/autocorrect.ahk)
	- [`directives.ahk`](code/scripts/directives.ahk) — recommended directives for use with v2
	- [`windowSpy.ahk`](code/scripts/WindowSpy.ahk) — v2 compatible version of WindowSpy

### updated
- `backups/default.code-workspace`

## `0.1.0-beta` — 2022-05-27
### added
- [`changelog`](CHANGELOG.md)
- [`code`](code) folder
	- [`scripts`](code/scripts) folder
	- [`functions`](code/functions) folder
		- [`clipSend.ahk`](code/functions/clipSend.ahk)
		- [`convHexDateTimeToVersionNumber.ahk`](code/functions/convHexDateTimeToVersionNumber.ahk)
		- [`copySearch.ahk`](code/functions/copySearch.ahk)
		- [`copyTranslate.ahk`](code/functions/copyTranslate.ahk)
		- [`fileSearch.ahk`](code/functions/fileSearch.ahk)
		- [`fixBlockedURLs.ahk`](code/functions/fixBlockedURLs.ahk)
		- [`getIP.ahk`](code/functions/getIP.ahk)
		- [`getLang.ahk`](code/functions/getLang.ahk)
		- [`getRawHotkey.ahk`](code/functions/getRawHotkey.ahk)
		- [`makeActiveWindow.ahk`](code/functions/makeActiveWindow.ahk)
		- [`openWordle.ahk`](code/functions/openWordle.ahk)
		- [`setLang.ahk`](code/functions/setLang.ahk)
		- [`setTrans.ahk`](code/functions/setTrans.ahk)
		- [`setVideoSizeSpeed.ahk`](code/functions/setVideoSizeSpeed.ahk)
		- [`str.ahk`](code/functions/str.ahk)
		- [`toggleDiscord.ahk`](code/functions/toggleDiscord.ahk)
		- [`volumeChange.ahk`](code/functions/volumeChange.ahk)
	- [`hotkeys`](code/hotkeys) folder
	- [`experiments`](code/experiments) folder
- [`backups`](backups) folder
	- [`default.code-workspace`](backups/default.code-workspace)
	- [`ahk.tmLanguage.json`](backups/ahk.tmLanguage.json)
- [`docs`](docs) folder
	- [`codeReference.md`](docs/codeReference.md)
	- [`postMessages.md`](docs/postMessages.md)

### updated
- [`readme.md`](README.md)
	- added `version`, `license` and `status` badges
	- added `changelog` section
	- included an index
	- added a disclaimer 

### changed
- newly added files and folders are now [linked](#) to make them clear and easily accessible
- renamed license → [license.md](LICENSE.md)

### fixed
- broken links in [readme.md](README.md)

---
format based on [keep a changelog](https://keepachangelog.com/)
