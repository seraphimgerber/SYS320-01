clear

$configFile = "configuration.txt"

function readConfig {
    if (Test-Path $configFile) {
        $content = Get-Content $configFile
        $configObject = [PSCustomObject]@{
            "Days" = $content[0]
            "ExecutionTime" = $content[1]
        }
        return $configObject
    } else {
        Write-Host "Configuration file not found. Creating a new configuration!"
        "7`n12:00 PM" | Set-Content $configFile
        return readConfig
    }
}

function changeConfig {
    do {
        $newDays = Read-Host "Enter the number of days for which the logs will be obtained: "
    } while ($newDays -notmatch "^\d+$")

    do {
        $newExecutionTime = Read-Host "Enter the execution time for the script daily: "
    } while ($newExecutionTime -notmatch "^\d{1,2}:\d{2} (AM|PM)$")

    @("$newDays", "$newExecutionTime") | Set-Content $configFile

    Write-Host "Configuration successfully updated!"
}

$Prompt = "Please choose your operation:`n"
$Prompt += "1 - Show configuration`n"
$Prompt += "2 - Change Configuration`n"
$Prompt += "3 - Exit`n"

$operation = $true

while($operation){

    Write-Host $Prompt | Out-String
    $choice = Read-Host "Enter your choice: "

    if($choice -eq 3){
        Write-Host "Seeya!" | Out-String
        exit
        $operation = $false
    }

    elseif($choice -eq 1){
       $config = readConfig
       Write-Host "Current Configuration:"
       $config | Format-Table -AutoSize
    }

    elseif($choice -eq 2){
       changeConfig
    }

    else {
        Write-Host "Invalid option. Please try again."
    }

}
