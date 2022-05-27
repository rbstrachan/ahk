# code style reference
A list of coding conventions that I follow to ensure consistency between scripts and projects.

1. Code should be written on a single line where possible. Ternary expressions and function, array and map calls are not expanded.

```ahk
terminaisons[groupes[subStr(verbe, -2)]][modes[mode]][tenses[modes[mode]][tense]][pronoms[pronom]] ; call the 4-dim `terminaisons` array

((regExMatch(verbe, "ger$") && regExMatch(subStr(finPartie[indice], 1, 1), "[aâo]")) ? finPartie[indice] := "e" finPartie[indice] : False) ; correctly conjugate french verbs that end in "ger"
```

2. Always use parenthesis for function definitions and calls

```ahk
thisIsATestFunction(parameter := "default") {
	[code]
}

thisIsATestFunction("inputParam")
```

3. Always use OTB bracket style, except when not required by the parser, for example, with `if` statements that contain only one line

```ahk
loop files "\*.*" {
	[code]
}

if conditionToTest {
	[multi]
	[line]
	[code]
}

if conditionToTest
	[single line code]
else {
	[multi]
	[line]
	[code]
}
```

4. Fat-arrow functions are recommended when their use makes sense, for example, to rename a default function, or when creating a single line function that immediately returns a value or object. Also acceptable when attempting to hide the function from VSC IntelliSense.

for example
```ahk
; rename the default string() function to str()
str(value) {
	return string(value)
}
```
is better written as
```ahk
str(value) => string(value) ; rename the default string() function to str()
```
and
```ahk
; return the current input language
getLang() {
	return subStr(format("{:x}", dllCall("GetKeyboardLayout", "int", 0)), -4)
}
```
is better written as
```ahk
getLang() => subStr(format("{:x}", dllCall("GetKeyboardLayout", "int", 0)), -4) ; return the current input language
```

5. Ternary over `if/ifelse/else` statements that can be written in a single line, even if there is no `false` condition.

```ahk
makeActiveWindow(window) => (winExist(window) ? winActivate(window) : False)
```
is preferred over
```ahk
makeActiveWindow(window) {
	if winExist(window)
		winActivate(window)
}
```

6. camelCase is used for variable and function names. PascalCase is used for class names, default variables and keywords such as `A_Clipboard`, `A_LastError` and `True`.

```ahk
var
thisIsAlsoAVar
function()
myFunction()
A_BuiltInVariable
Class
MyClass
```
