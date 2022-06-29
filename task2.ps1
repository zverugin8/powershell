if ($args.Length -eq 0) { echo "Input file required"; exit } #test input
if ( -not $(Test-Path -Path $args) ) {
    echo "$args does not exist"
    exit
}
if ( $args[0][0] -eq "-") {
    echo ' "-" in arg not allowed'
    exit
} 
$f_name=$($args[0] | Split-Path -LeafBase)
$f_path=$($args[0] | Split-Path -parent)
if ($f_path -eq "") { $f_path="."}
$f_ext=$($args[0] | Split-Path -Extension)

$new_fname="$f_path" + "\" + "$f_name" + "_new" + "$f_ext"
#echo "path:$f_path, name:$f_name, ext:$f_ext"
#echo "Args:$args"
#echo "New f_name:$new_fname"

$arr=$(Import-Csv -Path $args)

function changeData {
    Param ($people)
    $c_people = $people.PSObject.Copy()
    $c_people.name=$people[0].name.tolower()
    $em1=$c_people.name[0]
    $l_name=$c_people[0].name.Split(' ')[1]
    #$c_people.email="$em1" + "$l_name" + $people[0].location_id + "@abc.com"
    $c_people.email="$em1" + "$l_name" + "@abc.com"
    $c_people.name=$( (Get-Culture).TextInfo.ToTitleCase($c_people.name) )
    
    return $c_people
    }

    $arr1=$arr.PSObject.Copy() # create copy for debug purposes

    for ($i = 0; $i -lt $arr.Count; $i++) {    #update array copy 
        $arr1[$i]=changedata($arr[$i])
    }

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

$dubl_arr8=(get-double_index($arr1))
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

$arr9=(fix_email -arr4 $arr1 -dubl_arr $dubl_arr8)
$arr9 | Select-Object id,location_id,name,title,email,department | Export-Csv -Path $new_fname -UseQuotes AsNeeded
if ($LASTEXITCODE -eq 0) {echo "Output data stored in $new_fname"}
else {echo "Something went wrong"}
