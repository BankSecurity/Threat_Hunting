/* Search for all relevant events for a specific UserName */

index=discover_summary report=user_logon ComputerName="*" cid="*" LogonDomain="*" UserName="*" (LogonType=Interactive OR LogonType="Cached Credentials" OR LogonType="Auditing" OR LogonType="Terminal Server" OR LogonType=Service)
            | lookup aid_master.csv aid OUTPUT HostHiddenStatus, event_platform
            | search event_platform IN (*)
            `hideHiddenHosts()`
            | timechart span=1d dc(aid) AS "Host Count", dc(LogonTime) AS "Logon Sessions"
