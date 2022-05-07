event_simpleName=NetworkConnectIP4 NOT (RemoteAddressIP4=10.0.0.1/8 OR RemoteAddressIP4=127.0.0.1) AND NOT (RemotePort_decimal=443 OR RemotePort_decimal=80)
| rename ContextProcessId_decimal as TargetProcessId_decimal 
| join TargetProcessId_decimal, aid 
    [ search eventtype=eam (ProcessRollup2 OR SyntheticProcessRollup2)] 
| stats count by ImageFileName UserName RemoteAddressIP4 RemotePort_decimal 
| sort - count desc