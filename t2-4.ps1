$arr1=$(Import-Csv -Path .\accounts_new.csv)
$dupl_str=""
for ($i = 0; $i -lt ($arr1.Count-1); $i++) {
    #$f_dupl=$arr1[$i].email
    $flag=0
    for ($j = ($i+1); $j -lt $arr1.Count; $j++)  {
        if ( $arr1[$i].email -eq $arr1[$j].email) {
            #echo "$($arr1[$i].email) dulpicate, index $i $j"
            [string]$dupl_str+=" $j"
            $flag=1
        } #if
    } #for $j
    if ($flag -eq 1) {[string]$dupl_str+=" $i"}
} #for $i
echo $dupl_str