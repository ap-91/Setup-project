
#start
$directory='E:\Setup_project\'
Set-Location $directory

#add desktop icons
Set-Location $directory\Add_desktop_icons
& .\Show_icons_laptop.ps1 -Wait

#import bookmarks into internet explorer
Set-Location $directory\browser_settings
& .\Import_to_IE.ps1 -Wait

#add shortcuts to taskbar
Set-Location $directory\Taskbar
& .\taskbar.ps1 -Wait

#add shortcuts to start menu
#Set-Location $directory\Start_menu
#& .\startmenu.ps1 -Wait

#Cleanup
Set-Location $directory\Cleanup
& .\cleanup.ps1 -Wait

#finish
Read-Host -Prompt "Press Enter to finish"