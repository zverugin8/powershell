$arr8=$(Import-Csv -Path .\accounts_new.csv)

function get-double_index {
    param ($arr1)
    

    $dupl_str=""
    for ($i = 0; $i -lt ($arr1.Count-1); $i++) {
        #$f_dupl=$arr1[$i].email
        $flag=0
        if ( -not $dupl_str.Contains("$i") ) {
            for ($j = ($i+1); $j -lt $arr1.Count; $j++)  {
                if ( $arr1[$i].email -eq $arr1[$j].email) {
                    #echo "$($arr1[$i].email) dulpicate, index $i $j"
                    [string]$dupl_str+=" $j"
                    $flag=1
                } #if
            } #for $j
        }
        if ($flag -eq 1) {[string]$dupl_str+=" $i"}
    } #for $i
    $dubl_arr=$dupl_str.Split(" ")
    return $dubl_arr
}
$dubl_arr8=(get-double_index($arr8))
echo $dubl_arr8

function fix_email {
    param ($arr1,$dubl_arr)
    [string]$em1=""
    foreach ($ind in $dubl_arr ) {
        echo "before_eml:$($arr1[$ind].email)"
        $em1=$($arr1[$ind].email.Split("@")[0])
        echo "em1_1:$em1"
        echo "loc_id:$($arr1[$ind].location_id)"
        $em2="$em1" + "$($arr1[$ind].location_id)" + '@abc.com'
        echo "em2:$em2"
        $arr1[$ind].email="$em2"
        echo "after_eml:$($arr1[$ind].email)"
        echo $arr1[$ind].email
        $em1=""
    }
 return $arr1   
}