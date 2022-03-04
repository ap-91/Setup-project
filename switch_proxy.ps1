$proxy=Get-ItemPropertyValue -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Internet Settings' -name 'ProxyServer'
If ($proxy -eq '10.21.12.6:8080') {
Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Internet Settings' -name ProxyServer -Value "10.21.12.213:8080"
}
elseif ($proxy -eq '10.21.12.213:8080') {
Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Internet Settings' -name ProxyServer -Value "10.21.12.6:8080"
}
Else {
Write-Error -Message "The proxy address is not valid"
}
Read-Host -Prompt 'press enter to finish'