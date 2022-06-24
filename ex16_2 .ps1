
function New-files {
    [CmdletBinding()]
    param (
        $path = "$HOME\testdir",
        $size = 10, #size in KB
        $count = 10 # quantity files
    )
    
    begin { #$old_loc = Get-Location 
        if ( -not $(Test-Path $path) ) {
            New-Item -Type Directory -Path $path
        }#if
    }
    
    process {
            for ($co = 0; $co -le $Count; $co++) {
            $filename = "file" + $co +"_" + $(Get-Date -Format "HH_mm_ss_dd-MM-yyyy") # geterate new file name
            New-Item -Type file -Path $path -Name $filename".txt" -Force >null
            while ($(get-item -Path $path\$filename".txt").Length -le $size*1KB) {
             $word = -join ( (65..90) + (97..122) | Get-Random -Count 50 | ForEach-Object {[char]$_} ) + " "
            Add-Content -Value $word -Path $path\$filename".txt"
            Add-Content -Value $(Get-Content -LiteralPath "$path\$filename.txt") -Path $path\$filename`.txt # trying make this process little faster   
            }#while
     }#for  
    
    }#process
    
    end { #Set-Location -Path $old_loc 
    }
}
function Remove-FixSizeFiles {
    <#
    .SYNOPSIS
       Remove-FixSizeFiles 
    .DESCRIPTION
        Delete file from a specific folder if file size greater then specified size in Kb
    .EXAMPLE
        PS C:\> Remove-FixSizeFiles -size 10
        
    .INPUTS
       $path, $size, $count  
    .OUTPUTS
        
    .NOTES
        Write an advanced function to delete file from a specific folder if file size greater then specified size in Kb.
    #>
    [CmdletBinding()]
    param (
        $path = "$HOME\testdir",
        $size = 100  
    )
    
    begin {
        
    }
    
    process {
        if (Test-Path $path ) {
        $files = $(Get-ChildItem $path -File) | Where-Object { ($_.length  -ge $size*1KB)  }
        ForEach ($file in $files) {Remove-Item -path $file}    
    }#if
    else {
        Write-error -Message "Path $path not found!"
    } #else 
    }
    
    end {
        
    }
}
#dir $path | ? -Property Length -gt ($size*1KB)
#dir $path | foreach ($_) {write-host $_.name, ($_.Length/1KB)}