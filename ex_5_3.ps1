class ex53 {
[array]$str53 = @()
[string]$str54
[string]Reverse([string]$str503){
$this.str53 = $str503.ToCharArray()
[array]::Reverse($this.str53)
$this.str54 = -join($this.str53)
return $this.str54
}

}

