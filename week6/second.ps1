. C:\Users\champuser\SYS320-01\week4\ApacheLogs1.ps1
. C:\Users\champuser\SYS320-01\week6\Event-Log.ps1
. C:\Users\champuser\SYS320-01\week2\Untitled2.ps1

clear

$Prompt = "`n"
$Prompt += "1 - Display last 10 Apache logs.`n"
$Prompt += "2 - Display last 10 failed logins for all users.`n"
$Prompt += "3 - Display at risk users.`n"
$Prompt += "4 - Start Chrome web browser if not already running.`n"
$Prompt += "5 - Exit.`n"

$operation = $true

while($operation){

    Write-Host $Prompt | Out-String
    $choice = Read-Host

    if($choice -eq 5){
        Write-Host "Seeya!" | Out-String
        exit
        $operation = $false
    }

    elseif($choice -eq 1){
        Write-Host "Fetching last 10 Apache logs..."
        ApacheLogs1 | Select-Object -First 10 | Format-Table
    }

    elseif($choice -eq 2){
        Write-Host "Fetching last 10 failed logins..."
        getFailedLogins 1 | Select-Object -First 10 | Format-Table
    }

    elseif($choice -eq 3){
        Write-Host "Fetching at-risk users..."
        listAtRiskUsers | Format-Table 
    }

    elseif($choice -eq 4){
        manageChromeProcess
    }

    else {
        Write-Host "Invalid option. Please try again."
    }

}
    