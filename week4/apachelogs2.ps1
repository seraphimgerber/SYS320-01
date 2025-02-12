$notfounds = Get-Content -Path C:\xampp\apache\logs\access.log | Select-String -Pattern '404'

$regex = [regex] '\b(?:\d{1,3}\.){3}\d{1,3}\b'

$ipsUnorganized = $notfounds | ForEach-Object { $regex.Match($_).Value }

$ipCounts = $ipsUnorganized | Where-Object { $_ -ne "" } | Group-Object | Sort-Object Count -Descending

$ipCounts | Format-Table Name, Count -AutoSize
