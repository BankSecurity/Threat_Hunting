ComputerName=* event_simpleName=ProcessRollup2 OR event_simpleName=ProcessBlocked  CommandLine=*\\arp.exe* OR CommandLine="at *" OR CommandLine=*\\at.exe* OR CommandLine="bitsadmin *" OR CommandLine=*\\bitsadmin.exe* OR CommandLine="*csvde.exe *" OR CommandLine="dsquery *" OR CommandLine=*\\dsquery.exe* OR CommandLine=*\\ftp.exe* OR CommandLine=*\\makecab.exe* OR CommandLine="*nbtstat *" OR CommandLine="net *" OR CommandLine=*\\net.exe* OR CommandLine=*\\net1.exe* OR CommandLine="netsh *" OR CommandLine=*\\netsh.exe* OR CommandLine="netstat *" OR CommandLine=*\\netstat.exe* OR CommandLine="*nslookup*" OR CommandLine="ping *" OR CommandLine=*\\ping.exe* OR CommandLine=*quser.exe* OR CommandLine=*\\reg.exe* OR CommandLine=*\\regsvr32.exe* OR CommandLine="route *" OR CommandLine=*\\route.exe* OR CommandLine="sc *" OR CommandLine=*\\sc.exe* OR CommandLine="schtasks *" OR CommandLine=*\\schtasks.exe* OR CommandLine=systeminfo* OR CommandLine="taskkill *" OR CommandLine=*\\taskkill.exe* OR CommandLine="tasklist *" OR CommandLine=*\\tasklist.exe* OR CommandLine=*wevtutil* OR CommandLine="whoami*" OR CommandLine=*\\whoami.exe* OR CommandLine=*\\xcopy.exe OR CommandLine="wmic *" OR CommandLine=*\\wmic.exe* OR CommandLine="psexec *" OR CommandLine=*\\psexec.exe* OR CommandLine=*\\psexesvc.exe* OR CommandLine="powershell.exe *" OR CommandLine=*\\powershell.exe* OR CommandLine=*\\cmd.exe* OR CommandLine="cmd *" OR CommandLine="cmd.exe *" NOT CommandLine=*powershell.exe*\\CCM\\* NOT CommandLine="\"C:\\Windows\\system32\\SearchFilterHost.exe\"*" NOT CommandLine="\"C:\Windows\system32\SearchProtocolHost.exe\"*" NOT CommandLine="\"C:\\Windows\\system32\\makecab.exe\" C:\\Windows\\Logs\\CBS\\*" NOT CommandLine="\"C:\\Windows\\CCM\\*" NOT CommandLine="\\??\\C:\\Windows\\system32\\conhost.exe \"*" NOT CommandLine="rundll32 C:\\Windows\\system32\\spool\\DRIVERS\\*" NOT CommandLine="taskeng.exe \{*" NOT "microsoft monitoring agent" NOT "system center operations manager"
| stats values(ComputerName) values(UserName) count by CommandLine 
| sort by -count