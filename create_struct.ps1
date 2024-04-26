Import-Module ActiveDirectory

$ACN="acn"
$ACN_LOC="local"
$MNT="Maintenance"
$TECH="Tech Support"
$SERVPERS="Service Personnel"

New-ADOrganizationalUnit -Name "Accounting" -Path "DC=$ACN,DC=$ACN_LOC"
New-ADOrganizationalUnit -Name "Management" -Path "DC=$ACN,DC=$ACN_LOC"
New-ADOrganizationalUnit -Name "News" -Path "DC=$ACN,DC=$ACN_LOC"
New-ADOrganizationalUnit -Name "Advertisement" -Path "DC=$ACN,DC=$ACN_LOC"
New-ADOrganizationalUnit -Name $MNT -Path "DC=$ACN,DC=$ACN_LOC"
New-ADOrganizationalUnit -Name $TECH -Path "OU=$MNT,DC=$ACN,DC=$ACN_LOC"
New-ADOrganizationalUnit -Name $SERVPERS -Path "OU=$MNT,DC=$ACN,DC=$ACN_LOC"