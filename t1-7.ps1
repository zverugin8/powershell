function test-mask_cont {
    [cmdletbinding()]
    param (
    [parameter(Mandatory=$true,
    Position=0)]
    [IPAddress]$ip8 # input mask value
    )
    #[IPAddress]$ip8="255.255.0.192"
    $dig=""
    $no_zero="1"
    [boolean]$res=$False 
    for ($a = 0; $a -le 3; $a++) 
    { $dig+=[convert]::ToString($ip8.GetAddressBytes()[$a],2)}
    for ($b = 0; $b -lt $dig.Length; $b++) {
        if ( ($dig[$b] -eq "1") -and ($no_zero -eq "1") ) {$res=$true;}
        if ( ($dig[$b] -eq "0") ) {$no_zero="0"}
        if ( ($dig[$b] -eq "1") -and ($no_zero -eq "0") ) {$res=$False;}
        #echo "dig:$($dig[$b])"
        #echo "nozero=$no_zero"
        #echo "res:$res"
    }
    
    
    #echo $dig
    #echo $dig.Length

    return $res
}