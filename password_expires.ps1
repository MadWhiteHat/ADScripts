param([int]$NUMBER = 5)

$USER_EXPIRE_DATE = &Get-ADUser -filter {Enabled -eq $True -and PasswordNeverExpires -eq $False} –Properties "SamAccountName", "msDS-UserPasswordExpiryTimeComputed", "PasswordLastSet" | Select-Object –Property “SamAccountName",@{Name="ExpiryDate";Expression={[datetime]::FromFileTime($_."msDS-UserPasswordExpiryTimeComputed")}}

foreach($ITEM in $USER_EXPIRE_DATE) {
    $EXPIRE_DATE = $ITEM.ExpiryDate
    $CURRENT_DATE = &Get-Date

    $USER_NAME = $ITEM.SamAccountName

    if($CURRENT_DATE -gt $ITEM.ExpiryDate) {
       Write-Host "The password of user" $USER_NAME "has expired!"
       Exit
    }

    $LASTS = $EXPIRE_DATE - $CURRENT_DATE

    if($LASTS.Days -lt $NUMBER) {
        Write-Host "The password of user" $USER_NAME "expires less then" $Number "day(s)!"
        Write-Host "The password of user" $USER_NAME "expires: " $EXPIRE_DATE
        Write-Host " "
    }
}

