event_platform="Win" cid=* (ProcessRollup2 OR SyntheticProcessRollup2) FileName="powershell*"
| cluster field=CommandLine labelonly=t t=0.6 
| stats first(_time) as min_time values(ComputerName) as ComputerNames values(CommandLine) as CommandLine by cluster_label 
| table min_time ComputerNames CommandLine cluster_label 
| convert ctime(min_time)