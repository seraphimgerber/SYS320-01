function ApacheLogs1 {
$logsNotFormatted = Get-Content -Path C:\xampp\apache\logs\access.log
$tableRecords = @()

for($i=0; $i -lt $logsNotFormatted.Count; $i++) {

$words = $logsNotformatted[$i].Split(" ");

 $tableRecords += [PSCustomObject]@{
   "IP" = $words[0];
   "Time" = $words[3];
   "Method" = $words[5];
   "Page" = $words[6];
   "Protocol" = $words[7];
   "Response" = $words[8];
   "Referrer" = $words[9];
   "Client" = $words[10]; }
}
return $tableRecords | Where-Object { $_.IP -match '10.*' }
}
$tableRecords = ApacheLogs1
$tableRecords | Format-Table -AutoSize -Wrap
