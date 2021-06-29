#start

$PSScriptRoot
Set-Location $PSScriptRoot
#>

#install applications
Write-Host "Installing apps"
Get-ChildItem $PSScriptRoot\app_installers|ForEach-Object {Start-Process $_.FullName ALLUSERS=1}
Read-Host -Prompt "Apps installed. Press Enter to continue"
#>

#import start layout
Write-Host "Importing Start button layout"
Import-StartLayout -LayoutPath $PSScriptRoot\files\desired_layout -MountPath C:\
Read-Host -Prompt "Start button layout imported. Press Enter to continue"
#>

#create custom admin user, prompt for password
Write-Host "Creating Admin User"
$user_name = Read-Host -Prompt 'Username'
$Full_name = Read-Host -Prompt 'Full name'
Read-Host -Prompt "Username: $user_name. Full name: $Full_name. Press Enter to continue"
New-LocalUser $user_name -FullName $Full_name -Description $Full_name -PasswordNeverExpires
Add-LocalGroupMember -Group "Users" -Member $user_name
Add-LocalGroupMember -Group "Administrators" -Member $user_name
Read-Host -Prompt "Admin User Created. Press Enter to continue"
#>

#create standard user, prompt for password
Write-Host "Creating Standard User"
$user_name = Read-Host -Prompt 'Username'
$Full_name = Read-Host -Prompt 'Full name'
Read-Host -Prompt "Username: $user_name. Full name: $Full_name. Press Enter to continue"
New-LocalUser $user_name -FullName $Full_name -Description $Full_name -PasswordNeverExpires
Add-LocalGroupMember -Group "Users" -Member $user_name
Read-Host -Prompt "Standard User Created. Press Enter to continue"
#>

#rename computer to $username
Write-Host "Renaming computer"
Rename-Computer -NewName $user_name
Read-Host -Prompt "Computer renamed. Restart required. Press Enter to continue"
#>

#disable default admin user
Write-Host "Disabling Administrator account"
Set-LocalUser -name "Administrator" -Password ([securestring]::new()) #remove password
Disable-LocalUser -Name "Administrator"
Read-Host -Prompt "Administrator disabled. Press Enter to continue"
#>

#disable current user and remove password
Write-Host "Disabling current user"
$current_user=[Environment]::UserName #find current user's username
Set-LocalUser -name $current_user -Password ([securestring]::new()) #remove password
Disable-LocalUser -Name $current_user
Read-Host -Prompt "Current user is disabled. Press Enter to continue"
#>

#add desktop icons
Write-Host "Adding desktop icons"
Copy-Item -Path "$PSScriptRoot\desktop_icons\*" -Destination "~\Desktop" -Recurse
Read-Host -Prompt "Desktop icons added. Press Enter to continue"
#>

#set IE settings
#import bookmarks into internet explorer
Write-Host "importing bookmarks into IE"
Copy-Item -Path "$PSScriptRoot\IE_bookmarks\*" -Destination "~\favorites\links"
Write-Host "bookmarks imported"
#set IE home page
$HomeURL='http://www.parliament.cy/'
set-ItemProperty -Path 'HKCU:\Software\Microsoft\Internet Explorer\main' -Name "Start Page" -Value $HomeURL
Write-Host "Home page set"
#set trusted sites
reg import $PSScriptRoot\files\Trusted_site.reg
Write-Host "trusted sites added"
#show toolbars
reg import $PSScriptRoot\files\Show_toolbars.reg
Write-Host "toolbars shown"
Read-Host -Prompt "Press Enter to continue"
#>

#add shortcuts to taskbar
Write-Host "Adding shortcuts to taskbar"
Remove-Item -Path "~\AppData\Roaming\Microsoft\Internet Explorer\Quick Launch\User Pinned\TaskBar\*"
Copy-Item -Path "$PSScriptRoot\TaskBar_icons\*" -Destination "~\AppData\Roaming\Microsoft\Internet Explorer\Quick Launch\User Pinned\TaskBar" -Recurse
reg import $PSScriptRoot\files\reg_taskbar.reg
Stop-Process -Name explorer
Read-Host -Prompt "Taskbar shortcuts added. Press Enter to continue"
#>

#run apps for initialisation
Write-Host "Launching apps"
Get-ChildItem $PSScriptRoot\apps_to_run|ForEach-Object {Start-Process $_.FullName}
Read-Host -Prompt "Apps launched. Press Enter to continue"
#>

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

#finish
Read-Host -Prompt "Script finished. Press Enter to exit"

#Restart-computer