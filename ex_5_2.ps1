class ex2 {
[string]$str1
[void]SetString([string]$str2){
$this.str1 = $str2
}
[string] PrintString() {
return $this.str1.ToUpper()
}
}
$MyCustomObject = [ex2]::new()
