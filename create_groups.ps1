Import-Module ActiveDirectory

$ACN="acn"
$ACN_LOC="local"
$MNT="Maintenance"
$TECH="Tech Support"
$ADMINS="GeneralAdmins"

New-ADGroup -Name $ADMINS -GroupCategory Security -GroupScope Global -Path "OU=$TECH,OU=$MNT,DC=$ACN,DC=$ACN_LOC"
New-ADGroup -Name "AccountManagers" -GroupCategory Security -GroupScope Global -ManagedBy $ADMINS -Path "OU=$TECH,OU=$MNT,DC=$ACN,DC=$ACN_LOC"
New-ADGroup -Name "HelpDesk" -GroupCategory Security -GroupScope Global -ManagedBy $ADMINS -Path "OU=$TECH,OU=$MNT,DC=$ACN,DC=$ACN_LOC"
New-ADGroup -Name "ResourceAdmins" -GroupCategory Security -GroupScope Global -ManagedBy $ADMINS -Path "OU=$TECH,OU=$MNT,DC=$ACN,DC=$ACN_LOC"