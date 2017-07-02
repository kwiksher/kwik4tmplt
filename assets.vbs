Set objFSO = CreateObject("Scripting.FileSystemObject")

zipfile = ".\assets.zip"

objFSO.OpenTextFile(zipfile, 2, True).Write "PK" & Chr(5) & Chr(6) _
  & String(18, Chr(0))

Set ShellApp = CreateObject("Shell.Application")
Set zip = ShellApp.NameSpace(objFSO.GetAbsolutePathName(zipfile))

zip.CopyHere objFSO.GetAbsolutePathName(".\build4\model.json")
WScript.Sleep 500
zip.CopyHere objFSO.GetAbsolutePathName(".\build4\assets\audios")
WScript.Sleep 1000
zip.CopyHere objFSO.GetAbsolutePathName(".\build4\assets\images")
WScript.Sleep 5000

'dim folder
'set folder = objFSO.getFolder(".\build4\assets")
'for each subfolder in folder.subfolders
'    zip.CopyHere subfolder.Path
'    WScript.Sleep 5000
'next 
