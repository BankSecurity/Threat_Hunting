eventtype=eam (ProcessRollup2 OR SyntheticProcessRollup2) cid=*
                [ search eventtype=eam (DnsRequest OR SuspiciousDnsRequest) cid=*
                    [| stats count
                    | eval DomainName="xxxxxxxxxxxx"
                    | makemv DomainName delim=" "
                    | fields DomainName ]
                | eval DomainName=lower(DomainName)
                | rename ContextProcessId_decimal AS TargetProcessId_decimal
                | table aid, TargetProcessId_decimal ]
            | join TargetProcessId_decimal, aid
                [ search eventtype=eam (DnsRequest OR SuspiciousDnsRequest) cid=*
                    [| stats count
                    | eval DomainName="xxxxxxxxxxxx"
                    | makemv DomainName delim=" "
                    | fields DomainName ]
                | eval DomainName=lower(DomainName)
                | rename ContextProcessId_decimal AS TargetProcessId_decimal
                | table DomainName, aid, TargetProcessId_decimal ]
            | stats values(ComputerName) AS "Host Name", values(UserName) AS "User Name", values(ParentProcessId_decimal) AS "Parent Process ID", values(RawProcessId_decimal) AS PID, values(MD5HashData) AS MD5, max(_time) AS TimeUTC by DomainName, FileName, SHA256HashData, TargetProcessId_decimal, aid, cid
            | eval "Process Explorer"="View"
            | eval Contain="Contain Host"
            | eval fStart=TimeUTC-3600
            | eval fEnd=TimeUTC+3600
            | table TimeUTC, DomainName, "Host Name", "User Name", "Parent Process ID", PID, TargetProcessId_decimal, FileName, MD5, SHA256HashData, aid,  "Process Explorer", Contain, fStart, fEnd, cid
            | rename SHA256HashData AS SHA256, TargetProcessId_decimal AS "Process ID", FileName AS "File Name", DomainName AS "Domain Name", TimeUTC AS "Process Start Time (UTC)"
            | sort 0 -"Process Start Time (UTC)"
            | fieldformat "Process Start Time (UTC)"=strftime('Process Start Time (UTC)', "%Y-%m-%d %H:%M.%S")