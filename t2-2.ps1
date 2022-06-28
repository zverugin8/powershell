#cd "C:\Users\sorokasergey\OneDrive\EPAM\PS\"
$arr=$(Import-Csv -Path .\accounts.csv)

function changeData {
Param ($people)
$c_people = $people.PSObject.Copy()
$c_people.name=$people[0].name.tolower()
$em1=$c_people.name[0]
$l_name=$c_people[0].name.Split(' ')[1]
#echo $em1
#echo $l_name
#$c_people.email="$em1" + "$l_name" + $people[0].location_id + "@abc.com"
$c_people.email="$em1" + "$l_name" + "@abc.com"
$c_people.name=$( (Get-Culture).TextInfo.ToTitleCase($c_people.name) )

return $c_people
}

$arr1=$arr.PSObject.Copy()

for ($i = 0; $i -lt $arr.Count; $i++) {
    $arr1[$i]=changedata($arr[$i])
}


