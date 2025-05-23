﻿
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

function Get-LoginLogoff {
    param(
        [Parameter(Mandatory=$true)]
        [int]$Days
    )

    $eventRecords = @()

    $events = Get-EventLog -LogName System -InstanceID 7001, 7002 -After (Get-Date).AddDays(-$Days) 

    foreach ($event in $events) {
        $eventType = if ($event.InstanceId -eq 7001) { "Logon" } else { "Logoff" }
        $sid = $event.ReplacementStrings[1]
        $username = Convert-Sid -Sid $sid

        $eventObject = [PSCustomObject]@{
            Time = $event.TimeGenerated
            Id = $event.InstanceId
            Event = $eventType
            User = $username
        }

        $eventRecords += $eventObject
    }

    return $eventRecords
}

# Put the number of days here in $days
$days = 2
$eventList = Get-LoginLogoff -Days $days

$eventList 