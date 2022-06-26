function test-mask_cidr
{
    [cmdletbinding()]
    param (
    [parameter(Mandatory=$true,
    Position=0)]
    [IPAddress]$ip9 # input mask value
    )
    $ip9.GetAddressBytes()[0]
    $ip9.GetAddressBytes()[1]
    $ip9.GetAddressBytes()[2]
    $ip9.GetAddressBytes()[3]
    $res=""
    $ress1=$ip9.GetAddressBytes()[3]
    $ress2=( Compare-Object -ReferenceObject $ip9.GetAddressBytes()[0..2] -DifferenceObject @(0,0,0) )
    Write-verbose "ress1 is $ress1"
    Write-Verbose "ress2.l is $($ress2.Length)"
    if ( ($ress1 -gt 0) -and ($ress1 -le 32) -and ($ress2.Length -eq 0) ) {$res="cidr"} 
    else {$res="mask"}
    return $res
}
    