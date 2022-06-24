function Get-ValueFromPipe
{
  #process {"Processing:  $_ " }
  end {
    $previousForegroundColor = $host.UI.RawUI.ForegroundColor
    $host.UI.RawUI.ForegroundColor = "Yellow"
      foreach ($val in $input) { write-output "Value from pipe: $val"} 
    $host.UI.RawUI.ForegroundColor = $previousForegroundColor
}
}
#1..3| Get-ValueFromPipe
#@("First", "Second") | Get-ValueFromPipe