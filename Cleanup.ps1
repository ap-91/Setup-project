
#start
Set-Location $PSScriptRoot
$PSScriptRoot

#reset start layout
Write-Host "Resetting Start menu layout"
Import-StartLayout -LayoutPath $PSScriptRoot\files\default_layout -MountPath C:\ #imports the default start menu layout
Read-Host -Prompt "Start menu layout reset. Press Enter to continue"
#>

#Set policy back to default
Write-Host "Resetting policy"
set-executionpolicy Default -Confirm:$false #resets the execution policy back to default for security reasons.
Read-Host -Prompt "Policy reset. Press Enter to continue"
#>

Get-ChildItem .\apps_to_run\* | ForEach-Object { Start-Process $_}