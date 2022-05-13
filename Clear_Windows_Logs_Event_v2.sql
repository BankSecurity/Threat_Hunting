commandhistoryv2
| search CommandHistory="*Clear-EventLog*"
| fields ComputerName UserName CommandHistory
| stats count by ComputerName UserName CommandHistory