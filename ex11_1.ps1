#Set-Location F:\work\Kurs\PowerShell\
Clear-Host
$txh = @{} # make null hashtable
$tx = $( foreach ($line in Get-Content .\ex.txt) { 
    $line.tolower() -split '\W'
  }) | Sort-Object | Get-Unique # make uniq word array

foreach ($txw in $tx) {
$txh = $txh + @{$txw = ($txw).Length} #make hashtable word = length
}
New-Item -ItemType File -Force -Path .\wordchart.txt 
$txh1 = $txh.getenumerator() | Sort-Object -Property Value | Select-Object $_.name -Last 10 #make sorted hashtable last 10 ones (largest)
foreach ($txw in $txh1.Name) {
  Add-Content -Path .\wordchart.txt -Value $txw #add name (word) to file
}
cat -Path .\wordchart.txt