index=discover_summary report=sha256_hostusage cid=* "**" "Tor Browser*" "**" "*" ComputerName=* earliest=-7d@d
            | fillnull value="NA" CompanyName ProductName ProductVersion FileName UserName event_platform
            | search CompanyName="**" ProductName="Tor Browser*" ProductVersion="**" FileName IN (*) UserName="*" event_platform IN (*)
            | lookup aid_master.csv aid OUTPUT ProductType, SystemProductName, HostHiddenStatus
            `hideHiddenHosts()`       
            | search ProductType=*
            | lookup cid_name cid OUTPUT name
            | stats max(_time) AS "Last Used", values(ProductVersion) AS "Application Version", values(UserName) as User, values(FileName) AS "File Name", values(SHA256HashData) AS SHA256, values(name) AS Company by ComputerName, CompanyName, ProductName
            | rename ComputerName AS "Host Name", CompanyName AS "Vendor", ProductName AS Application
            | sort 0 +CompanyName,Application,"Application Version"
            | eval "Last Used"=strftime('Last Used', "%Y-%m-%d %H:%M.%S")