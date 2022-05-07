index=main event_platform="Win" event_simpleName IN (ProcessRollup2,SyntheticProcessRollup2) FileName IN ("powershell*","pwsh*")  *
          | eval Exec=if(match(lower(CommandLine),"invoke[-\(][^wn][^me][^io]") OR match(lower(CommandLine), "(icm|iex)[ \(|]") OR match(lower(CommandLine), "[^r][^e]start-(service|process)"),4,0)
          | eval Dwnld=if(match(lower(CommandLine),"https?://") OR match(lower(CommandLine),"web(client|request)") OR match(lower(CommandLine),"sockets") OR match(lower(CommandLine),"download(file|string)") OR match(lower(CommandLine),"bitstransfer"),4,0)
          | eval Upld=if(match(lower(CommandLine),"uploadfile"),4,0)
          | eval Encode=if(match(lower(CommandLine),"[A-Za-z0-9+\/]{44,}([A-Za-z0-9+\/]{4}|[A-Za-z0-9+\/]{3}=|[A-Za-z0-9+\/]{2}==)") OR match(lower(CommandLine),"frombase64string"),5,0)
          | eval ExecPol=if(match(lower(CommandLine),"bypass") OR match(lower(CommandLine),"unrestricted"),1,0)
          | eval NonI=if(match(lower(CommandLine),"-noni"),1,0)
          | eval NoProf=if(match(lower(CommandLine),"-nop"),1,0)
          | eval Hidden=if(match(lower(CommandLine)," hidden") OR match(lower(CommandLine),"-windowstyle") OR match(lower(CommandLine), "-nonewwindow"),1,0)
          | eval Domain=if(match(lower(CommandLine),"add-ad") OR match(lower(CommandLine),"get-ad"),3,0)
          | eval VM=if(match(lower(CommandLine),"vbox") OR match(lower(CommandLine),"prl_") OR match(lower(CommandLine),"vm(tool|ware)") OR match(lower(CommandLine),"vmu*srvc"),3,0)
          | eval Prxy=if(match(lower(CommandLine),"proxy"),4,0)
          | eval obf1=if(match(lower(CommandLine),"join[^-]") OR match(lower(CommandLine),"\[char\][^3][^4]") OR match(lower(CommandLine),"reverse") OR match(lower(CommandLine),"BXOR"),4,0)
          | eval NewCommand = CommandLine
          | rex field=NewCommand mode=sed "s/`[0abfnrtv#$\"]//g"
          | eval numTicks = mvcount(split(NewCommand,"`"))-1
          | eval numPluses = mvcount(split(NewCommand,"+"))-1
          | eval obf2 = if(numTicks > 5 OR numPluses > 5,4,0)
          | addtotals fieldname=Score Exec Dwnld Upld Encode ExecPol NonI NoProf Hidden Domain VM Prxy obf1 obf2
          | stats values(_time) AS Timestamp, values(UserName) AS "User Name", values(ParentProcessId_decimal) AS "Parent Process ID", values(RawProcessId_decimal) AS PID, values(Score) AS Score, values(Exec) AS Exec, values(Dwnld) AS Dwnld, values(Encode) AS Encode, values(ExecPol) AS ExecPol, values(NonI) AS NonI, values(NoProf) AS NoProf, values(Hidden) AS Hidden, values(Domain) AS Domain, values(Prxy) AS Prxy, values(VM) AS VM, values(obf1) AS obf1, values(obf2) AS obf2, values(CommandLine) AS "Command Line", values(aid) AS aid by ComputerName, TargetProcessId_decimal, cid
          | eval fStart=Timestamp-3600
          | eval fEnd=Timestamp+3600
          | rename TargetProcessId_decimal AS "Process ID", ComputerName AS "Host Name", Timestamp AS "Time (UTC)"
          | fieldformat "Time (UTC)"=strftime('Time (UTC)', "%Y-%m-%d %H:%M.%S")
          | sort 0 -Score, -"Time (UTC)"