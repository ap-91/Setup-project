#start
Set-Location $PSScriptRoot
$PSScriptRoot

#pc type
$pctype = Read-Host -Prompt "Is this a laptop or a desktop?(type l or d)"

#add desktop icons
$desktop_icon_flag = Read-Host -Prompt "add desktop shortcuts?[y]"
if ($desktop_icon_flag -eq 'y') {
    Write-Host "Adding desktop icons"
    if ($pctype -eq 'l') {
        Copy-Item -Path "$PSScriptRoot\desktop_icons(laptop)\*" -Destination "~\Desktop" -Recurse
    }
    elseif ($pctype -eq 'd') {
        Copy-Item -Path "$PSScriptRoot\desktop_icons(desktop)\*" -Destination "~\Desktop" -Recurse
    }
    Read-Host -Prompt "Desktop icons added. Press Enter to continue"
}
#>

#set IE settings
$IE_settings_flag = Read-Host -Prompt "set IE settings?[y]"
if ($IE_settings_flag -eq 'y') {
    #import bookmarks into internet explorer
    Write-Host "importing bookmarks into IE"
    Copy-Item -Path "$PSScriptRoot\IE_bookmarks\*" -Destination "~\favorites\links"
    Write-Host "bookmarks imported"
    #set IE home page
    $HomeURL = 'http://www.parliament.cy/'
    set-ItemProperty -Path 'HKCU:\Software\Microsoft\Internet Explorer\main' -Name "Start Page" -Value $HomeURL
    Write-Host "Home page set"
    #set trusted sites
    reg import $PSScriptRoot\files\Trusted_site.reg
    Write-Host "trusted sites added"
    #show toolbars
    reg import $PSScriptRoot\files\Show_toolbars.reg
    Write-Host "toolbars shown"
    Read-Host -Prompt "Press Enter to continue"
}
#>

#add shortcuts to taskbar
$taskbar_flag = Read-Host -Prompt "set taskbar shortcuts?[y]"
if ($taskbar_flag -eq 'y') {
    Write-Host "Adding shortcuts to taskbar"
    Remove-Item -Path "~\AppData\Roaming\Microsoft\Internet Explorer\Quick Launch\User Pinned\TaskBar\*"
    Copy-Item -Path "$PSScriptRoot\TaskBar_icons\*" -Destination "~\AppData\Roaming\Microsoft\Internet Explorer\Quick Launch\User Pinned\TaskBar" -Recurse
    if ($pctype -eq 'l') {
        reg import $PSScriptRoot\files\reg_taskbar_laptop.reg
    }
    elseif ($pctype -eq 'd') {
        reg import $PSScriptRoot\files\reg_taskbar_desktop.reg
    }
    Stop-Process -Name explorer
    Read-Host -Prompt "Taskbar shortcuts added. Press Enter to continue"
}
#>

#run cleanup as admin
$cleanup_flag = Read-Host -Prompt "run cleanup?[y]"
if ($cleanup_flag -eq 'y') {
    Start-Process powershell.exe -verb runas -ArgumentList "$PSScriptRoot\cleanup.ps1"
}

#finish
Read-Host -Prompt "Press Enter to finish"