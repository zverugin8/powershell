function test-mask1 {
    [cmdletbinding()]
    param (
    [parameter(Mandatory=$true,
    Position=0)]
    [IPAddress]$ip8 # input mask value
    )
    #[IPAddress]$ip8="128.192.0.0"
    $const_ar=@(128,192,224,240,248,252,254) #mask possible values
    [boolean]$res=$False 
    $next=1

    for ($a = 0; $a -le 3; $a++) {
        if ( $ip8.GetAddressBytes()[$a] -eq 255 ) { $res=$true }
        elseif ( $($const_ar | where {$_ -eq $ip8.GetAddressBytes()[$a]}) )
        {
        for ($b = $a+1; $b -lt $ip8.GetAddressBytes().count; $b++) 
            {
             if ( $ip8.GetAddressBytes()[$b] -ne 0 ) {$res=$false}
            } 
        }

        elseif ( $ip8.GetAddressBytes()[$a] -eq 0 )
        {
        for ($b1 = $a+1; $b1 -lt $ip8.GetAddressBytes().count; $b1++) 
            {
             if ( $ip8.GetAddressBytes()[$b1] -ne 0 ) {$res=$false}
            } 
        }
        echo "a:$($ip8.GetAddressBytes()[$a])" 
        echo "res:$res"
      
    }
     
    Write-Verbose "a is $a; res is $res ; next is $next"
    return $res
}