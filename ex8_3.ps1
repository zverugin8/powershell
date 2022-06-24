$var = $args[0]
For ($y=1; $y -le $var;$y++){
Switch ($y) {
1 {$dy = 10.5}
2 {$dy = 10.5*2}
default {$dy = $dy + 4}
}
Write-Host -NoNewline $dy" "
}