event_simpleName=NewScriptWritten FilePath="*\\Windows\\Temp\\*" NOT FilePath="*\\Windows\\Temp\\*\\*"
| stats count by TargetFileName 
| where count < 10 
| sort - count asc