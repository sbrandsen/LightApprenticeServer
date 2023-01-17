url = "https://raw.githubusercontent.com/sbrandsen/LightApprenticeServer/main/install.ps1"

Set req = CreateObject("Msxml2.XMLHttp.6.0")
req.open "GET", url, False
req.send

If req.Status = 200 Then
	Set fso = CreateObject("Scripting.FileSystemObject")
	scriptdir = CreateObject("Scripting.FileSystemObject").GetParentFolderName(WScript.ScriptFullName)
	scriptdir = scriptdir &"\setup.ps1" 
	
	If fso.FileExists(scriptdir) Then
		fso.DeleteFile scriptdir
	End If
	
	fso.OpenTextFile(scriptdir, 8, true, 0).Write req.responseText
	  
	Set oShell = CreateObject("Shell.Application")

	oShell.MinimizeAll
	Set objShell = CreateObject("WScript.shell")
	objShell.run("powershell -NoProfile -ExecutionPolicy Bypass -Command ""Start-Process -Verb RunAs powershell -ArgumentList '-NoProfile -ExecutionPolicy Bypass -File \""" + scriptdir + """'")

End If