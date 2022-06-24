function Write-ColoredMessage 
{
    [cmdletbinding()]
    Param ( 
        [PARAMETER(Mandatory=$true,Position=0)][switch]$Text,
        [PARAMETER(Mandatory=$true,Position=1)][string]$msg,
        [PARAMETER(Mandatory=$true,Position=2,ParameterSetName='Red')][switch]$Red,
        [PARAMETER(Mandatory=$true,Position=2,ParameterSetName='Blue')][switch]$Blue
        
        )
# Save previous colors
$previousForegroundColor = $host.UI.RawUI.ForegroundColor
#$previousBackgroundColor = $host.UI.RawUI.BackgroundColor
if ($Red -and $Text) {
    $host.UI.RawUI.ForegroundColor = "Red"
    Write-Output $msg
    }
if ($Blue -and $Text) {
        $host.UI.RawUI.ForegroundColor = "Blue"
        Write-Output $msg
        }
# Restore previous colors
$host.UI.RawUI.ForegroundColor = $previousForegroundColor
#$host.UI.RawUI.BackgroundColor = $previousBackgroundColor
#Write-Host $Text
#Write-Host $msg
#Write-Host $Red
#Write-Host $Blue
    }
    

Clear-Host
Write-ColoredMessage -Text "Hello there!" -Blue