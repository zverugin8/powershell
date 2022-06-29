Clear-Variable dubl_arr8
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
                    [string]$dupl_str+="$j "
                    $flag=1
                } #if
            } #for $j
        }
        if ($flag -eq 1) {[string]$dupl_str+="$i "}
    } #for $i
    $dubl_arr=$dupl_str.Split(" ")
    $dubl_arr=$dubl_arr[0..($dubl_arr.length-2)] # remove last "space"
    return $dubl_arr
}
$dubl_arr8=(get-double_index($arr8))


echo $dubl_arr8



function fix_email {
    [cmdletbinding()]
    param (
        [parameter(Position=0)]$arr4,
        [parameter(Position=1)]$dubl_arr
        )
    [string]$em1=""
    foreach ($ind in $dubl_arr ) {
        #echo "ind:$ind"
        #echo "before_eml:$($arr4[$ind].email)"
        $em1=$($arr4[$ind].email.Split("@")[0])
        #echo "em1_1:$em1"
        #echo "loc_id:$($arr4[$ind].location_id)"
        $em2="$em1" + "$($arr4[$ind].location_id)" + '@abc.com'
        #echo "em2:$em2"
        #echo "before_eml:$($arr4[$ind].email)"
        $arr4[$ind].email="$em2"
        #echo "after_eml:$($arr4[$ind].email)"
        #echo "after_eml:$($arr4[$ind].email)"
        #echo "all_ind:$($arr4[$ind])"
        $em1=""
        $em2=""
    }
 return $arr4
}
