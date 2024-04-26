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
$DEP="Department"
$SCRIPT="on_logon.bat"

$USER_NAME = Read-Host -Prompt "Enter account name"
if (!$USER_NAME) {
	Write-Host "Empty user name"
	exit 0
}
$GIVEN_NAME = Read-Host -Prompt "Enter first name"
if (!$GIVEN_NAME) {
	Write-Host "Empty first name"
	exit 0
}
$SUR_NAME = Read-Host -Prompt "Enter second name"
if (!$SUR_NAME) {
	Write-Host "Empty second name"
	exit 0
}
$PASS = Read-Host -Prompt "Enter password" -AsSecureString
if (!$PASS) {
	Write-Host "Empty password is not allowed"
	exit 0
}
Write-Host $PASS
$SAM_ACC_NAME = $USER_NAME
Write-Host "1." $ACC $DEP
Write-Host "2." $MGMT $DEP
Write-Host "3." $ADV $DEP
Write-Host "4." $NEWS $DEP
Write-Host "5." $TECH $DEP
Write-Host "6." $SERVPERS $DEP
$CHOICE = Read-Host -Prompt "Choose Department"
switch ($CHOICE) {
	1 { $CHOSEN_DEP=$ACC; Break }
	2 { $CHOSEN_DEP=$MGMT; Break }
	3 { $CHOSEN_DEP=$ADV; Break }
	4 { $CHOSEN_DEP=$NEWS; Break }
	5 { $CHOSEN_DEP=$TECH; Break }
	6 { $CHOSEN_DEP=$SERVPERS; Break }
	Default {
		Write-Host "Wrong input"
		exit 0
	}
}

if ($CHOSEN_DEP -eq $TECH -or $CHOSEN_DEP -eq $SERVPERS) {
	New-ADUser -Name $USER_NAME -GivenName $GIVEN_NAME -Surname $SUR_NAME -SamAccountName $SAM_ACC_NAME -Path "OU=$CHOSEN_DEP,OU=$MNT,DC=$ACN,DC=$ACN_LOC" -AccountPassword $PASS -Enabled:$True -ScriptPath $SCRIPT
} else {
	New-ADUser -Name $USER_NAME -GivenName $GIVEN_NAME -Surname $SUR_NAME -SamAccountName $SAM_ACC_NAME -Path "OU=$CHOSEN_DEP,DC=$ACN,DC=$ACN_LOC" -AccountPassword $PASS -Enabled:$True -ScriptPath $SCRIPT
}