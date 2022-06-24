Install-Module -Name VMware.PowerCLI -Confirm:$false
Set-PowerCLIConfiguration -InvalidCertificateAction Ignore -Confirm:$false
Connect-VIServer 10.3.64.130 -User administrator@vs.loc -Password Admin1234!
Get-VM * | ForEach-Object {write-host $_.name " " -NoNewline; $(Get-NetworkAdapter $_.name).MacAddress}