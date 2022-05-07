index=main event_simpleName=UserLogonFailed2 cid=* UserName=* event_platform IN (*) LogonType_decimal IN (2,5,10,11,12) earliest=-604801s
            | lookup aid_master.csv aid OUTPUT HostHiddenStatus
            `hideHiddenHosts()`
            | eval LogonTime_decimal=if(len(ContextTimeStamp_decimal)=18, round(ContextTimeStamp_decimal/10000000-11644473600), ContextTimeStamp_decimal) 
            | fillnull value=NULL UserLogonFlags_decimal 
            | eval UserName=upper(UserName) 
            | eval Status = if(Status_decimal==0, SubStatus_decimal, Status_decimal) 
            | eval match = case(isnotnull(LogonDomain) AND event_platform="Win", LogonDomain + "\\" + UserName, isnull(LogonDomain) AND event_platform="Win", ComputerName + "\\" + UserName, event_platform="Mac", UserPrincipal) 
            | lookup win_status_codes.csv Status_code_decimal AS Status OUTPUT Description as Status
            | eval Status=if(event_platform="Mac" AND Status_decimal=1 AND SubStatus_decimal=9, "Invalid password entered", Status)
            | bucket _time span=1m 
            | stats values(match) as match values(ClientComputerName) as ClientComputerName values(LogonDomain) as LogonDomain values(RemoteAddressIP4) as RemoteAddressIP4 values(Status) as Status values(LogonType_decimal) as LogonType_decimal count(eval(event_simpleName=="UserLogonFailed2")) AS Count, latest(UserLogonFlags_decimal) AS UserLogonFlags_decimal, max(LogonTime_decimal) AS FailedLogonAttempt by cid, UserName, ComputerName, _time
            | lookup userinfo.csv User AS match cid OUTPUT UserSid_readable, LogonTime AS LastSuccessfulLogon, PasswordLastSet, AccountType, LastLoggedOnHost, LocalAdminAccess
            | fillnull value="NOT FOUND" AccountType, LocalAdminAccess
            | search AccountType IN ("*") LocalAdminAccess IN (*)
            | eval monthsincereset=round((now()-(PasswordLastSet))/86400/30,0) 
            | eval LastSuccessfulLogon=if(LastSuccessfulLogon=0,"NA",LastSuccessfulLogon) 
            | lookup cid_name cid OUTPUT name 
            | stats values(AccountType) as "Account Type" values(ClientComputerName) as "Remote Source Host" values(LogonDomain) as "Logon Domain" values(RemoteAddressIP4) as "Remote Source IP" values(Status) as Description values(LogonType_decimal) as "Logon Type" max(Count) AS Count, max(FailedLogonAttempt) AS FailedLogonAttempt, values(PasswordLastSet) AS PasswordLastSet_decimal, max(LastSuccessfulLogon) AS LastSuccessfulLogon, latest(LastLoggedOnHost) AS "Last Logged On Host", values(name) AS Company values(UserSid_readable) as UserSid_readable values(LocalAdminAccess) as "Local Admin" by  UserName, ComputerName 
            | eval SuspiciousAttempt=if(Count>3,"Yes","No") 
            | eval fStart=FailedLogonAttempt-3600 
            | eval fEnd=FailedLogonAttempt+3600 
            | sort 0 -Count 
            | rename ComputerName AS "Host Name", UserName AS "User Name", FailedLogonAttempt AS "Last Failed Logon Attempt", LastSuccessfulLogon AS "Last Successful Logon", PasswordLastSet_decimal AS "Password Last Set", Count AS "Max Failed Logons Per Min", SuspiciousAttempt AS "Suspicious Attempt?" 
                `formatDate("Password Last Set")`
                `formatDate("Last Failed Logon Attempt")`
                `formatDate("Last Successful Logon")`
