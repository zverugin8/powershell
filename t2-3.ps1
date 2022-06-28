$arr1=$(Import-Csv -Path .\accounts_new.csv)
$res=$($arr1 | Group 'email' | Where{$_.Count -gt 1} | sort -Property Count)

foreach ($b in $res) 
{
    foreach ($a in $b.Group) 
    {
    #echo $a.id
    #$res[0].Group.id ; a=res[b];
    #echo $arr1[($a.id-1)]
    #$arr1[($a.id-1)].email+=$arr1[($a.id-1)]
    

    } 
}
