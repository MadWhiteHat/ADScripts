Install-WindowsFeature FS-SyncShareService,Web-WHC

Add-WindowsFeature FS-SyncShareService

New-SyncShare -Name "FileServer" -Path "C:\FileServer" -User ACN\AccountManagers -RequireEncryption $True -RequirePasswordAutoLock $True