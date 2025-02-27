
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

function Get-SystemStartShutdown {
    param (
        [Parameter(Mandatory=$true)]
        [int]$Days
    )

    $eventRecords = @()

    $events = Get-EventLog -LogName System -After (Get-Date).AddDays(-$Days) 

    $events | Where-Object { $_.EventId -eq 6005 -or $_.EventId -eq 6006 } | ForEach-Object {
        $eventType = if ($_.EventId -eq 6005) { "System Start" } else { "System Shutdown" }

        $eventObject = [PSCustomObject]@{
            Time = $_.TimeGenerated
            Id = $_.EventId
            Event = $eventType
            User = "System"
        }

        $eventRecords += $eventObject
    }

    return $eventRecords
}

#Put number of days in days variable.
$days = 100
$eventList = Get-LoginLogoff -Days $days
$eventList

$systemEvents = Get-SystemStartShutdown -Days $days
$systemEvents