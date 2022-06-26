function test-mask_cidr
{
    [cmdletbinding()]
    param (
    [parameter(Mandatory=$true,
    Position=0)]
    [IPAddress]$ip9 # input mask value
    )
    #[IPAddress]$ip8="128.192.0.0"
    $res=""
    $ress1=$ip9.GetAddressBytes()[0]
    $ress2=( Compare-Object -ReferenceObject $ip9.GetAddressBytes()[1..3] -DifferenceObject @(0,0,0) )
    Write-Host "ress1 is $ress1"
    Write-Host "ress2.l is $($ress2.Length)"
    if ( ($ress1 -gt 0) -and ($ress1 -le 32) -and ($ress2.Length -eq 0) ) {$res="cidr"} 
    else {$res="mask"}
    return $res
}
    