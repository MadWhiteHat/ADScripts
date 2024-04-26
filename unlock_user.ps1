param([string]$UNIT = $(throw "Enter organization unit"))

if ($UNIT) {
    $TMP = $UNIT -split '/'

    $TMP | ForEach-Object {$PATH = "OU=$_," + $PATH}

    $PATH += "DC=acn,DC=local"
}

$LIST = Search-ADAccount -SearchBase $PATH -UsersOnly -LockedOut

if ($LIST) {
  foreach ($USER in $LIST) {
      Unlock-ADAccount -Identity $($USER.Name)
  }
} else {
    Write-Host No find locked users
}