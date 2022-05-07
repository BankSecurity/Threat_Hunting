event_simpleName=ProcessRollup2 FileName=bitsadmin.exe (CommandLine=*/Transfer* OR CommandLine=*/Addfile*) 
| dedup CommandLine 
| table _time aid ComputerName UserName ImageFileName CommandLine TargetFileName MD5HashData SHA256HashData 
| sort -_time