$net1= [System.Collections.ArrayList]::new()
$net2= [System.Collections.ArrayList]::new()
[IPAddress]$IP1="192.168.0.34"
[IPAddress]$IP2="192.168.0.32"
[IPAddress]$mask="255.255.255.252"
for ($i = 0; $i -le 3; $i++)
{
#Write-Host "i: $i"
#write-host "band:$($IP1.GetAddressBytes()[$i] -band $mask.GetAddressBytes()[$i] )"
#$($IP1.GetAddressBytes()[$i] -band $mask.GetAddressBytes()[$i] )
$net1.Add($($IP1.GetAddressBytes()[$i] -band $mask.GetAddressBytes()[$i] )) >null
$net2.Add($($IP2.GetAddressBytes()[$i] -band $mask.GetAddressBytes()[$i] )) >null
}

$net1
$net2

