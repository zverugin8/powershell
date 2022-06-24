$var = $args[0]
For ($i=1; $i -le 10 ;$i++){
$res = $var * $i
Write-Host $var "x" $i "="$res
}