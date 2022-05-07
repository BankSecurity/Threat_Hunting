event_simpleName=NewExecutableWritten FilePath="*\\Users\\*\\AppData\\Local\\Microsoft\\Windows\\INetCache\\*\\" AND (FileName="*.exe" OR FileName="*.sct")
| stats count by ComputerName TargetFileName 
| sort count