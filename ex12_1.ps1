New-Item -Path .\ex12_1.csv -Force
Get-Process -Name "chrome" | Select-Object -Property Name, Id, StartTime, PagedMemorySize | ConvertTo-Csv | add-Content -Path .\ex12_1.csv
Get-Content .\ex12_1.csv
Pause
New-Item -Path .\ex12_1.json -Force
Get-Process -Name "chrome" | Select-Object -Property Name, Id, StartTime, PagedMemorySize | ConvertTo-Json | add-Content -Path .\ex12_1.json
Get-Content .\ex12_1.json
Pause
New-Item -Path .\ex12_1.xml -Force
$proc2 = Get-Process -Name "chrome" | Select-Object -Property Name, Id, StartTime, PagedMemorySize
#$htd = foreach ($pro in $proc) { @{ $proc.IndexOf($pro) = @{Name = $pro.name; id = $pro.id; StartTime = "$($pro.StartTime)"; PagedMemorySize = "$($pro.PagedMemorySize)"} } } 
$xml = [xml]$( $proc2 | ConvertTo-Xml )
$xml.Save( $( Resolve-Path ./ ).path + "\ex12_1.xml" )
Get-Content .\ex12_1.xml
Pause
#$proc = Get-Process -Name "chrome" | Select-Object -Property Name, Id, StartTime, PagedMemorySize
$proc = Get-Process -Name "chrome"
$htd = foreach ($pro in $proc) { @{ $proc.IndexOf($pro) = @{Name = $pro.name; id = $pro.id; StartTime = "$($pro.StartTime)"; PagedMemorySize = "$($pro.PagedMemorySize)"} } } 
ConvertTo-Yaml -Data $htd -OutFile $( $( Resolve-Path ./ ).path + "\ex12_1.yaml" ) -Force
Get-Content .\ex12_1.yaml