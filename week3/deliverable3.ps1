
function Convert-Sid {
    param(
        [Parameter(Mandatory=$true)]
        [string]$Sid
    )

    try {
        $securityIdentifier = New-Object System.Security.Principal.SecurityIdentifier($Sid)
        $ntAccount = $securityIdentifier.Translate([System.Security.Principal.NTAccount])
        return $ntAccount.Value
        }
        catch {
            return $Sid
            }
        }

$eventRecords = @()

$events = Get-EventLog -LogName Security -InstanceID 4624, 4634 -After (Get-Date).AddDays(-14) 

foreach ($event in $events) {
    $eventType = if ($event.InstanceId -eq 4624) { "Logon" } else { "Logoff" }
    $sid = $event.ReplacementStrings[4]
    $username = Convert-Sid -Sid $sid

    $eventObject = [PSCustomObject]@{
        Time = $event.TimeGenerated
        Id = $event.InstanceId
        Event = $eventType
        User = $username
    }

    $eventRecords += $eventObject
}

$eventRecords