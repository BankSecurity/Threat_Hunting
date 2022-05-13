/*	https://attack.mitre.org/techniques/T1218/	*/

event_simpleName=ProcessRollup2 OR event_simpleName=ProcessBlocked OR event_simpleName=ProcessBlocked (FileName="mavinject*" NOT CommandLine="*Microsoft Office\\root\\Client\\AppVIsvSubsystems32.dll*") OR FileName="Register-CimProvider*" OR FileName="InfDefaultInstall*" 
| eval timestamp=(timestamp / 1000) 
| convert timeformat="%FT%H:%M:%S.%3N UTC" ctime(timestamp) AS timestamp_readable 
| table timestamp_readable ComputerName UserName ImageFileName CommandLine