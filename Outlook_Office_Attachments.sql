ComputerName=* event_simpleName=ProcessRollup2 OR event_simpleName=ProcessBlocked CommandLine="*content.outlook*" FileName=winword.exe OR FileName=excel.exe OR FileName=powerpnt.exe 
| table timestamp ComputerName CommandLine 
| sort – timestamp
| eval timestamp=strftime(timestamp/1000, "%Y-%m-%d %H:%M:%S")