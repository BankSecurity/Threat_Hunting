event_simpleName=ProcessRollup2 OR event_simpleName=ProcessBlocked OR event_simpleName=SyntheticProcessRollup2 CommandLine="*net user /add*" OR CommandLine="*New-LocalUser*" OR CommandLine="*net localgroup administrators*"
| stats count by CommandLine
