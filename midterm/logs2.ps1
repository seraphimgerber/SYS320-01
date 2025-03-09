function Get-IOCLogs2 {
    param(
      [string]$logFilePath,
     [string[]]$indicators
    )

    $notfounds = Get-Content -Path $logFilePath
    $logRegex = [regex] '^(?<IP>\d+\.\d+\.\d+\.\d+) - - \[(?<Time>[^\]]+)\] "(?<Method>[A-Z]+) (?<Page>.*?) (?<Protocol>HTTP/[\d\.]+)" (?<ResponseCode>\d+) \d+ "(?<Referrer>. *?)"'
    
    $logData = @()

    foreach ($entry in $notfounds) {
        if ($logRegex.IsMatch($entry)) {
            $match = $logRegex.Match($entry)
            $page = $match.Groups['Page'].Value

            foreach ($indicator in $indicators) {
                if ($page -match $indicator) {
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

                break
                }
            }
        }
    }

    $logData | Format-Table
}

$indicators = @('etc/passwd', 'cmd=/bin/bash', '/bin/sh', '1=1#', '1=1--' #inputs go here
$logFilePath = "C:\Users\champuser\Downloads\access.log"

Get-IOCLogs2 -logFilePath $logFilePath -indicators $indicators | Format-Table

