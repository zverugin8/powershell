function test-mask {
    [cmdletbinding()]
    param (
    [parameter(Mandatory=$true,
    Position=0)]
    [IPAddress]$ip8 # input mask value
    )
    #[IPAddress]$ip8="128.192.0.0"
    $const_ar=@(128,192,224,240,248,252,254) #mask possible values
    [boolean]$res=$False 
    $next=0

    foreach ($a in $ip8.GetAddressBytes() )
    {
    
    if ( $a -eq 255 )                            { $res=$true } # is digit 255? - then ok
    elseif ( $($const_ar | where {$_ -eq $a}) -and ($next -eq 0) )  { $res=$true; $next=1 } # is digit in arr? - ok, but nex must be zero
    elseif ( $a -ne 0 )                          { $res=$False; $next=1} # is digit not zero? = incorrect mask 
    Write-Verbose "a is $a; res is $res ; next is $next"
    }
    return $res
}   