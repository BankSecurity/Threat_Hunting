/* https://attack.mitre.org/techniques/T1218/003/ */ 
/* https://github.com/redcanaryco/atomic-red-team/blob/master/atomics/T1218.003/T1218.003.md */ 

event_simpleName=ProcessRollup2 OR event_simpleName=ProcessBlocked OR event_simpleName=SyntheticProcessRollup2 FileName="cmstp*"
| eval timestamp=(timestamp / 1000) 
| convert timeformat="%FT%H:%M:%S.%3N UTC" ctime(timestamp) AS timestamp_readable 
| table timestamp_readable ComputerName UserName ImageFileName CommandLine