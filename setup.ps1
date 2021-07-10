#start
Set-Location $PSScriptRoot #sets current directory to the location of the script. (needed because "elevator" causes the default directory to be system32)
$PSScriptRoot

. .\flags.ps1 #import variables from "flags.ps1"

<#
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
#>

#install applications
if ($install_apps_flag -eq 'y') {
    Write-Host "Installing apps"
    if ($pctype -eq 'd') {
        Get-ChildItem .\app_installers\* -Exclude excluded, laptop | ForEach-Object { Start-Process $_.FullName ALLUSERS=1 } #find all files in 'app_installers' folder excluding subfolders 'laptop' and 'excluded'. Then run each file found        Read-Host -Prompt "Apps installed. Press Enter to continue"
    }
    elseif ($pctype -eq 'l') {
        Get-ChildItem .\app_installers\* -Exclude excluded | ForEach-Object { Start-Process $_.FullName ALLUSERS=1 } #include 'laptop' subfolder if pctype is laptop
        Read-Host -Prompt "Apps installed. Press Enter to continue"
    }
    else {
        Write-Error "invalid flag. variable 'pctype' should be either 'd'or 'l'. currently it is $pctype "
    }
}
#>

#import start layout
if ($start_layout_flag -eq 'y') {
    Write-Host "Importing Start button layout"
    if ($pctype -eq 'l') {
        Import-StartLayout -LayoutPath $PSScriptRoot\files\laptop-start -MountPath C:\ #import start menu layout for new users. 'laptop-start' if pctype is laptop
    }
    elseif ($pctype -eq 'd') {
        Import-StartLayout -LayoutPath $PSScriptRoot\files\desktop-start -MountPath C:\ # 'desktop-start' if pctype is desktop
    }
    Read-Host -Prompt "Start button layout imported. Press Enter to continue"
}
#>

#create standard user, prompt for password
if ($custom_user_flag -eq 'y') {
    Write-Host "Creating Standard User"
    $user_name = (Read-Host -Prompt 'Username').ToUpper() #ask for username and then convert it to all caps
    $Full_name = Read-Host -Prompt 'Full name'
    $Full_name = (Get-culture).TextInfo.ToTitleCase($Full_name.ToLower()) #sets fullname in title case
    Read-Host -Prompt "Username: $user_name. Full name: $Full_name. Press Enter to continue" #confirmation
    New-LocalUser $user_name -FullName $Full_name -Description $Full_name -PasswordNeverExpires #create user with $user_name as username, $Full_name as full name and description.
    Add-LocalGroupMember -Group "Users" -Member $user_name #add user to the 'users' group
    if ($custom_user_admin_rights_flag -eq 'y') {
        Add-LocalGroupMember -Group "Administrators" -Member $user_name #add user to 'Administrators' group (if needed)
    }
    Read-Host -Prompt "Standard User Created. Press Enter to continue"
}
#>

#rename computer to $username
if ($rename_computer_flag -eq 'y') {
    Write-Host "Renaming computer"
    Rename-Computer -NewName $user_name #rename computer the same the username
    Read-Host -Prompt "Computer renamed. Restart required. Press Enter to continue"
}
#>

#add computer to workgroup
if ($workgroup_flag -eq 'y') {
    Write-Host "Adding computer to workgroup"
    Add-Computer -WorkgroupName PARLIAMENT #adds pc to 'parliament' workgroup
    Write-Host "Computer added to workgroup"
}

#enable default admin user
$default_admin_flag = (Read-Host -Prompt "enable default admin account?[y]").ToLower()
if ($default_admin_flag -eq 'y') {
    Write-Host "Enabling Administrator account"
    Get-LocalUser -Name "Administrator" | Enable-LocalUser #enables default admin user
    $adminpass = Read-Host -AsSecureString -Prompt "enter custom password:"
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