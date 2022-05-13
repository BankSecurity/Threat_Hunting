event_simpleName=ProcessRollup2 OR event_simpleName=ProcessBlocked OR event_simpleName=SyntheticProcessRollup2 CommandLine="mshta* javascript*" OR CommandLine="mshta* vbscript*" OR CommandLine="wscript* syncappvpublishingserver.vbs*"
| eval timestamp=(timestamp / 1000) 
| convert timeformat="%FT%H:%M:%S.%3N UTC" ctime(timestamp) AS timestamp_readable 
| table timestamp_readable ComputerName UserName ImageFileName CommandLine