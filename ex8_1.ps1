$var = $args[0]
$sw = $var[-1]
#$sw
$len = $var.length
#$len
$num = $var.remove($len-1)
$num = [int]$num
#$num
Switch ($sw)
{
F { [int]$num = ($num-32)*(5/9)
 write-host "$var is $num in Fahrenheit"
}
C { [int]$num = $num*(9/5)+32
write-host "$var is $num in Celsius"
}
}