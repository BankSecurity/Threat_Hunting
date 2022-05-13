CommandLine="*vssadmin.exe delete shadows /all /quiet*" OR CommandLine=”*Get-WmiObject Win32_Shadowcopy*” OR CommandLine=”*wbadmin.exe delete catalog*” OR CommandLine=”*wmic.exe shadowcopy delete*”
| stats dc(UserName) dc(ComputerName) count by CommandLine 
| sort + count