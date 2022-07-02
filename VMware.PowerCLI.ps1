Install-Module -Name VMware.PowerCLI -Confirm:$false
Set-PowerCLIConfiguration -InvalidCertificateAction Ignore -Confirm:$false
Connect-VIServer 1.1.1.1 -User administrator@vs.loc -Password zzzzzz
Get-VM * | ForEach-Object {write-host $_.name " " -NoNewline; $(Get-NetworkAdapter $_.name).MacAddress}
