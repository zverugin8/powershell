Get-ChildItem $args[0] | Where-Object Mode -ne "-a---" | Select-Object Mode,LastWriteTime,@{Name="Length(MB)";expression = {"                    "} },Name | Format-Table 
Get-ChildItem $args[0] | Where-Object Mode -eq "-a---" | Select-Object Mode,LastWriteTime,@{Name="Length(MB)"; expression = {$_.Length/1MB}},Name | Format-Table  -HideTableHeaders
