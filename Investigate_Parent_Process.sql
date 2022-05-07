/* Search for all ParentProcess of a specific file */

event_simpleName=ProcessRollup2 OR event_simpleName=ProcessBlocked 
    [ search event_simpleName=ProcessRollup2 OR event_simpleName=ProcessBlocked FileName=excel.exe 
    | rename ParentProcessId_decimal AS TargetProcessId_decimal 
    | fields aid TargetProcessId_decimal] 
| stats count by FileName CommandLine