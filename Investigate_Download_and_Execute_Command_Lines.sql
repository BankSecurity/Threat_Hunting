event_simpleName=ProcessRollup2 OR event_simpleName=ProcessBlocked  OR event_simpleName=ProcessBlocked (FileName=mshta.exe AND CommandLine="*script*") OR (FileName=regsrv32.exe AND CommandLine="*\/i*") OR (FileName=certutil.exe AND CommandLine="*-urlcache*") OR (FileName=wmic.exe AND CommandLine="*http*") OR (FileName=bitsadmin.exe AND CommandLine="*download*")
| eval timestamp=(timestamp / 1000) 
| convert timeformat="%FT%H:%M:%S.%3N UTC" ctime(timestamp) AS timestamp_readable 
| table timestamp_readable ComputerName FileName CommandLine