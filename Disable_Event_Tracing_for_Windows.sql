/* https://blog.xpnsec.com/hiding-your-dotnet-complus-etwenabled/ */

commandhistoryv2
| search CommandHistory="*COMPlus_ETWEnabled=0*" OR CommandHistory="*REG ADD HKLM\Software\Microsoft\.NETFramework /v ETWEnabled /t REG_DWORD /d 0*" OR CommandHistory="*New-ItemProperty -Path HKLM:\Software\Microsoft\.NETFramework -Name ETWEnabled -Value 0 -PropertyType "DWord" -force*"
| fields ComputerName CommandHistory
| stats count by ComputerName UserName ImageFileName CommandHistory