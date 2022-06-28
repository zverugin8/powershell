$arr1=$(Import-Csv -Path .\accounts_new.csv)

for ($i = 0; $i -lt ($arr1.Count-1); $i++) {
    #$f_dupl=$arr1[$i].email
    for ($j = ($i+1); $j -lt $arr1.Count; $j++)  {
    if ( $arr1[$i].email -eq $arr1[$j].email) {echo "$($arr1[$i].email) dulpicate, index $i $j"}
    }
}