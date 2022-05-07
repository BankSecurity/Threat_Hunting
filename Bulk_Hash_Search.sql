index=main cid=* sourcetype IN ("ProcessRollup2*", "SyntheticProcessRollup2*")  FileName="*" ComputerName=* ( 
              [| stats count 
              | eval MD5HashData="xxxxxxxxx" 
              | makemv MD5HashData delim=" " 
              | fields MD5HashData ] OR 
              [| stats count 
              | eval SHA256HashData="xxxxxxxxx" 
              | makemv SHA256HashData delim=" " 
              | fields SHA256HashData ] ) 
          | eval FileName=lower(FileName) 
          | stats values(SHA256HashData) AS SHA256, values(FileName) AS "File Name", dc(FileName) AS "Unique File Count", count AS "# of Process Executions", dc(aid) AS "# of Hosts", earliest(ComputerName) AS "First Executed On", min(_time) AS "First Executed Date", latest(ComputerName) AS "Last Executed On", max(_time) AS "Last Executed Date" by MD5HashData 
          | fillnull value="" UserName,UserPrincipal
          | search UserName=* OR UserPrincipal=*
          | rename MD5HashData AS MD5
          `formatDate("First Executed Date")`
          `formatDate("Last Executed Date")`
          | sort 0 +"# of Computers"