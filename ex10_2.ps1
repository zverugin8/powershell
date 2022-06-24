[CmdletBinding()]
param()
$var1 = Get-Random(0..100) -count 10
#$var1 = @(1,2,4,3,5,6,8,7,9,10)
$f = 1
Write-Host "Было" $var1
for ($j = 1; $j -lt $var1.Count-1; $j++) { 
if ($f = 0) { break}
 for ( ($i = 0), ($f = 0) ; $i -lt $var1.Count-$j; $i++) {
if ($var1[$i] -gt $var1[$i+1]) {
$tmp = $var1[$i+1]
$var1[$i+1] = $var1[$i]
$var1[$i] = $tmp
$f = 1 #перестановка была
Write-Verbose "$var1" 

}
 
}
}
Write-Host "Стало" $var1