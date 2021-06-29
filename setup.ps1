#start
Set-Location $PSScriptRoot
$PSScriptRoot

. .\flags.ps1
#pc type
#$pctype = (Read-Host -Prompt "Is this a laptop or a desktop?(type l or d)").ToLower()

$pctype
$install_apps_flag
$start_layout_flag
$custom_user_flag
$rename_computer_flag
$workgroup_flag
$default_admin_flag
$user_type
$disable_current_account_flag
$restart_flag
$desktop_icon_flag
$IE_settings_flag
$taskbar_flag
$cleanup_flag

#install applications
$install_apps_flag = (Read-Host -Prompt "install apps?[y]").ToLower()
if ($install_apps_flag -eq 'y') {
    Write-Host "Installing apps"
    if ($pctype -eq 'd') {
        Get-ChildItem .\app_installers\* -Exclude archive, laptop| ForEach-Object { Start-Process $_.FullName ALLUSERS=1 }
    }
    elseif ($pctype -eq 'l') {
        Get-ChildItem .\app_installers\* -Exclude archive| ForEach-Object { Start-Process $_.FullName ALLUSERS=1 }
    }
    Read-Host -Prompt "Apps installed. Press Enter to continue"
}
#>

#import start layout
$start_layout_flag = (Read-Host -Prompt "import start layout?[y]").ToLower()
if ($start_layout_flag -eq 'y') {
    Write-Host "Importing Start button layout"
    if ($pctype -eq 'l') {
        Import-StartLayout -LayoutPath $PSScriptRoot\files\laptop-start -MountPath C:\ 
    }
    elseif ($pctype -eq 'd') {
        Import-StartLayout -LayoutPath $PSScriptRoot\files\desktop-start -MountPath C:\ 
    }
    Read-Host -Prompt "Start button layout imported. Press Enter to continue"
}
#>

#create standard user, prompt for password
$custom_user_flag = (Read-Host -Prompt "create standard user?[y]").ToLower()
if ($custom_user_flag -eq 'y') {
    $custom_user_admin_rights_flag = (Read-Host -Prompt "should the user have admin rights?[y]").ToLower()
    Write-Host "Creating Standard User"
    $user_name = (Read-Host -Prompt 'Username').ToUpper() #sets username in all caps
    $Full_name = Read-Host -Prompt 'Full name'
    $Full_name = (Get-culture).TextInfo.ToTitleCase($Full_name.ToLower()) #sets fullname in title case
    Read-Host -Prompt "Username: $user_name. Full name: $Full_name. Press Enter to continue"
    New-LocalUser $user_name -FullName $Full_name -Description $Full_name -PasswordNeverExpires
    Add-LocalGroupMember -Group "Users" -Member $user_name
    if ($custom_user_admin_rights_flag -eq 'y') {
        Add-LocalGroupMember -Group "Administrators" -Member $user_name
    }
    Read-Host -Prompt "Standard User Created. Press Enter to continue"
}
#>

#rename computer to $username
$rename_computer_flag = (Read-Host -Prompt "rename computer? (need to have created a user)[y]").ToLower()
if ($rename_computer_flag -eq 'y') {
    Write-Host "Renaming computer"
    Rename-Computer -NewName $user_name
    Read-Host -Prompt "Computer renamed. Restart required. Press Enter to continue"
}
#>

#add computer to workgroup
$workgroup_flag = (Read-Host -Prompt "add computer to PARLIAMENT workgroup?[y]").ToLower()
if ($workgroup_flag -eq 'y') {
    Write-Host "Adding computer to workgroup"
    Add-Computer -WorkgroupName PARLIAMENT
    Write-Host "Computer added to workgroup"
}

#enable default admin user
$default_admin_flag = (Read-Host -Prompt "enable default admin account?[y]").ToLower()
if ($default_admin_flag -eq 'y') {
    Write-Host "Enabling Administrator account"
    Get-LocalUser -Name "Administrator" | Enable-LocalUser
    $user_type = (Read-Host -Prompt "Will the user be an [m]p, [s]taff, or [c]ustom?").ToLower()
    if ($user_type -eq 'm') {
        $adminpass = 'mpag2018' | ConvertTo-SecureString -AsPlainText -Force
    }
    elseif ($user_type -eq 's') {
        $adminpass = 'ax2018ge' | ConvertTo-SecureString -AsPlainText -Force
    }
    else {
        $adminpass = Read-Host -Prompt "enter custom password:" | ConvertTo-SecureString -AsPlainText -Force
    }
    $adminacc = Get-LocalUser -Name "Administrator"
    $adminacc | Set-LocalUser -Password $adminpass
    Read-Host -Prompt "Administrator enabled. Press Enter to continue"
}
#>

#disable current user and remove password
$disable_current_account_flag = (Read-Host -Prompt "disable current user?[y]").ToLower()
if ($disable_current_account_flag -eq 'y') {
    Write-Host "Disabling current user"
    $current_user = [Environment]::UserName #find current user's username
    Set-LocalUser -name $current_user -Password ([securestring]::new()) #remove password
    Disable-LocalUser -Name $current_user
    Read-Host -Prompt "Current user is disabled. Press Enter to continue"
}
#>

$restart_flag = Read-Host -Prompt "restart pc?[y]"
if ($restart_flag -eq 'y') {
    Restart-computer
}