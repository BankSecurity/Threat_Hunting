ComputerName=ComputerNameHere RpcClientProcessId_decimal=*|stats count by event_simpleName

ScheduledTaskRegistered, ScheduledTaskDeleted, FirewallSetRule, FirewallDeleteRule, FirewallChangeOption
ServiceStarted, HostedServiceStarted, ServiceStopped, HostedServiceStopped, UserAccountAddedToGroup, UserAccountCreated, UserAccountDeleted

Sample Query:  event_simpleName=UserAccountCreated OR event_simpleName=UserAccountAddedToGroup