/* Search for all relevant Logon activities for a specific UserName */

| inputlookup userinfo.csv where cid=*
            | search UserName=* AccountType="*" LocalAdminAccess=* (LogonType="*")
            | eval LogonDomain=upper(mvindex(split(User,"\\"),0))
            | where now()-LogonTime<604800
            | eval monthsincereset=if(PasswordLastSet=0,"NA",monthsincereset)
            | eval PasswordLastSet=if(PasswordLastSet=0,"NA",PasswordLastSet)
            | table cid, User, UserName, UserSid_readable, LogonDomain, AccountType, LocalAdminAccess, LogonType, LastLoggedOnHost, LogonTime, PasswordLastSet, monthsincereset
            | rename LogonDomain AS "Logon Domain", AccountType AS "Account Type", LocalAdminAccess AS "Local Admin Privileges", LogonType AS "Logon Type", LastLoggedOnHost AS "Logged On Host", LogonTime AS "Logon Time", PasswordLastSet AS "Password Last Set", monthsincereset AS "Months since Password Last Set", UserName AS "User Name"
            | lookup cid_name cid OUTPUT name
            | eval fStart=now()-604800
            | sort 0 -"User Name"
            | rename name AS Company
            `formatDate("Logon Time")`
            `formatDate("Password Last Set")`