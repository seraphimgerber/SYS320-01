$eventRecords = @()

$events = Get-EventLog -LogName Security -InstanceID 4624, 4634 -After (Get-Date).AddDays(-14) | 
Select-Object TimeGenerated, InstanceId, Message

foreach ($event in $events) {
    $eventType = if ($event.InstanceId -eq 4624) { "Logon" } else { "Logoff" }
    $user = if ($event.ReplacementStrings.Count -gt 5) { $event.ReplacementStrings[5] } else { "Unknown" }
    $eventObject = [PSCustomObject]@{
        Time = $event.TimeGenerated
        Id = $event.InstanceId
        Event = $eventType
        User = $user
    }

    $eventRecords += $eventObject
}

$eventRecords