commandhistoryv2
| search CommandHistory="*$_.CreationTime* =*"
| fields ComputerName UserName CommandHistory
| stats count by ComputerName UserName CommandHistory


commandhistoryv2
| search CommandHistory="*$_.LastWriteTime* =*"
| fields ComputerName UserName CommandHistory
| stats count by ComputerName UserName CommandHistory
