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
echo "path:$f_path, name:$f_name, ext:$f_ext"
echo "Args:$args"
echo "New f_name:$new_fname"

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
    
$arr1 | Select-Object id,location_id,name,title,email,department | Export-Csv -Path $new_fname -UseQuotes AsNeeded
if ($LASTEXITCODE -eq 0) {echo "Output data stored in $new_fname"}
else {echo "Something went wrong"}
