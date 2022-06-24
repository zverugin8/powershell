$str1 = $args[0]
$str1 = $str1 -split ('\s|\(|\)')
$str1 -match '\w{6}'
