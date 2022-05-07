index=main event_simpleName=ScheduledTaskRegistered ComputerName=* aid=* cid=*
              | spath input=TaskXml output=Trigger path=Task.Triggers
              | rex field=Trigger "<(?P<trigger>[^\s]+)>"
              | spath input=TaskXml output=Hidden path=Task.Settings.Hidden
              | spath input=TaskXml output=UserSid_readable path=Task.Principals.Principal.UserId
              | rex field=TaskExecCommand "(?<FileName>[^\\\]+$)"
              | eval ProcessID=aid."/".RpcClientProcessId_decimal
              | fillnull value=NA RpcClientProcessId_decimal
              | stats list(TaskAuthor) AS "Task Author", list(ProcessID) AS "Registered By", list(_time) AS "Time (UTC)", values(ComputerName) AS "Host Name", list(TaskExecCommand) AS "Task Command", list(TaskExecArguments) AS "Exec Arguments", list(TaskName) AS "Task Name" by cid, FileName, aid, RpcClientProcessId_decimal
              | fieldformat "Time (UTC)"=strftime('Time (UTC)', "%Y-%m-%d %H:%M.%S")
              | lookup cid_name cid OUTPUT name 
              | rename FileName AS "File Name", RpcClientProcessId_decimal AS TargetProcessId_decimal, name AS Company
              | join type=outer aid, TargetProcessId_decimal
                [ search index=main event_simpleName=ProcessRollup2 ComputerName=* aid=* cid=*
                  [ search index=main event_simpleName=ScheduledTaskRegistered ComputerName=* aid=* cid=*
                  | stats count by aid, RpcClientProcessId_decimal
                  | rename RpcClientProcessId_decimal AS TargetProcessId_decimal
                  | fields aid, TargetProcessId_decimal ]
                | stats count by aid, TargetProcessId_decimal, UserName
                |  rename UserName AS "User Name" ]
              | fillnull "Task Author" value="Unknown"