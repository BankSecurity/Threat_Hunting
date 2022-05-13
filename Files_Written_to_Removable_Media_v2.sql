index=main eventtype=eam event_simpleName IN (*FileWritten, ExecutableRenamed,FsPostOpen,FileRenamed,NewScriptWritten) ComputerName=* aid=* FileName=* cid=* [ search index=main eventtype=eam event_simpleName=RemovableMediaVolumeMounted ComputerName=* aid=* cid=* earliest=-24h@h latest=now | stats count by aid, VolumeName | eval FilePath=VolumeName."*" | fields aid FilePath ] 
| rex field=event_simpleName mode=sed "s/([A-Z]+)/ \1/g s/_//g" 
| eval event_simpleName=trim(event_simpleName) 
| eval FileType=case(isnotnull(event_simpleName),'event_simpleName',event1=1,"unknown") 
| table FileType, ComputerName, FileName, TargetFileName, timestamp 
| eval "Time (UTC)"=timestamp/1000 
| rename ComputerName AS "Host Name", FileName AS "File Name", TargetFileName AS "Full Path", FileType AS "Action" 
| sort 0 -"Time (UTC)" 
| convert ctime("Time (UTC)")
