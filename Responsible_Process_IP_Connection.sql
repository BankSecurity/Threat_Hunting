event_simpleName=ProcessRollup2 OR event_simpleName=ProcessBlocked OR event_simpleName=SyntheticProcessRollup2 [search event_simpleName=NetworkConnectIP4 (RemoteAddressIP4=1.1.1.1)] 
| rename ContextProcessId_decimal AS TargetProcessId_decimal 
| fields aid TargetProcessId_decimal] 
| table _time ComputerName UserName FileName CommandLine
