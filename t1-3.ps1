function Convert-cidr {
    [cmdletbinding()]
    param 
    (
    [parameter(Mandatory=$true,
    Position=0)]
    $cidr
    )
    

#$mask1=@()
$mask1=@(0,0,0,0,0)
#[math]::Pow(2,8)
$rest=0
$raz=([math]::DivRem($cidr,8,[ref]$rest))
#$rest

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