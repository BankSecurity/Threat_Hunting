event_simpleName=ProcessRollup2 FileName=powershell.exe (CommandLine=*Invoke-WebRequest* OR CommandLine=*Net.WebClient* OR
    CommandLine=*Start-BitsTransfer*) 
| table ComputerName UserName FileName CommandLine
| stats count by CommandLine 