
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

$events = Get-EventLog -LogName System -InstanceID 7001, 7002 -After (Get-Date).AddDays(-14) 

foreach ($event in $events) {
    $eventType = if ($event.InstanceId -eq 7001) { "Logon" } else { "Logoff" }
    $Sid = $event.ReplacementStrings[1]
    $username = Convert-Sid -Sid $Sid

    $eventObject = [PSCustomObject]@{
        Time = $event.TimeGenerated
        Id = $event.InstanceId
        Event = $eventType
        User = $username
    }

    $eventRecords += $eventObject
}

$eventRecords