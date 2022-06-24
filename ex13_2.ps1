#[CmdletBinding()]
#    Param()
Clear-Host
#$compname = $env:computername
#$compname = Get-NetIPAddress | ForEach-Object IPAddress | ? { $_ -match '^192' } 
$compname = 127.0.0.1
$ht = @{}
$ar1 = @()
$ar2 = @()
$logus = $(Get-CimInstance -ComputerName $compname -ClassName win32_loggedonuser)
write-output "Logged in users" 
write-output $logus
#foreach ($lo in $logus) { Write-Host $lo }
foreach ($lo in $logus) { $ht = $ht + @{$lo.Dependent.LogonId = $lo.Antecedent.name} } # write to hashtabe logonID = LogonName
$logsess = $(Get-CimInstance -Computer $compname -Class Win32_LogonSession) # get logonID and logon type
write-output "Logged in sessions"
$logsess | Select-Object LogonId, LogonType | Format-Table
$ar1 = $($logsess | Where-Object { $_.LogonType -match '[2,10]' }).logonId  # select to array ar1 only required logonID where logon type is 2 or 10
foreach ($are in $ar1) { $ar2 = $ar2 + $ht[$are] } # select logon names from hashtabe logonID = LogonName, using ar1 as hashtable index number, write names to ar2
#$ar2 = $ar2 | Select-Object -Unique # select only uniqe login
$un = $(Get-CimInstance -Computer $compname -Class Win32_Account) # got all local login names and description
#Write-output "Accounts" 
#Write-output $un.Caption
Write-output "Users logon type 2=Interactive and 10=remote information " 
foreach ($a in $ar2) { $un | Where-Object {$_.name -eq $a } }