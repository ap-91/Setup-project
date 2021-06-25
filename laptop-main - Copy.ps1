
#start
$directory='g:\Setup_project\'
Set-Location $directory

#add desktop icons
Write-Host "Adding desktop icons"
Copy-Item -Path ".\desktop_icons\*" -Destination "~\Desktop" -Recurse
Read-Host -Prompt "Desktop icons added. Press Enter to continue"
#>

#set IE settings
#import bookmarks into internet explorer
Write-Host "importing bookmarks into IE"
Copy-Item -Path ".\IE_bookmarks\*" -Destination "~\favorites\links"
Write-Host "bookmarks imported"
#set IE home page
$HomeURL='http://www.parliament.cy/'
set-ItemProperty -Path 'HKCU:\Software\Microsoft\Internet Explorer\main' -Name "Start Page" -Value $HomeURL
Write-Host "Home page set"
#set trusted sites
reg import .\files\Trusted_site.reg
Write-Host "trusted sites added"
#show toolbars
reg import .\files\Show_toolbars.reg
Write-Host "toolbars shown"
Read-Host -Prompt "Press Enter to continue"
#>

#add shortcuts to taskbar
Write-Host "Adding shortcuts to taskbar"
Remove-Item -Path "~\AppData\Roaming\Microsoft\Internet Explorer\Quick Launch\User Pinned\TaskBar\*"
Copy-Item -Path ".\TaskBar_icons\*" -Destination "~\AppData\Roaming\Microsoft\Internet Explorer\Quick Launch\User Pinned\TaskBar" -Recurse
reg import .\files\reg_taskbar.reg
Stop-Process -Name explorer
Read-Host -Prompt "Taskbar shortcuts added. Press Enter to continue"
#>

#run apps for initialisation
Write-Host "Launching apps"
Get-ChildItem .\apps_to_run|ForEach-Object {Start-Process $_.FullName}
Read-Host -Prompt "Apps launched. Press Enter to continue"
#>

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