Clear-Host
$wa = Get-Content -Path .\wordchart.txt | Sort-Object 
$waf = @("A".."Z") # make abc array
foreach ($let in $waf) {
New-Item -force -ItemType File $let`.txt  #make empty files
}
foreach ($wor in $wa) {
$wor = $wor.toupper()
$pa = $wor[0] + ".txt"
$wor = $wor.ToLower()
Add-Content -Path $pa -value $wor
Write-Host  "$wor added to $pa"
}
Get-ChildItem *.txt | Where-Object {$_.Length -gt 0}