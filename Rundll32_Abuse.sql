/* https://attack.mitre.org/techniques/T1218/011/ */

event_simpleName=ProcessRollup2 OR event_simpleName=ProcessBlocked  OR event_simpleName=ProcessBlocked FileName="rundll32.exe" AND (CommandLine="*javascript:*" OR CommandLine="*vbscript:*" OR CommandLine="*advpack.dll,LaunchINFSection*" OR CommandLine="*ieadvpack.dll,LaunchINFSection*" OR CommandLine="*syssetup.dll,SetupInfObjectInstallAction*" OR CommandLine="*setupapi.dll,InstallHinfSection*")
| eval timestamp=(timestamp / 1000) 
| convert timeformat="%FT%H:%M:%S.%3N UTC" ctime(timestamp) AS timestamp_readable 
| table timestamp_readable ComputerName UserName ImageFileName CommandLine