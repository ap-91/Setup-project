
#start
$directory='G:\Setup_project\'
Set-Location $directory

#reset start layout
Write-Host "Resetting Start menu layout"
Import-StartLayout -LayoutPath .\files\default_layout -MountPath C:\
Read-Host -Prompt "Start menu layout reset. Press Enter to continue"
#>

#Set policy back to default
Write-Host "Resetting policy"
set-executionpolicy Default -Confirm:$false
Read-Host -Prompt "Policy reset. Press Enter to continue"
#>

#finish
Read-Host -Prompt "Press Enter to finish"