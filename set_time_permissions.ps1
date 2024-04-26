Function Set-LogonHours {
  [CmdletBinding()]
  Param(
    [Parameter(Mandatory=$True)]
    [ValidateRange(0,23)]
    $TIME_IN_24_FORMAT,
    [Parameter(Mandatory=$True, ValueFromPipeline=$True, ValueFromPipelineByPropertyName=$True, Position=0)]
    $IDENTITY,
    [parameter(Mandatory=$False)]
    [ValidateSet("WorkingDays", "NonWorkingDays")]
    $NonSelectedDaysare="NonWorkingDays",
    [Parameter(Mandatory=$False)][Switch]$SUNDAY,
    [Parameter(Mandatory=$False)][Switch]$MONDAY,
    [Parameter(Mandatory=$False)][Switch]$TUESDAY,
    [Parameter(Mandatory=$False)][Switch]$WEDNESDAY,
    [Parameter(Mandatory=$False)][Switch]$THURSDAY,
    [Parameter(Mandatory=$False)][Switch]$FRIDAY,
    [Parameter(Mandatory=$False)][Switch]$SATURDAY
  )
  Process {
    $ACCESS_MASK = New-Object "byte[]" 21
    $FULL_DAY = [ordered]@{}
    0..23 | Foreach {$FULL_DAY.Add($_,"0")}
    $TIME_IN_24_FORMAT.ForEach({$FULL_DAY[$_] = 1})
    $WORKING = -join ($FULL_DAY.values)
    Switch ($PSBoundParameters["NonSelectedDaysare"]) {
      'NonWorkingDays' {
        $SUNDAY_VALUE=$MONDAY_VALUE=$TUESDAY_VALUE=$WEDNESDAY_VALUE=$THURSDAY_VALUE=$FRIDAY_VALUE=$SATURDAY_VALUE = "000000000000000000000000"
      }
      'WorkingDays' {
        $SUNDAY_VALUE=$MONDAY_VALUE=$TUESDAY_VALUE=$WEDNESDAY_VALUE=$THURSDAY_VALUE=$FRIDAY_VALUE=$SATURDAY_VALUE = "111111111111111111111111"
      }
    }
    Switch ($PSBoundParameters.Keys) {
    'Sunday' {$SUNDAY_VALUE = $WORKING}
    'Monday' {$MONDAY_VALUE = $WORKING}
    'Tuesday' {$TUESDAY_VALUE = $WORKING}
    'Wednesday' {$WEDNESDAY_VALUE = $WORKING}
    'Thursday' {$THURSDAY_VALUE = $WORKING}
    'Friday' {$FRIDAY_VALUE = $WORKING}
    'Saturday' {$SATURDAY_VALUE = $WORKING}
    }
    $WEEK = "{0}{1}{2}{3}{4}{5}{6}" -f $SUNDAY_VALUE,$MONDAY_VALUE,$TUESDAY_VALUE,$WEDNESDAY_VALUE,$THURSDAY_VALUE,$FRIDAY_VALUE,$SATURDAY_VALUE
    
    # Timezone Check
		if ((Get-TimeZone).baseutcoffset.hours -lt 0) {
		  $TIMEZONE_OFFSET = $WEEK.Substring(0,168 + ((Get-TimeZone).baseutcoffset.hours))
      $TIMEZONE_OFFSET1 = $WEEK.SubString(168 + ((Get-TimeZone).baseutcoffset.hours))
      $FIXED_TIMEZONE_OFFSET = "$TIMEZONE_OFFSET1$TIMEZONE_OFFSET"
    }

    if ((Get-TimeZone).baseutcoffset.hours -gt 0) {
      $TIMEZONE_OFFSET = $WEEK.Substring(0,((Get-TimeZone).baseutcoffset.hours))
      $TIMEZONE_OFFSET1 = $WEEK.SubString(((Get-TimeZone).baseutcoffset.hours))
      $FIXED_TIMEZONE_OFFSET = "$TIMEZONE_OFFSET1$TIMEZONE_OFFSET"
    }
    if ((Get-TimeZone).baseutcoffset.hours -eq 0){
      $FIXED_TIMEZONE_OFFSET = $WEEK
    }
    $I = 0
    $BINARY_RESULT = $FIXED_TIMEZONE_OFFSET -split '(\d{8})' | Where {$_ -match '(\d{8})'}
    Foreach($SINGLE_BYTE in $BINARY_RESULT) {
      $TMP = $SINGLE_BYTE.tochararray()
      [array]::Reverse($TMP)
      $TMP = -join $TMP
      $BYTE = [Convert]::ToByte($TMP, 2)
      $ACCESS_MASK[$I] = $BYTE
      $I++
    }
    Set-ADUser  -Identity $IDENTITY -Replace @{logonhours = $ACCESS_MASK}
  }
}

