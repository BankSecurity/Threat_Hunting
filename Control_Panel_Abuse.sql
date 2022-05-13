/* https://attack.mitre.org/techniques/T1218/002/ */

event_simpleName=ProcessRollup2 OR event_simpleName=ProcessBlocked OR event_simpleName=SyntheticProcessRollup2 CommandLine="*control.exe *.cpl*" NOT CommandLine="*control.exe desk.cpl,,3*" NOT CommandLine="*control.exe mmsys.cpl*"
| eval timestamp=(timestamp / 1000) 
| convert timeformat="%FT%H:%M:%S.%3N UTC" ctime(timestamp) AS timestamp_readable 
| table timestamp_readable ComputerName UserName ImageFileName CommandLine