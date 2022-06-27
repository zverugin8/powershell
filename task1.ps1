[cmdletbinding()]
Param
(
  # Param0 ip Address1
  #[parameter(Mandatory=$true)]
  #[AllowNull()]
  #[AllowEmptyString()]
  #[ValidateNotNullOrEmpty()]
  [string]$IP_Address_1="-IP1 is required.",
  
  # Param1 ip Address2
  #[parameter(Mandatory=$false,
  #           Position=1)]
  [string]$IP_Address_2="-IP2 is required.",
  
  # Param2 mask or CIDR
  #[parameter(Mandatory=$false,
  #           Position=2)]
  [string]$network_mask="0"

)


function test-mask_cidr            #test mask or cidr
{
    [cmdletbinding()]
    param (
    [parameter(Mandatory=$false,
    Position=0)]
    [IPAddress]$ip9 # input mask value
    )
    #$ip9.GetAddressBytes()[0]
    #$ip9.GetAddressBytes()[1]
    #$ip9.GetAddressBytes()[2]
    #$ip9.GetAddressBytes()[3]
    $res="" #declare output var
    $ress1=$ip9.GetAddressBytes()[3] # read possible CIDR
    $ress2=( Compare-Object -ReferenceObject $ip9.GetAddressBytes()[0..2] -DifferenceObject @(0,0,0) ) # is othe 3 didgit 0? if not, result.length -ne 0
    Write-verbose "ress1 is $ress1"
    Write-Verbose "ress2.l is $($ress2.Length)"
    if ( ($ress1 -gt 0) -and ($ress1 -le 32) -and ($ress2.Length -eq 0) ) {$res="cidr"} # if 0<"4th digit"<=32 and other digits is 0, then it is CIDR 
    else {$res="mask"}
    return $res
}

function test-mask_cont {       #mask MUST be continuous, 111000 - valid, 111001 not valid. 
    [cmdletbinding()]
    param (
    [parameter(Mandatory=$true,
    Position=0)]
    [IPAddress]$ip8 # input mask value
    )
    $dig=""
    $no_zero="1" # var to check whether in string 0 been before 
    [boolean]$res=$False 
    for ($a = 0; $a -le 3; $a++) 
    { $dig+=[convert]::ToString($ip8.GetAddressBytes()[$a],2)} #convert all mask digit to binary and create one long string
    for ($b = 0; $b -lt $dig.Length; $b++) {
        if ( ($dig[$b] -eq "1") -and ($no_zero -eq "1") ) {$res=$true;} # digit zero, and no zero before
        if ( ($dig[$b] -eq "0") ) {$no_zero="0"} # digit is zero, it ok, but zero is here
        if ( ($dig[$b] -eq "1") -and ($no_zero -eq "0") ) {$res=$False;} #if digig and zero been befor... it mean mask not continuous

    }
    


    return $res
}
      
function Convert-cidr {         #convert CIDR to mask
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
[string]$mask2="$($mask1[0])" + "." + "$($mask1[1])" + "." + "$($mask1[2])" + "." + "$($mask1[3])"
#
return $mask2

}

function comp_ip                # get 2 net from both IP's and compare net_ip1 - net_ip2
{
    [cmdletbinding()]
    Param
    (
      # Param0 ip Address1
      [parameter(Mandatory=$true,
                 Position=0)]
      [IPAddress]$IP_Address_1,
      
      # Param1 ip Address2
      [parameter(Mandatory=$true,
                 Position=1)]
      [IPAddress]$IP_Address_2,
      
      # Param3 mask
      [parameter(Mandatory=$true,
                 Position=2)]
      [IPAddress]$network_mask

    )
        
          begin 
          {  
            
          }
        
        process 
        {
            
            $net1=@(0,0,0,0,0) # Declare arrays for net1, net2
            $net2=@(0,0,0,0,0)


            Write-Verbose $IP_Address_1
            Write-Verbose $IP_Address_2
            Write-Verbose $network_mask
            for ($i = 0; $i -le 3; $i++) 
            {
             $net1[$i] = $( $IP_Address_1.GetAddressBytes()[$i] -band $network_mask.GetAddressBytes()[$i] ) #logical and for ip digit to mask digit
             $net2[$i] =   $( $IP_Address_2.GetAddressBytes()[$i] -band $network_mask.GetAddressBytes()[$i] )      
             }
             Write-Output "net1 :  $($net1[0..3])"
             Write-Output "net2 :  $($net2[0..3])"
             $ress=( Compare-Object -ReferenceObject $net1[0..3] -DifferenceObject $net2[0..3] ) #compare net1 and net2
             if ( $ress.Length -eq 0 ) {Write-Output "Same subnet?-YES"} #if no compare output - same
             else {Write-Output "Same subnet?-NO"} #if compare output - different 

        }#process
        
        end 
        { 
 
        }
}

function IsValidIPv4Address ($ip) {
    return ($ip -match "^\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}$" -and [bool]($ip -as [ipaddress])) # ip must be 3 number dot separated
}                                                                                               # ip must formatted as ip addr

$a1=IsValidIPv4Address ($IP_Address_1)
$a2=IsValidIPv4Address ($IP_Address_2)
if ( (IsValidIPv4Address($network_mask)) -or (($network_mask -gt 0) -and ($network_mask -le 32)) )
{$mask_type=test-mask_cidr($network_mask)} #mask or CIDR? 
echo "mask_type:$mask_type"
if ( $mask_type -eq "cidr")  { [string]$network_mask=Convert-cidr($network_mask) ; echo "CIDR_to_mask:$network_mask" #get converted mask
}
$m1=IsValidIPv4Address ($network_mask)
if ($m1) { $mask_cont=test-mask_cont($network_mask) } # if mask valid, check continuous
echo "IP1:$a1, $IP_Address_1 "
echo "IP2:$a2, $IP_Address_2"
echo "mask:$m1, $network_mask"
echo "mask_cont?:$mask_cont"




if (  -not ($a1 -and $a2 -and $m1 -and $mask_cont) ) # if any param incorrect - output error message
{echo "ERROR: Param incorrect"}
else {$all_param=$true}

if ($all_param) {  #if all ok - begin comparison
comp_ip -IP_Address_1 $IP_Address_1 -IP_Address_2 $IP_Address_2 -network_mask $network_mask
}
