index=main event_simpleName=SensorHeartbeat ComputerName IN (xxxxxxxxx) cid="*"
            | lookup aid_master.csv ComputerName OUTPUT ComputerName AS "Host Name", aid, Version, AgentVersion, FirstSeen
            | stats latest(aid) as aid, values(Version) as Version, latest(AgentVersion) as "Agent Version", latest(FirstSeen) as "First Seen" by "Host Name"
            `formatDate("First Seen")`
            | sort "Host Name"