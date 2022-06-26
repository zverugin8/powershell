[cmdletbinding()]
Param
(
  # Param1 help description
  [parameter(Mandatory=$true,
             Position=0)]
  [string]$IP_Address_1,
  
  # Param2 help description
  [parameter(Mandatory=$true,
             Position=1)]
  [string]$IP_Address_2,
  
  # Param3 help description
  [parameter(Mandatory=$true,
             Position=2)]
  [string]$network_mask

)


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
      
function Convert-cidr {
    [cmdletbinding()]
    param 
    (
    [parameter(Mandatory=$true,
    Position=0)]
    $cidr
    )
    

$mask1=@(0,0,0,0,0)
$rest=0
$raz=([math]::DivRem($cidr,8,[ref]$rest))

for ($i=0 ; $i -lt $raz ; $i++ )
{
$mask1[$i]=255
}
for ($j=0; $j -lt $rest ; $j++ )
{
$mask1[$i]+=([math]::Pow(2,(7-$j)))
#$mask1[$i]
}
return $mask1[0..3]

}

function comp_ip 
{
    [cmdletbinding()]
    Param
    (
      # Param1 help description
      [parameter(Mandatory=$true,
                 Position=0)]
      [IPAddress]$IP_Address_1,
      
      # Param2 help description
      [parameter(Mandatory=$true,
                 Position=1)]
      [IPAddress]$IP_Address_2,
      
      # Param3 help description
      [parameter(Mandatory=$true,
                 Position=2)]
      [IPAddress]$network_mask

    )
        
          begin 
          {  
            
          }
        
        process 
        {
            #$mask1=@()
            $net1=@(0,0,0,0,0)
            $net2=@(0,0,0,0,0)


            Write-Verbose $IP_Address_1
            Write-Verbose $IP_Address_2
            Write-Verbose $network_mask
            for ($i = 0; $i -le 3; $i++) 
            {
             $net1[$i] = $( $IP_Address_1.GetAddressBytes()[$i] -band $network_mask.GetAddressBytes()[$i] )
             $net2[$i] =   $( $IP_Address_2.GetAddressBytes()[$i] -band $network_mask.GetAddressBytes()[$i] )      
             }
             Write-Verbose "net1 :  $($net1[0..3])"
             Write-Verbose "net2 :  $($net2[0..3])"
             $ress=( Compare-Object -ReferenceObject $net1[0..3] -DifferenceObject $net2[0..3] )
             if ( $ress.Length -eq 0 ) {Write-Output "YES"}
             else {Write-Output "NO"}

        }#process
        
        end 
        { 
            #Set-Location -Path $old_loc 
        }
}

function IsValidIPv4Address ($ip) {
    return ($ip -match "^\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}$" -and [bool]($ip -as [ipaddress])) #GodBless stackoverflow
}
$a1=IsValidIPv4Address ($IP_Address_1)
$a2=IsValidIPv4Address ($IP_Address_2)
$m1=IsValidIPv4Address ($network_mask)
$mask_cont=test-mask($network_mask)

echo "a1:$a1"
echo "a2:$a2"
echo "m1:$m1"
echo "mask_cont:$mask_cont"


comp_ip -IP_Address_1 $IP_Address_1 -IP_Address_2 $IP_Address_2 -network_mask $network_mask