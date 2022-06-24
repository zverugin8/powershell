$compname = $env:computername
write-host "CPU model: "$(Get-CimInstance -Computer $compname -Class win32_Processor).Name
write-host "Max clock speed: "$(Get-CimInstance -Computer $compname -Class win32_Processor).MaxClockSpeed
Write-host "Amount of RAM, total/GB: " $((Get-CimInstance -Computer $compname -Class Win32_PhysicalMemory | Measure-Object -Property capacity -Sum).sum /1gb)
write-host "Amount of RAM, free/GB: " $((Get-CimInstance -Computer $compname -Class Win32_OperatingSystem).FreePhysicalMemory/1gb)
write-host "OS disk free space: "
foreach ($a in $(Get-CimInstance -Computer $compname -Class Win32_LogicalDisk)) { write-host  $a.DeviceID " : "(($a.FreeSpace/1gb) -as [int]) " GB" }
write-host "OS version is: "$(Get-CimInstance -Computer $compname -Class win32_OperatingSystem).caption
write-host "Installed hot fixes: " 
$(Get-CimInstance -Computer $compname -Class Win32_QuickFixEngineering )
write-host "List of stopped services: "
Get-CimInstance -Computer $compname -Class CIM_Service | Where-Object {$_.State -match "Stopped"} | Format-Wide -AutoSize