$ACN="acn"
$ACN_LOC="local"
$ACC="Accounting"
$MGMT="Management"
$NEWS="News"
$ADV="Advertisement"
$MNT="Maintenance"
$TECH="Tech Support"
$SERVPERS="Service Personnel"

Get-ADUser -Filter * -SearchBase "OU=$ACC,DC=$ACN,DC=$ACN_LOC" -SearchScope Subtree | Set-LogonHours -TIME_IN_24_FORMAT @(9,10,11,12,13,14,15,16,17) -MONDAY -TUESDAY -WEDNESDAY -THURSDAY -FRIDAY -NonSelectedDaysare NonWorkingDays
Get-ADUser -Filter * -SearchBase "OU=$MGMT,DC=$ACN,DC=$ACN_LOC" -SearchScope Subtree | Set-LogonHours -TIME_IN_24_FORMAT @(9,10,11,12,13,14,15,16,17) -MONDAY -TUESDAY -WEDNESDAY -THURSDAY -FRIDAY -NonSelectedDaysare NonWorkingDays
Get-ADUser -Filter * -SearchBase "OU=$NEWS,DC=$ACN,DC=$ACN_LOC" -SearchScope Subtree | Set-LogonHours -TIME_IN_24_FORMAT @(9,10,11,12,13,14,15,16,17) -MONDAY -TUESDAY -WEDNESDAY -THURSDAY -FRIDAY -NonSelectedDaysare NonWorkingDays
Get-ADUser -Filter * -SearchBase "OU=$ADV,DC=$ACN,DC=$ACN_LOC" -SearchScope Subtree | Set-LogonHours -TIME_IN_24_FORMAT @(9,10,11,12,13,14,15,16,17) -MONDAY -TUESDAY -WEDNESDAY -THURSDAY -FRIDAY -NonSelectedDaysare NonWorkingDays
Get-ADUser -Filter * -SearchBase "OU=$SERVPERS,OU=$MNT,DC=$ACN,DC=$ACN_LOC" -SearchScope Subtree | Set-LogonHours -TIME_IN_24_FORMAT @(9,10,11,12,13,14,15,16,17) -MONDAY -TUESDAY -WEDNESDAY -THURSDAY -FRIDAY -NonSelectedDaysare NonWorkingDays
Get-ADGroupMember -Identity "AccountManagers" -Partition "DC=acn,DC=local" -Recursive | Set-LogonHours -TIME_IN_24_FORMAT @(8,9,10,11,12,13,14,15,16,17,18,19,20,21) -SUNDAY -MONDAY -TUESDAY -WEDNESDAY -THURSDAY -FRIDAY -SATURDAY -NonSelectedDaysare NonWorkingDays
Get-ADGroupMember -Identity "HelpDesk" -Partition "DC=acn,DC=local" -Recursive | Set-LogonHours -TIME_IN_24_FORMAT @(8,9,10,11,12,13,14,15,16,17,18,19,20,21) -SUNDAY -MONDAY -TUESDAY -WEDNESDAY -THURSDAY -FRIDAY -SATURDAY -NonSelectedDaysare NonWorkingDays
Get-ADGroupMember -Identity "ResourceAdmins" -Partition "DC=acn,DC=local" -Recursive | Set-LogonHours -TIME_IN_24_FORMAT @(8,9,10,11,12,13,14,15,16,17,18,19,20,21) -SUNDAY -MONDAY -TUESDAY -WEDNESDAY -THURSDAY -FRIDAY -SATURDAY -NonSelectedDaysare NonWorkingDays
Get-ADGroupMember -Identity "GeneralAdmins" -Partition "DC=acn,DC=local" -Recursive | Set-LogonHours -TIME_IN_24_FORMAT @(0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23) -NonSelectedDaysare WorkingDays