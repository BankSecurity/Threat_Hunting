event_simpleName=ProcessRollup2 FileName=powershell.exe (CommandLine=*-enc* OR CommandLine=*encoded*) 
| fields ComputerName FileName CommandLine
| stats count by CommandLine