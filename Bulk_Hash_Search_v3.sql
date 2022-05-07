eventtype=eam cid=* ((ProcessRollup2 OR SyntheticProcessRollup2) OR ImageHash) ( 
              [| stats count 
              | eval MD5HashData="xxxxxxxxxx" 
              | makemv MD5HashData delim=" " 
              | fields MD5HashData ] OR 
              [| stats count 
              | eval SHA256HashData="xxxxxxxxxx" 
              | makemv SHA256HashData delim=" " 
              | fields SHA256HashData ] ) 
          | stats values(FileName) AS "File Name", count AS Count, min(_time) AS FirstSeenDate, max(_time) AS LastSeenDate by MD5HashData, ComputerName, aid, cid
          | rename MD5HashData AS MD5, ComputerName AS "Host Name" 
          | eval "First Seen Date"=FirstSeenDate 
          | eval "Last Seen Date"=LastSeenDate 
          | eval Contain="Contain Host" 
          | table MD5, "Host Name", "File Name", Count, "First Seen Date", "Last Seen Date", FirstSeenDate, LastSeenDate, aid, Contain, cid
              `formatDate("First Seen Date")`
              `formatDate("Last Seen Date")`