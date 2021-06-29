#start
Set-Location $PSScriptRoot
$PSScriptRoot

$pctype = (Read-Host -Prompt "Is this a laptop or a desktop?(type l or d)").ToLower() 
Out-File -FilePath .\flags.ps1 -InputObject ('$pctype='+"'$pctype'")

$install_apps_flag = (Read-Host -Prompt "install apps?[y]").ToLower()
Out-File -Append -FilePath .\flags.ps1 -InputObject ('$install_apps_flag='+"'$install_apps_flag'")

$start_layout_flag = (Read-Host -Prompt "import start layout?[y]").ToLower()
Out-File -Append -FilePath .\flags.ps1 -InputObject ('$start_layout_flag='+"'$start_layout_flag'")

$custom_user_flag = (Read-Host -Prompt "create standard user?[y]").ToLower()
Out-File -Append -FilePath .\flags.ps1 -InputObject ('$custom_user_flag='+"'$custom_user_flag'")

if ($custom_user_flag -eq 'y') {
    $custom_user_admin_rights_flag = (Read-Host -Prompt "should the user have admin rights?[y]").ToLower()
    Out-File -Append -FilePath .\flags.ps1 -InputObject ('$custom_user_admin_rights_flag='+"'$custom_user_admin_rights_flag'")
}

$rename_computer_flag = (Read-Host -Prompt "rename computer? (need to have created a user)[y]").ToLower()
Out-File -Append -FilePath .\flags.ps1 -InputObject ('$rename_computer_flag='+"'$rename_computer_flag'")

$workgroup_flag = (Read-Host -Prompt "add computer to PARLIAMENT workgroup?[y]").ToLower()
Out-File -Append -FilePath .\flags.ps1 -InputObject ('$workgroup_flag='+"'$workgroup_flag'")

$default_admin_flag = (Read-Host -Prompt "enable default admin account?[y]").ToLower()
Out-File -Append -FilePath .\flags.ps1 -InputObject ('$default_admin_flag='+"'$default_admin_flag'")

$user_type = (Read-Host -Prompt "Will the user be an [m]p, [s]taff, or [c]ustom?").ToLower()
Out-File -Append -FilePath .\flags.ps1 -InputObject ('$user_type='+"'$user_type'")

$disable_current_account_flag = (Read-Host -Prompt "disable current user?[y]").ToLower()
Out-File -Append -FilePath .\flags.ps1 -InputObject ('$disable_current_account_flag='+"'$disable_current_account_flag'")

$restart_flag = Read-Host -Prompt "restart pc?[y]".ToLower()
Out-File -Append -FilePath .\flags.ps1 -InputObject ('$restart_flag='+"'$restart_flag'")

$desktop_icon_flag = Read-Host -Prompt "add desktop shortcuts?[y]".ToLower()
Out-File -Append -FilePath .\flags.ps1 -InputObject ('$desktop_icon_flag='+"'$desktop_icon_flag'")

$IE_settings_flag = Read-Host -Prompt "set IE settings?[y]".ToLower()
Out-File -Append -FilePath .\flags.ps1 -InputObject ('$IE_settings_flag='+"'$IE_settings_flag'")

$taskbar_flag = Read-Host -Prompt "set taskbar shortcuts?[y]".ToLower()
Out-File -Append -FilePath .\flags.ps1 -InputObject ('$taskbar_flag='+"'$taskbar_flag'")

$cleanup_flag = Read-Host -Prompt "run cleanup?[y]".ToLower()
Out-File -Append -FilePath .\flags.ps1 -InputObject ('$cleanup_flag='+"'$cleanup_flag'")

Read-Host -Prompt "test"