event_simpleName=ProcessRollup2 OR event_simpleName=ProcessBlocked 
    [ search event_simpleName=ProcessRollup2 OR event_simpleName=ProcessBlocked FileName=cmd.exe 
    | rename TargetProcessId_decimal AS ParentProcessId_decimal 
    | fields aid ParentProcessId_decimal] 
| stats count by FileName CommandLine