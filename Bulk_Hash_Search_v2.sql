index=main eventtype=eam cid=* sourcetype IN ("ProcessRollup2*", "SyntheticProcessRollup2*") * * ( 
              [| stats count 
              | eval MD5HashData="xxxxxxxxx" 
              | makemv MD5HashData delim=" " 
              | fields MD5HashData ] OR  
              [| stats count 
              | eval SHA256HashData="xxxxxxxxx" 
              | makemv SHA256HashData delim=" " 
              | fields SHA256HashData ] )
              | search CommandLine="*" FileName="*" ComputerName=* 
                  NOT FileName IN (NONE)
                  NOT CommandLine IN (NONE)
              | fillnull value="" UserName,UserPrincipal
              | search UserName=* OR UserPrincipal=*
              | eval User=if(event_platform="Mac",upper(UserPrincipal),upper(UserName)) 
              | eval FileName=lower(FileName)
              | rename TargetProcessId_decimal AS "Process ID", FileName AS "File Name", CommandLine AS "Command Line", RawProcessId_decimal AS PID, UserName AS "User Name", MD5HashData AS MD5 
              | eval Timestamp=_time 
              | eval fStart=Timestamp-600 
              | eval fEnd=Timestamp+600 
              `formatDate(Timestamp)`
              | table fStart, fEnd, Timestamp, ComputerName, "User Name", "File Name", PID, "Process ID", "Command Line", MD5, aid, cid
              | rename ComputerName AS "Host Name", Timestamp AS "Time (UTC)"