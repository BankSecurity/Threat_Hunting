event_simpleName=ProcessRollup2 OR event_simpleName=ProcessBlocked OR event_simpleName=SyntheticProcessRollup2 CommandLine="*pcalua.exe* -a*"
| eval timestamp=(timestamp / 1000) 
| convert timeformat="%FT%H:%M:%S.%3N UTC" ctime(timestamp) AS timestamp_readable 
| table timestamp_readable ComputerName UserName ImageFileName CommandLine

event_simpleName=ProcessRollup2 OR event_simpleName=ProcessBlocked OR event_simpleName=SyntheticProcessRollup2 CommandLine="*forfiles* /p* c:\\windows\\system32* /m*"
| eval timestamp=(timestamp / 1000) 
| convert timeformat="%FT%H:%M:%S.%3N UTC" ctime(timestamp) AS timestamp_readable 
| table timestamp_readable ComputerName UserName ImageFileName CommandLine
