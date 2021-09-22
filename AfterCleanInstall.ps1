#Install boxstarter

#Temporary, disable UAC
Disable-UAC

#Windows Desktop Experience Settings
Disable-GameBarTips

Set-WindowsExplorerOptions -EnableShowFileExtensions
#Set-BoxstarterTaskbarOptions -Size Small -Dock Bottom -Combine Full -Lock

#Privacy
If (-Not (Test-Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\AdvertisingInfo)) {
    New-Item -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\AdvertisingInfo | Out-Null
} 
Set-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\AdvertisingInfo -Name Enabled -Type DWord -Value 0

#WiFi Sense: hotspot sharing disabled
Set-ItemProperty -Path HKLM:\Software\Microsoft\PolicyManager\default\Wifi\AllowAutoConnectToWiFiSenseHotspots -Name value -Type DWord -Value 0

#Start Menu: disable Bing search results
Set-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Search -Name BingSearchEnabled -Type DWord -Value 0
#to restore
#Set-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Search -Name BingSearchEnabled -Type DWord -Value 1

#Disable Telemetry (data logging) requires reboot
#Use at own risk
Set-ItemProperty -Path HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection -Name AllowTelemetry -type DWord -Value 0
Get-Service DiagTrackm,dmwappushservice | Stop-Service | Set-Service -StartupType Disabled

#Change Explorer home screen to "This PC"
Set-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name LaunchTo -Type DWord -Value 1
#restore to quick access
#Set-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name LaunchTo -Type DWord -Value 2

#Better File Explorer
Set-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name NavPaneExpandToCurrentFolder -Value 1
Set-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name NavPaneShowAllFolders -Value 1
Set-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name MMTaskbarMode -Value 2

#Disable Lock Screen (the one before the password prompt - prevent dropping first character)
If (-Not (Test-Path HKLM:\SOFTWARE\Policies\Microsoft\Windows\Personalization)) {
	New-Item -Path HKLM:\SOFTWARE\Policies\Microsoft\Windows -Name Personalization | Out-Null
}
Set-ItemProperty -Path HKLM:\SOFTWARE\Policies\Microsoft\Windows\Personalization -Name NoLockScreen -Type DWord -Value 1 
#to restore
#Set-ItemProperty -Path HKLM:\SOFTWARE\Policies\Microsoft\Windows\Personalization -Name NoLockScreen -Type DWord -Value 0

#Disable Xbox Gamebar
Set-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\GameDVR -Name AppCaptureEnabled -Type DWord -Value 0
Set-ItemProperty -Path HKCU:\System\GameConfigStore -Name GameDVR_Enabled -Type DWord -Value 0

#Turn off People in Taskbar
If (-Not (Test-Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced\People)) {
	New-Item -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced\People -Name Personalization | Out-Null
}
Set-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced\People -Name PeopleBand -Type DWord -Value 0


#Windows Features
choco install Microsoft-Hyper-V-All -source windowsFeatures
choco install Containers -source windowsFeatures
choco install Microsoft-Windows-Subsystem-Linux -source windowsfeatures

#Tools and apps
choco install vscode -dvy
choco install googlechrome -dvy
choco install firefox -dvy
choco install vlc -dvy
choco install git.install -dvy
choco install putty -dvy
choco install filezilla -dvy
choco install virtualbox -dvy
choco install vmwareworkstation -dvy
choco install wireshark -dvy
choco install nmap -dvy
choco install obs-studio -dvy
choco install office-tool -dvy


#Uninstall unecessary applications that come with Windows out of the box
Get-AppxPackage Microsoft.3DBuilder | Remove-AppPackage
Get-AppxPackage Microsoft.BingFinance | Remove-AppPackage
Get-AppxPackage Microsoft.BingSports | Remove-AppPackage
Get-AppxPackage Microsoft.BingWeather | Remove-AppPackage
Get-AppxPackage Microsoft.WindowsFeedbackHub | Remove-AppPackage
Get-AppxPackage Microsoft.GetStarted | Remove-AppPackage
Get-AppxPackage Microsoft.Messaging | Remove-AppPackage
Get-AppxPackage Microsoft.windowscommunicationsapps | Remove-AppPackage
Get-AppxPackage Microsoft.3WindowsMaps | Remove-AppPackage
Get-AppxPackage Microsoft.MicrosoftOfficeHub | Remove-AppPackage
Get-AppxPackage Microsoft.OneConnect | Remove-AppPackage
Get-AppxPackage Microsoft.OneNote| Remove-AppPackage
Get-AppxPackage Microsoft.People | Remove-AppPackage
Get-AppxPackage Microsoft.WindowsPhone | Remove-AppPackage
Get-AppxPackage Microsoft.SkypeApp | Remove-AppPackage
Get-AppxPackage Microsoft.WindowsSoundRecorder | Remove-AppPackage
Get-AppxPackage king.com.CandyCrush* | Remove-AppPackage
#Get-AppxPackage *Dell* | Remove-AppPackage
Get-AppxPackage *Facebook* | Remove-AppPackage
Get-AppxPackage *MarchofEmpires* | Remove-AppPackage
Get-AppxPackage *Plex* | Remove-AppPackage
Get-AppxPackage *Solitaire* | Remove-AppPackage
Get-AppxPackage *Twitter* | Remove-AppPackage

#Restore temporary settings
Enable-UAC

#Rename computer
#$computername = "ARTEM1Sb"
#if ($env:COMPUTERNAME -ne $computername) {
#    Rename-Computer -NewName $computername -Restart
#}
