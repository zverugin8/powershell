function show-sortfiles {
    <#
    .SYNOPSIS
        show-sortfiles
    .DESCRIPTION
        Show the size of files in specific folder and sort all of them by size
    .EXAMPLE
        PS C:\> show-sortfiles "c:\windows"
        
    .INPUTS
        Path
    .OUTPUTS
        Selected.System.IO.FileInfo
    .NOTES
        Advanced function to show the size of files in specific folder and sort all of them by size.
    #>
    [CmdletBinding()]
    param (
    $path   
    )
    
begin { }
    
    process {
    if (Test-Path $path ) {
     $(Get-ChildItem $path -File) | Sort-Object -Property Length  | Select-Object -Property Name, Length   
    }#if
    else {
        Write-error -Message "Path $path not found!"
    } #else 
    }#process
  end {  } 
}  
#show-sortfiles "c:\windows"