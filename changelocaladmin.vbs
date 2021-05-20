on error resume next
strComputer = "."

//Set password below for the local admin account
strSetPassword = "password"

Set objUser = GetObject("WinNT://" & strComputer & "/Administrator")
objUser.SetPassword(strSetPassword)


Set objUser = Nothing
