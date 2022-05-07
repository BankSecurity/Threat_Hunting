event_simpleName=ProcessRollup2 OR event_simpleName=ProcessBlocked
    [| search event_simpleName=ProcessRollup2 OR event_simpleName=ProcessBlocked (TERM(psexecsvc) AND FileName=psexecsvc.exe) OR (TERM(wsmprovhost) AND FileName=wsmprovhost.exe) 
    | stats count by TargetProcessId_decimal 
    | fields TargetProcessId_decimal 
    | rename TargetProcessId_decimal as ParentProcessId_decimal 
    | format] 
| stats values(FileName) AS FileName, values(CommandLine) AS ChildCommand values(ComputerName) as ComputerName values(UserName) as UserName by ParentProcessId_decimal