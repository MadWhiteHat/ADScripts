Import-Module ActiveDirectory

$ACN="acn"
$ACN_LOC="local"
$ACC_MGRS="AccountManagers"
$HELP="HelpDesk"

# CC = Create a child object, DC = Delete a child object
dsacls "DC=$ACN,DC=$ACN_LOC" /I:T /G "$ACN\${ACC_MGRS}:CCDC;user"
# RC = Read security info, WD = Change security info, WO = Change owner info
dsacls "DC=$ACN,DC=$ACN_LOC" /I:S /G "$ACN\${ACC_MGRS}:RCWDWO;;user"
# CA = Control access, LO = List of the object access
dsacls "DC=$ACN,DC=$ACN_LOC" /I:S /G "$ACN\${ACC_MGRS}:CALO;;user"
# RP = Read property, WP = Write property
dsacls "DC=$ACN,DC=$ACN_LOC" /I:S /G "$ACN\${ACC_MGRS}:RPWP;userAccountControl;user"
dsacls "DC=$ACN,DC=$ACN_LOC" /I:S /G "$ACN\${ACC_MGRS}:RPWP;pwdLastSet;user"

dsacls "DC=$ACN,DC=$ACN_LOC" /I:S /G "$ACN\${HELP}:RPWP;lockoutTime;user"
