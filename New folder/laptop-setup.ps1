#start
$directory='F:\Setup_project\'
Set-Location $directory

#import start layout
Write-Host "Importing Start button layout"
Import-StartLayout -LayoutPath .\files\desired_layout -MountPath C:\
Read-Host -Prompt "Start button layout imported. Press Enter to continue"
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

Restart-computer