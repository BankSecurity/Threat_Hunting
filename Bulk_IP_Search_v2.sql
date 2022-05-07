index=main event_simpleName=NetworkConnectIP4 cid=* (TERM(""))
          | search LocalAddressIP4 IN (*) AND aip IN (*) AND RemoteAddressIP4 IN (*)
          | stats values(ComputerName) AS "Host Name", count AS Count, dc(ComputerName) AS "# of Hosts", last(ComputerName) AS "First Connection", min(_time) AS "First Connect Date", latest(ComputerName) AS "Last Connection", max(_time) AS "Last Connect Date", values(LocalAddressIP4) AS "Source IP", values(aip) AS "External IP" by RemoteAddressIP4  
          | convert ctime("First Connect Date") 
          | convert ctime("Last Connect Date") 
          | table "Source IP", RemoteAddressIP4, "External IP", "Host Name", "# of Hosts", "First Connection", "First Connect Date", "Last Connection", "Last Connect Date" 
          | rename RemoteAddressIP4 AS "Destination IP"