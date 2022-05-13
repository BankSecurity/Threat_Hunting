event_simpleName=ProcessRollup2 OR event_simpleName=SyntheticProcessRollup2 OR event_simpleName=ProcessBlocked [search event_simpleName=DnsRequest (DomainName=google.com)] 
| rename ContextProcessId_decimal AS TargetProcessId_decimal 
| fields aid TargetProcessId_decimal] 
| table _time ComputerName UserName FileName CommandLine
