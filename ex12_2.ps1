Write-Host "convert from CSV"
$proc  = Get-Content .\ex12_1.csv
$proc = ConvertFrom-Csv -InputObject $proc
$hash = foreach ($pro in $proc) { @{ $proc.indexof($pro)=@{Name = $pro.name; id = $pro.id; StartTime = "$($pro.StartTime)"; PagedMemorySize = "$($pro.PagedMemorySize)"} }  }
write-host "Hash-table value index 0 is" 
$hash[0].Values
Pause
Write-Host "convert from json"
$proc1  = Get-Content .\ex12_1.json
$proc1 = $proc1.GetEnumerator() | ConvertFrom-Json
$hash1 = foreach ($pro in $proc1) { @{ $proc1.indexof($pro)=@{Name = $pro.name; id = $pro.id; StartTime = "$($pro.StartTime)"; PagedMemorySize = "$($pro.PagedMemorySize)"} }  }
write-host "Hash-table1 value index 0 is" 
$hash1[0].Values
Pause
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
Pause
Write-Host "convert from yaml"
$hash3 = @{}
$hash3  = ConvertFrom-Yaml -Yaml $( $(Get-Content .\ex12_1.yaml) -join "`n" )
write-host "Hash-table3 value index 0 is"
$hash3[0].Values