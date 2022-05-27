; get current input language
getLang() => subStr(format("{:x}", dllCall("GetKeyboardLayout", "int", 0)), -4)
