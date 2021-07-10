#start
Set-Location $PSScriptRoot
$PSScriptRoot

. .\flags.ps1 #import variables from "flags.ps1"

#add desktop icons
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
if ($IE_settings_flag -eq 'y') {
    #import bookmarks into internet explorer
    Write-Host "importing bookmarks into IE"
    Copy-Item -Path "$PSScriptRoot\IE_bookmarks\*" -Destination "~\favorites\links" #links='favorites bar'
    Write-Host "bookmarks imported"
    #set IE home page
    $HomeURL = 'http://www.parliament.cy/'
    set-ItemProperty -Path 'HKCU:\Software\Microsoft\Internet Explorer\main' -Name "Start Page" -Value $HomeURL #sets home page
    Write-Host "Home page set"
    #set trusted sites
    new-Item -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings\ZoneMap\Domains\govcloud.gov.cy' #create reg folder
    set-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings\ZoneMap\Domains\govcloud.gov.cy' -Name "https" -Value 2 #set folder as trusted
    Write-Host "trusted sites added"
    #show toolbars
    set-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Internet Explorer\MINIE' -Name "AlwaysShowMenus" -Value 1
    set-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Internet Explorer\MINIE' -Name "LinksBandEnabled" -Value 1
    Write-Host "toolbars shown"
    Read-Host -Prompt "Press Enter to continue"
}
#>

#add shortcuts to taskbar
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
if ($cleanup_flag -eq 'y') {
    Start-Process powershell.exe -verb runas -ArgumentList "$PSScriptRoot\cleanup.ps1"
}

#finish
Read-Host -Prompt "Press Enter to finish"