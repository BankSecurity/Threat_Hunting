/* https://attack.mitre.org/techniques/T1216/ */

event_simpleName=ProcessRollup2 OR event_simpleName=ProcessBlocked OR event_simpleName=SyntheticProcessRollup2 FileName="SyncAppvPublishingServer*" OR CommandLine="*cscript *manage-bde.wsf*"
| eval timestamp=(timestamp / 1000) 
| convert timeformat="%FT%H:%M:%S.%3N UTC" ctime(timestamp) AS timestamp_readable 
| table timestamp_readable ComputerName UserName ImageFileName CommandLine