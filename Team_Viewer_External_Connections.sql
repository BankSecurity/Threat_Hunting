event_simpleName=ProcessRollup2 OR event_simpleName=ProcessBlocked OR event_simpleName=SyntheticProcessRollup2 
    [| search index=discover_summary FileName="TeamViewer*" OR CompanyName="TeamViewer*"
    | stats count by FileName 
    | fields FileName] 
| join type=inner TargetProcessId_decimal 
    [| search event_simpleName=NetworkConnectIP4 (RemoteAddressIP4=* NOT RemoteAddressIP4="10.*" NOT RemoteAddressIP4="127.0.0.1" ) 
        [| search event_simpleName=ProcessRollup2 OR event_simpleName=ProcessBlocked OR event_simpleName=SyntheticProcessRollup2 
            [| search index=discover_summary FileName="TeamViewer*" OR CompanyName="TeamViewer*"
            | stats count by FileName 
            | fields FileName] 
        | stats count by TargetProcessId_decimal 
        | fields TargetProcessId_decimal 
        | rename TargetProcessId_decimal as ContextProcessId_decimal] 
    | rename ContextProcessId_decimal AS TargetProcessId_decimal 
    | fields aid TargetProcessId_decimal RemoteAddressIP4] 
| table _time ComputerName UserName FileName CommandLine RemoteAddressIP4