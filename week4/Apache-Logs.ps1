function Get-ApacheLogIPs {
    param (
        [string]$Page,
        [string]$HttpCode,
        [string]$Browser
    )

    $logFile = "C:\xampp\apache\logs\access.log"

    $notfounds = Get-Content -Path $logFile | Where-Object {
        ($_ -ilike "*$Page*") -and ($_ -match "\b$HttpCode\b") -and ($_ -ilike "*Browser*")
    }

    $ipsUnorganized = $notfounds | ForEach-Object {
        ($_ -split '\s+')[0]
    }

    $ipCounts = $ipsUnorganized | Where-Object { $_ -ne "" } | Group-Object | Sort-Object Count -Descending

    if ($ipCounts) {
        Write-Host "IP addresses that visited '$Page' using '$Browser' and got HTTP response '$HttpCode':`n" 
        $ipCounts | Format-Table Name, Count -AutoSize
    } else {
        Write-Host "No matching logs found for '$Page', HTTP Code: '$HttpCode', Browser: '$Browser'."
    }
}