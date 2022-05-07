event_simpleName=ProcessRollup2 OR event_simpleName=ProcessBlocked  (FileName=net.exe AND (CommandLine="*view*" OR CommandLine="*session*")) OR (FileName=nmap.exe) OR (FileName=nc.exe) OR (FileName=ncat.exe) OR (FileName=dir.exe AND CommandLine="*\\\\*") OR (FileName=wmic.exe AND CommandLine="*//node*") 
| eval timestamp=(timestamp / 1000) 
| convert timeformat="%FT%H:%M:%S.%3N UTC" ctime(timestamp) AS timestamp_readable 
| table timestamp_readable ComputerName UserName FileName CommandLine