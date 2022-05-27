; separately convert the current date and time to hexadecimal then format them with a delimeter. to be used as version numbers.
convHexDateTimeToVersionNumber(delimeter := "-") {
	rawStr := format("{:X}" delimeter "{:03X}", formatTime(, "yyyyMMdd"), formatTime(, "HHmm"))
	return subStr(rawStr, 1, 4) delimeter subStr(rawStr, 5)
}
