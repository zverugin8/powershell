$var =  Get-ChildItem $args[0]
#ForEach-object -InputObject $var {if (($var.GetEnumerator()).mode -notmatch '^d+') {write-output ($var.GetEnumerator()).Length} }
#ForEach-object -InputObject $var {write-output ($var.GetEnumerator()).Length}
ForEach-object -InputObject $var { 
if ( ($var.GetEnumerator()).mode -notmatch '^d+') {write-output ($var.mode} 
}