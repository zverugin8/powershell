Write-Host "convert from xml"
$proc2  = [xml]$(Get-Content .\ex12_1.xml)
$hash2 = @{}
for ($i = 0; $i -lt $proc2.Objects.Object.Length ; $i++) {
    $ht1 = @{}
    foreach ($pro2 in $proc2.Objects.Object[$i].Property) { $ht1 = $ht1 + @{$pro2.name = ($pro2."#text")} } 
    $hash2 = $hash2 + @{$i = $ht1}  
}
Write-host "Hash-table2 index 0 is"
$hash2[0]