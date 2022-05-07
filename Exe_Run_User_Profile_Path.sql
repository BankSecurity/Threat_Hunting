(event_simpleName=ProcessRollup2 OR event_simpleName=SyntheticProcessRollup2) AND (ImageFileName="*\\AppData\\*" OR ImageFileName="*\\Desktop\\*" OR ImageFileName="*\\AppData\\Local\\*" OR ImageFileName="*\\AppData\\Local\\Temp\\*" OR ImageFileName="*\\AppData\\Roaming\\*") 
| regex ImageFileName=".*\\\\Desktop\\\\\w+\.exe|.*\\\\AppData\\\\\w+\.exe|.*\\\\AppData\\\\Local\\\\\w+.exe|.*\\\\AppData\\\\Local\\\\Temp\\\\\w+.exe|.*\\\\AppData\\\\Roaming\\\\\w+.exe" 
| fields ComputerName UserName ImageFileName FileName SHA256HashData
| stats count values(FileName) by SHA256HashData