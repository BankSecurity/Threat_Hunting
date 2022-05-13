CommandLine="*dir "%userprofile%\AppData\Roaming\Microsoft\Windows\Recent\*” OR CommandLine=”*dir ‘%systemdrive%\Users\*.*’ >> %temp%\*” OR CommandLine="*ls -recurse*" OR CommandLine=”*get-childitem –recurse*” OR CommandLine=”*gci –recurse*”
| stats dc(UserName) dc(ComputerName) count by CommandLine 
| sort + count