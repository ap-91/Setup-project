#start
Set-Location $PSScriptRoot
$PSScriptRoot

$pctype = (Read-Host -Prompt "Is this a laptop or a desktop?(type l or d)").ToLower() #declares whether the computer is a (d)esktop or a (l)aptop
Out-File -FilePath .\flags.ps1 -InputObject ('$pctype='+"'$pctype'")

$install_apps_flag = (Read-Host -Prompt "install apps?[y]").ToLower() #declares whether the installers in the 'app_installers' folder should be run
Out-File -Append -FilePath .\flags.ps1 -InputObject ('$install_apps_flag='+"'$install_apps_flag'")

$start_layout_flag = (Read-Host -Prompt "import start layout?[y]").ToLower() #declares whether the start menu layout found in the "files" folder should be imported for new users
Out-File -Append -FilePath .\flags.ps1 -InputObject ('$start_layout_flag='+"'$start_layout_flag'")

$custom_user_flag = (Read-Host -Prompt "create standard user?[y]").ToLower() #declares whether a new custom user should be created
Out-File -Append -FilePath .\flags.ps1 -InputObject ('$custom_user_flag='+"'$custom_user_flag'")

if ($custom_user_flag -eq 'y') {
    $custom_user_admin_rights_flag = (Read-Host -Prompt "should the user have admin rights?[y]").ToLower() #declares whether the new user should have admin rights.
    Out-File -Append -FilePath .\flags.ps1 -InputObject ('$custom_user_admin_rights_flag='+"'$custom_user_admin_rights_flag'")
}

$rename_computer_flag = (Read-Host -Prompt "rename computer? (need to have created a user)[y]").ToLower() #declares whether the computer should be renamed the same as the username of the user that was created
Out-File -Append -FilePath .\flags.ps1 -InputObject ('$rename_computer_flag='+"'$rename_computer_flag'")

$workgroup_flag = (Read-Host -Prompt "add computer to PARLIAMENT workgroup?[y]").ToLower() #declares whether the computer should be added to the "PARLIAMENT" workgroup
Out-File -Append -FilePath .\flags.ps1 -InputObject ('$workgroup_flag='+"'$workgroup_flag'")

$default_admin_flag = (Read-Host -Prompt "enable default admin account?[y]").ToLower() #declares whether the default admin user should be enabled
Out-File -Append -FilePath .\flags.ps1 -InputObject ('$default_admin_flag='+"'$default_admin_flag'")

$user_type = (Read-Host -Prompt "Will the user be an [m]p, [s]taff, or [c]ustom?").ToLower() #declares whether the pc will be used by an MP, staff, or someone else
Out-File -Append -FilePath .\flags.ps1 -InputObject ('$user_type='+"'$user_type'")

$disable_current_account_flag = (Read-Host -Prompt "disable current user?[y]").ToLower() #declares whether the current user should be disabled.
Out-File -Append -FilePath .\flags.ps1 -InputObject ('$disable_current_account_flag='+"'$disable_current_account_flag'")

$restart_flag = Read-Host -Prompt "restart pc?[y]".ToLower() #declares whether the PC should be restarted at the end of the script
Out-File -Append -FilePath .\flags.ps1 -InputObject ('$restart_flag='+"'$restart_flag'")

$desktop_icon_flag = Read-Host -Prompt "add desktop shortcuts?[y]".ToLower() #declares whether desktop icons places in the "desktop_icons" folders should be copied to the desktop of the new user
Out-File -Append -FilePath .\flags.ps1 -InputObject ('$desktop_icon_flag='+"'$desktop_icon_flag'")

$IE_settings_flag = Read-Host -Prompt "set IE settings?[y]".ToLower() # declares whether IE homepage, bookmarks, toolbars, and trusted page should be set
Out-File -Append -FilePath .\flags.ps1 -InputObject ('$IE_settings_flag='+"'$IE_settings_flag'")

$taskbar_flag = Read-Host -Prompt "set taskbar shortcuts?[y]".ToLower() #declares whether taskbar shortcuts should be added to new user. ("taskbar_icons" folder and "reg_taskbar_laptop/desktop" in "files" folder are both needed)
Out-File -Append -FilePath .\flags.ps1 -InputObject ('$taskbar_flag='+"'$taskbar_flag'")

$cleanup_flag = Read-Host -Prompt "run cleanup?[y]".ToLower() # declares whether "cleanup.ps1" should be run
Out-File -Append -FilePath .\flags.ps1 -InputObject ('$cleanup_flag='+"'$cleanup_flag'")

Read-Host -Prompt "Press Enter to finish"