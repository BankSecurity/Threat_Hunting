IsOnRemovableDisk_decimal=1 event_simpleName=*Written UserName="*"
| fields ComputerName UserName TargetFileName 
| cluster field=TargetFileName labelonly=t t=0.6
| stats values(ComputerName) values(UserName) values(TargetFileName) by cluster_label
| rename values(*) as *