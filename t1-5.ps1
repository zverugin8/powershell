function test-mask {
    [cmdletbinding()]
    param (
    [parameter(Mandatory=$true,
    Position=0)]
    [IPAddress]$ip9 # input mask value
    )
    #[IPAddress]$ip8="128.192.0.0"
    $res="" 
    
    
    if ( ($a -gt 0) -and ($a -le 32) 
       -and    
       )                            
    
    
    
    { $res=$true } # is digit 255? - then ok
    elseif ( $($const_ar | where {$_ -eq $a}) -and ($next -eq 0) )  { $res=$true; $next=1 } # is digit in arr? - yes, but next digit must be zero
    elseif ( $a -ne 0 )                          { $res=$False; $next=1} # is digit not zero? = incorrect mask 
    Write-Verbose "a is $a; res is $res ; next is $next"
    }
    return $res