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
    
    if ( ($a -eq 255) -and ($next -eq 0) )                            { $res=$true } # is digit 255? - then ok
    elseif ( $($const_ar | where {$_ -eq $a}) -and ($next -eq 0) )  { $res=$true; $next=1; } # is digit in arr? - yes, but next digit must be zero
    elseif ( ($a -eq 0) -and ($next -eq 1) )                        { $res=$false; $next=1}
    elseif ( ($a -ne 0) -and ($next -eq 1) )                        { $res=$false; $next=1} # is digit not zero? = incorrect mask
    echo "a:$a" 
    echo "res:$res"
    echo "next:$next"  
    Write-Verbose "a is $a; res is $res ; next is $next"
    }
    return $res
}   