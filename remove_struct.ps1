Import-Module ActiveDirectory

$ACN="acn"
$ACN_LOC="local"
$MNT="Maintenance"
$TECH="Tech Support"
$SERVPERS="Service Personnel"

Get-ADOrganizationalUnit -Identity "OU=Accounting,DC=acn,DC=local" | Set-ADObject -ProtectedFromAccidentalDeletion:$False -PassThru | Remove-ADOrganizationalUnit -Confirm:$False
Get-ADOrganizationalUnit -Identity "OU=Management,DC=acn,DC=local" | Set-ADObject -ProtectedFromAccidentalDeletion:$False -PassThru | Remove-ADOrganizationalUnit -Confirm:$False
Get-ADOrganizationalUnit -Identity "OU=News,DC=acn,DC=local" | Set-ADObject -ProtectedFromAccidentalDeletion:$False -PassThru | Remove-ADOrganizationalUnit -Confirm:$False
Get-ADOrganizationalUnit -Identity "OU=Advertisement,DC=acn,DC=local" | Set-ADObject -ProtectedFromAccidentalDeletion:$False -PassThru | Remove-ADOrganizationalUnit -Confirm:$False
Get-ADOrganizationalUnit -Identity "OU=$TECH,OU=$MNT,DC=acn,DC=local" | Set-ADObject -ProtectedFromAccidentalDeletion:$False -PassThru | Remove-ADOrganizationalUnit -Confirm:$False
Get-ADOrganizationalUnit -Identity "OU=$SERVPERS,OU=$MNT,DC=acn,DC=local" | Set-ADObject -ProtectedFromAccidentalDeletion:$False -PassThru | Remove-ADOrganizationalUnit -Confirm:$False
Get-ADOrganizationalUnit -Identity "OU=$MNT,DC=acn,DC=local" | Set-ADObject -ProtectedFromAccidentalDeletion:$False -PassThru | Remove-ADOrganizationalUnit -Confirm:$False