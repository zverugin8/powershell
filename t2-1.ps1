
if ($args.Length -eq 0) { echo "Input file required"; exit }
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

#$arr=$(Import-Csv -Path .\accounts.csv)
#$arr | Select-Object id,location_id,name,title,email,department | Export-Csv -Path ou1.csv -UseQuotes AsNeeded

