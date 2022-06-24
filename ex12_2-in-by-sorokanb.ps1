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
$i=0
$hash2 = @{}
#$hash2 = Foreach ($pro in $proc2.Objects.Object.childnodes ) { @{$i=@{Name = $pro.name; id = $pro.id; StartTime = "$($pro.StartTime)"; PagedMemorySize = "$($pro.PagedMemorySize)"} }; $i=$i+1 }
$hash2 = Foreach ($pro in $proc2.Objects.Object.childnodes ) {  write-host $pro.name "=" $pro."#text"; $i=$i+1; $i}
$proc2.objects.Object.childnodes.Name[0]
$proc2.objects.Object.childnodes[0]
