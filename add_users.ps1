Import-Module ActiveDirectory

$ACN="acn"
$ACN_LOC="local"
$ACC="Accounting"
$MGMT="Management"
$NEWS="News"
$ADV="Advertisement"
$MNT="Maintenance"
$TECH="Tech Support"
$SERVPERS="Service Personnel"
$SCRIPT="on_logon.bat"

New-ADUser -Name "ElliotAlderson" -GivenName "Elliot" -Surname "Alderson" -SamAccountName "ElliotAlderson" -Path "OU=$TECH,OU=$MNT,DC=$ACN,DC=$ACN_LOC" -AccountPassword(ConvertTo-SecureString "ElliotAlderson1" -AsPlainText -Force) -ChangePasswordAtLogon:$False -Enabled:$True -ScriptPath $SCRIPT
New-ADUser -Name "TyrellWelleck" -GivenName "Tyrell" -Surname "Welleck" -SamAccountName "TyrellWelleck" -Path "OU=$TECH,OU=$MNT,DC=$ACN,DC=$ACN_LOC" -AccountPassword(ConvertTo-SecureString "TyrellWelleck1" -AsPlainText -Force) -ChangePasswordAtLogon:$False -Enabled:$True -ScriptPath $SCRIPT
New-ADUser -Name "Lucas" -GivenName "Lucas" -SamAccountName "Lucas" -Path "OU=$TECH,OU=$MNT,DC=$ACN,DC=$ACN_LOC" -AccountPassword(ConvertTo-SecureString "Lucas1" -AsPlainText -Force) -ChangePasswordAtLogon:$False -Enabled:$True -ScriptPath $SCRIPT
New-ADUser -Name "Neal" -GivenName "Neal" -SamAccountName "Neal" -Path "OU=$TECH,OU=$MNT,DC=$ACN,DC=$ACN_LOC" -AccountPassword(ConvertTo-SecureString "Neal1" -AsPlainText -Force) -AccountExpirationDate "2023-06-20" -ChangePasswordAtLogon:$False -Enabled:$True -ScriptPath $SCRIPT


New-ADUser -Name "DonKeffer" -GivenName "Don" -Surname "Keffer" -SamAccountName "DonKeffer" -Path "OU=$MGMT,DC=$ACN,DC=$ACN_LOC" -AccountPassword(ConvertTo-SecureString "DonKeffer1" -AsPlainText -Force) -ChangePasswordAtLogon:$False -Enabled:$True -ScriptPath $SCRIPT
New-ADUser -Name "GarryCooper" -GivenName "Garry" -Surname "Cooper" -SamAccountName "GarryCooper" -Path "OU=$SERVPERS,OU=$MNT,DC=$ACN,DC=$ACN_LOC" -AccountPassword(ConvertTo-SecureString "GarryCooper1" -AsPlainText -Force) -ChangePasswordAtLogon:$False -Enabled:$True -ScriptPath $SCRIPT
New-ADUser -Name "WillMcAvoy" -GivenName "Will" -Surname "McAvoy" -SamAccountName "WillMcAvoy" -Path "OU=$NEWS,DC=$ACN,DC=$ACN_LOC" -AccountPassword(ConvertTo-SecureString "WillMcAvoy1" -AsPlainText -Force) -ChangePasswordAtLogon:$False -Enabled:$True -ScriptPath $SCRIPT
New-ADUser -Name "SloanSabbith" -GivenName "Sloan" -Surname "Sabbith" -SamAccountName "SloanSabbith" -Path "OU=$ACC,DC=$ACN,DC=$ACN_LOC" -AccountPassword(ConvertTo-SecureString "SloanSabbith1" -AsPlainText -Force) -ChangePasswordAtLogon:$False -Enabled:$True -ScriptPath $SCRIPT
New-ADUser -Name "JimHarper" -GivenName "Jim" -Surname "Harper" -SamAccountName "JimHarper" -Path "OU=$ADV,DC=$ACN,DC=$ACN_LOC" -AccountPassword(ConvertTo-SecureString "JimHarper1" -AsPlainText -Force) -ChangePasswordAtLogon:$False -Enabled:$True -ScriptPath $SCRIPT
