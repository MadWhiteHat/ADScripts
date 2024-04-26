Import-Module ActiveDirectory

Add-ADGroupMember -Identity "GeneralAdmins" -Members ElliotAlderson
Add-ADGroupMember -Identity "AccountManagers" -Members Lucas
Add-ADGroupMember -Identity "HelpDesk" -Members Neal
Add-ADGroupMember -Identity "ResourceAdmins" -Members TyrellWelleck

Add-ADGroupMember -Identity Administrators -Members "GeneralAdmins"
Add-ADGroupMember -Identity IIS_IUSRS "ResourceAdmins"