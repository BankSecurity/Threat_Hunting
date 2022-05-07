(event_simpleName=SuspiciousDnsRequest)
    OR 
    (event_simpleName=DnsRequest 
    DomainName=*.cc
    OR DomainName=*.ru
    OR DomainName=*.top
    OR DomainName=*.xyz
    OR DomainName=*.pw
    OR DomainName=*.stream
    OR DomainName=*.loan
    OR DomainName=*.download
    OR DomainName=*.click
    OR DomainName=*.science
    OR DomainName=*.today 
    OR DomainName=*.accountant
    OR DomainName=*.gdn
    OR DomainName=*sytes.net
    OR DomainName=*zapto.org
    OR DomainName=*hopto.org
    OR DomainName=*dynu.com
    OR DomainName=*redirectme.net
    OR DomainName=*servehttp.com
    OR DomainName=*serveftp.com
    OR DomainName=*servegame.com
    OR DomainName=*jkub.com
    OR DomainName=*itemdb.com) 
| eval timestamp=(timestamp / 1000) 
| convert timeformat="%FT%H:%M:%S.%3N UTC" ctime(timestamp) AS timestamp_readable 
| stats count by DomainName
| sort by - count