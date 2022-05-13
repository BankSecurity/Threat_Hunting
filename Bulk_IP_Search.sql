index=main event_simpleName=NetworkConnectIP4 cid=* [ | stats count | eval RemoteAddressIP4="*" | makemv RemoteAddressIP4 delim=" " | fields RemoteAddressIP4 ] 
| stats values(ComputerName) AS "Host Name", count AS Count, dc(ComputerName) AS "# of Hosts", last(ComputerName) AS "First Connection", min(_time) AS "First Connect Date", latest(ComputerName) AS "Last Connection", max(_time) AS "Last Connect Date" by RemoteAddressIP4 
| convert ctime("First Connect Date") | convert ctime("Last Connect Date") 
| table RemoteAddressIP4, "Host Name", "# of Hosts", "First Connection", "First Connect Date", "Last Connection", "Last Connect Date" 
| rename RemoteAddressIP4 AS "Destination IP"
