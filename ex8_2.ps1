$var = $args[0]
$p = 0
$t = 1
Write-Host -NoNewline $t" "
for (;$f -le $var;$f = $p + $t)
{
$p = $t
$t = $f
Write-Host -NoNewline $f" "
}