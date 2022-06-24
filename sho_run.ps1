Set-Location "C:\Users\sorokasergey\Documents\МинГаз"
$hash = @{}
[string[]]$array = @(Get-Content -Path .\Core-3650.txt )
$ar1 = $array.GetEnumerator() | ? {$_ -match "ip route "}
for ($i = 0; $i -lt $ar1.Count; $i++) {
    
    [string[]]$str = $ar1[$i] -split " "
    if ($hash.ContainsKey($str[-1])) { 
       # Write-Host $hash.Values
        $val = @(($str[2] + " " + $str[3]))
       $hash[$str[-1]] =  $hash[$str[-1]] + $val
    }
    else {
        $val1 = @(($str[2] + " " + $str[3]))
        $hash = $hash + @{$str[-1] = $val1 }   
    }
    
}
$hash.GetEnumerator() | ? {$_.Value -match "0.0.0.0 0.0.0.0"}
#$hash["172.16.192.209"]