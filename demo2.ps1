[string[]]$str = @("a", "b", "c", "d", "e", "f")
$str1 = [System.String]::new($str, 0, $str.Length)
$str1
[string[]]$str2 = @("one", "two", "three")
[System.String]::Join("zve", $str, $str1)
