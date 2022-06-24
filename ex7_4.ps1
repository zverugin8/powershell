$str1 = $args[0]
$str2 = $str1 -split '-'
$str1 = $str2[1] +"-" + $str2[0] +"-" + $str2[2]
$str1