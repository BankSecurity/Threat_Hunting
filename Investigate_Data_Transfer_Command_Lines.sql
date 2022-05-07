event_simpleName=ProcessRollup2 OR event_simpleName=ProcessBlocked  (FileName=ftp.exe) OR (FileName=sftp.exe) OR (FileName=ssh.exe) OR (FileName=scp.exe) OR (FileName=copy.exe AND CommandLine="*\\\\*") OR (FileName=bitsadmin.exe) OR (FileName=rar.exe AND CommandLine="*\\temp\\*") OR (FileName=makecab.exe AND CommandLine="*\\temp\\*")
| eval timestamp=(timestamp / 1000) 
| convert timeformat="%FT%H:%M:%S.%3N UTC" ctime(timestamp) AS timestamp_readable 
| table timestamp_readable ComputerName FileName CommandLine
| sort by CommandLine