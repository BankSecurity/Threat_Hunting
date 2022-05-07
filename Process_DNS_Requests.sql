eventtype=eam (TERM(ProcessRollup2) OR TERM(SyntheticProcessRollup2)) FileName="cmd.exe"
| join type=inner TargetProcessId_decimal, aid 
    [ search eventtype=eam (TERM(DnsRequest) OR TERM(SuspiciousDnsRequest)) ]
    | eval DomainName=lower(DomainName)
    | stats values(DomainName) as DomainName by ContextProcessId_decimal aid
    | rename ContextProcessId_decimal AS TargetProcessId_decimal 