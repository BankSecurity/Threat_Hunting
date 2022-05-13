index=main event_simpleName=FirewallSetRule cid=* ComputerName=* aid=* 
| rex field=FirewallRule "App=(?<App>(.*?))\|"
| rex field=FirewallRule "Action=(?<Action>(.*?))\|" 
| rex field=FirewallRule max_match=0 "Profile=(?<Profile>(.*?))\|" 
| rex field=FirewallRule "Protocol=(?<Protocol>(.*?))\|" 
| rex field=FirewallRule "Dir=(?<Direction>(.*?))\|" 
| rex field=FirewallRule "Name=(?<Name>(.*?))\|" 
| rex field=App "(?<FileName>[^\\\]+$)" 
| eval Protocol=case(Protocol=1, "ICMP", Protocol=6, "TCP", Protocol=17, "UDP", Protocol=58, "IPv6-ICMP") 
| search Action=Allow 
| eval ProcessID=aid."/".RpcClientProcessId_decimal 
| stats dc(aid) AS "Host Count", list(App) AS "File Path", list(Protocol) AS Protocol, list(ComputerName) AS "Host Name", list(Name) AS Name, list(Profile) AS Profile, list(ProcessID) AS "RPC Client Process ID", list(aid) AS aid by FileName, Direction 
| rename FileName AS "File Name" 
| search "Host Count"<20 
| sort 0 +"Host Count", +"File Name"
