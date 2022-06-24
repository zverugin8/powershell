$str1 = "xyaabbbccccdefww"
$str2 = "xxxxyyyyabklmopq"
$str12 = [System.String]::Join($str1,$str2,$null)
[char[]]$str21 = $str12.ToCharArray()
$str22 = ( $str21 | sort -Unique)
$str3 = [System.String]::Join($null, $str22)
$str3
