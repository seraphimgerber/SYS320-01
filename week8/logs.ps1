function Get-IOCLogs {

    $logFilePath = "C:\Users\champuser\Downloads\access.log"
    $notfounds = Get-Content -Path $logFilePath | Select-String -Pattern 'et\cpasswd|cmd=\/bin/bash|/bin/sh|1=1#|1=1--'
    $logRegex = [regex] '^(?<IP>\d+\.\d+\.\d+\.\d+) - - \[(?<Time>[^\]]+)\] "(?<Method>[A-Z]+) (?<Page>.*?) (?<Protocol>HTTP/{\d\.]+)" (?<ResponseCode>\d+) \d+ "(?<Referrer>. *?)"'

    $logData = @()

    foreach ($entry in $notfounds) {
        if ($logRegex.IsMatch($entry.Line)) {
            $match = $logRegex.Match($entry.Line)
            $logObject = [PSCustomObject]@{
                IP = $match.Groups['IP'].Value
                Time = $match.Groups['Time'].Value
                Method = $match.Groups['Method'].Value
                Page = $match.Groups['Page'].Value
                Protocol = $match.Groups['Protocol'].Value
                ResponseCode = $match.Groups['ResponseCode'].Value
                Referrer = $match.Groups['Referrer'].Value
            }

            $logData += $logObject
        }
    }

    $logData | Format-Table
}

Get-IOCLogs