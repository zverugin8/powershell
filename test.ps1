$var = $args[0]
$var_d = Get-ChildItem $var
$var_l = $var_d.Length
$var_d[$var_l-1]