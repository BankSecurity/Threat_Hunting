event_simpleName=ProcessRollup2 FileName=outlook.exe 
| dedup aid TargetProcessId_decimal 
| rename FileName as Parent 
| rename CommandLine as ParentCmd 
| table aid TargetProcessId_decimal Parent ParentCmd 
| join max=0 aid TargetProcessId_decimal 
    [ search event_simpleName=ProcessRollup2 FileName=chrome.exe OR FileName=firefox.exe OR FileName=iexplore.exe OR FileName=msedge.exe
    | rename ParentProcessId_decimal as TargetProcessId_decimal 
    | rename MD5HashData as MD5 
    | rename FilePath as ChildPath 
    | dedup aid TargetProcessId_decimal MD5 
    | fields aid TargetProcessId_decimal FileName CommandLine] 
| table Parent ParentCmd FileName CommandLine aid