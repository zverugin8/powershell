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
[string]$mask2="$($mask1[0])" + "." + "$($mask1[1])" + "." + "$($mask1[2])" + "." + "$($mask1[3])"
#return $mask1[0..3]
return $mask2


}