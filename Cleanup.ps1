
#start
Set-Location $PSScriptRoot
$PSScriptRoot

#reset start layout
Write-Host "Resetting Start menu layout"
Import-StartLayout -LayoutPath $PSScriptRoot\files\default_layout -MountPath C:\
Read-Host -Prompt "Start menu layout reset. Press Enter to continue"
#>

#Set policy back to default
Write-Host "Resetting policy"
set-executionpolicy Default -Confirm:$false
Read-Host -Prompt "Policy reset. Press Enter to continue"
#>