$proc  = Get-Content .\ex12_1.csv
#$hash = foreach ($pro in $proc) { @{ $proc.indexof($pro)=@{Name = "$pro.name"; id = $pro.id; Path = "$($pro.path)"} }  }