[IPAddress]$ip8="255.255.255.24"
$const_ar=@(128,192,224,240,248,252,254,255)
$nmask=0
foreach ($a in $ip8.GetAddressBytes() ) 
{
    #if ( $const_ar -contains $a )
    $const_ar | where {$_ -eq $a} #| select -First 1 | %{Write-Host "$a is in array"

    #Write-Host "$a is not in array"
}
 #   Write-host $a
 #   for ($i = 0; $i -le 7 ; $i++) {
 #    $nmask+=( [math]::pow( 2,(7-$i) ) )
 #    write-host $nmask
 #    }
#}
