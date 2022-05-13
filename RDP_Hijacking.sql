CommandLine="*cmd.exe /k tscon*" OR CommandLine=”*tscon*”
| stats dc(UserName) dc(ComputerName) count by CommandLine 
| sort + count