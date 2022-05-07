event_simpleName=ProcessRollup2 OR event_simpleName=ProcessBlocked CommandLine="C:\\Windows\\Temp\\*.exe"
| table ComputerName FileName CommandLine SHA256HashData
| stats count values(CommandLine) by  SHA256HashData