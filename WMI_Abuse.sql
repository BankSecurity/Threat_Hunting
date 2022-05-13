/*	https://attack.mitre.org/techniques/T1047/	*/

event_simpleName=ProcessRollup2 OR event_simpleName=ProcessBlocked OR event_simpleName=SyntheticProcessRollup2 CommandLine="*wmic* useraccount get /ALL*" OR CommandLine="*wmic* process get caption,executablepath,commandline*" OR CommandLine="*wmic* qfe get description,installedOn*" OR CommandLine="*wmic* /node:* service*" OR CommandLine="*wmic* process call create*" OR CommandLine="*wmic* /node:* process call create*" 
| eval timestamp=(timestamp / 1000) 
| convert timeformat="%FT%H:%M:%S.%3N UTC" ctime(timestamp) AS timestamp_readable 
| table timestamp_readable ComputerName UserName ImageFileName CommandLine